class Employee {
  final String employeeName;
  final int age;

  Employee({required this.employeeName, required this.age});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeName: json['employee_name'],
      age: json['employee_age'],
    );
  }
}
