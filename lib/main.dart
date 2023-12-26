import 'dart:io';
import 'package:flutter/material.dart';
import 'home_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'api task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AgeSelectionScreen(),
    );
  }
}

class AgeSelectionScreen extends StatefulWidget {
  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  List<String> ageOptions = ['below 30', 'below 40', 'below 50', 'below 60'];
  String? selectedAge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Selection',style: TextStyle(color: Colors.purple),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              hint: Text('Select age'),
              value: selectedAge,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAge = newValue!;
                });
              },
              items: ageOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedAge != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(selectedAge!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select an age before continuing.'),
                    ),
                  );
                }
              },
              child: Text('Continue'),
            ),
            SizedBox(height: 30,),
            selectedAge != null
                ? Text('Selected Age: $selectedAge')
                : Container(),
          ],
        ),
      ),
    );
  }
}