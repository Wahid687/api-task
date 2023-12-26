import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'employee.dart';
import 'main.dart';


class HomeScreen extends StatefulWidget {
  final String selectedAge;

  HomeScreen(this.selectedAge);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String apiUrl = 'https://dummy.restapiexample.com/api/v1/employees';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        List<Employee> tempEmployees = [];

        for (var employeeData in data) {
          Employee employee = Employee.fromJson(employeeData);
          if (employee.age < getAgeLimit(widget.selectedAge)) {
            tempEmployees.add(employee);
          }
        }

        setState(() {
          employees = tempEmployees;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  int getAgeLimit(String selectedAge) {
    switch (selectedAge) {
      case 'below 30':
        return 30;
      case 'below 40':
        return 40;
      case 'below 50':
        return 50;
      case 'below 60':
        return 60;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List',style: TextStyle(color: Colors.purple),),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(employees[index].employeeName.toString()),
            subtitle: Text('Age: ${employees[index].age.toInt()}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AgeSelectionScreen(),
            ),
          );
        },
        child: Icon(Icons.arrow_back_ios_new_sharp),
      ),
    );
  }
}
