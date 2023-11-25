import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_api_crud/models/student.dart';

class StudentAPI {
  Future<List<Student>?> getAllStudents() async {
    var client = http.Client();
    //http://127.0.0.1:5000/get_student

    var uri = Uri.parse("http://10.0.2.2:5000/get_student");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return studentFromJson(jsonData);
    }
    return null;
  }

  Future<Student?> addStudent(String name, String rollno, String regno,
      String cgpa, String dept) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/add_student");
    final http.Response response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "rollno": rollno,
          "name": name,
          "regno": regno,
          "cgpa": cgpa,
          "dept": dept
        }));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return Student.fromJson(jsonDecode(jsonData));
    } else {
      throw Exception("Failed to add Student");
    }
  }

  Future<Student?> deleteStudent(String rollno) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/del_student/$rollno");
    final http.Response response = await client.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return Student.fromJson(jsonDecode(jsonData));
    } else {
      throw Exception("Failed to Delete Student");
    }
  }

  Future<Student?> updateStudent(String name, String rollno, String regno,
    String cgpa, String dept) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/update_student/$rollno");
    final http.Response response = await client.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "rollno": rollno,
          "name": name,
          "regno": regno,
          "cgpa": cgpa,
          "dept": dept
        }));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return Student.fromJson(jsonDecode(jsonData));
    } else {
      throw Exception("Failed to update Student");
    }
  }
}

