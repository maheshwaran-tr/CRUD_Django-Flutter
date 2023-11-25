// ignore_for_file: prefer_final_fields, prefer_const_constructors, avoid_unnecessary_containers, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rest_api_crud/services/studentAPI.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  var _nameController = TextEditingController();
  var _rollnoController = TextEditingController();
  var _regnoController = TextEditingController();
  var _cgpaController = TextEditingController();
  var _deptController = TextEditingController();

  bool _nameValidate = false;
  bool _rollnoValidate = false;
  bool _regnoValidate = false;
  bool _cgpaValidate = false;
  bool _deptValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Student'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Enter New Student Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                  labelText: 'Name',
                  errorText: _nameValidate ? "Name can't be empty " : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _rollnoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Roll Number',
                  labelText: 'Rollno',
                  errorText: _rollnoValidate ? "Rollno can't be empty" : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _regnoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Register Number',
                  labelText: 'Regno',
                  errorText: _regnoValidate ? "Regno can't be empty" : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _cgpaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter CGPA',
                  labelText: 'CGPA',
                  errorText: _cgpaValidate ? "CGPA can't be empty" : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _deptController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Department',
                  labelText: 'Department',
                  errorText: _deptValidate ? "Department can't be empty" : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var name = _nameController.text;
                      var rollno = _rollnoController.text;
                      var regno = _regnoController.text;
                      var cgpa = _cgpaController.text;
                      var dept = _deptController.text;
                      setState(() {
                        _nameValidate =
                            _nameController.text.isEmpty ? true : false;
                        _rollnoValidate =
                            _rollnoController.text.isEmpty ? true : false;
                        _regnoValidate =
                            _regnoController.text.isEmpty ? true : false;
                        _cgpaValidate =
                            _cgpaController.text.isEmpty ? true : false;
                        _deptValidate =
                            _deptController.text.isEmpty ? true : false;
                      });
                      if (_nameValidate == false &&
                          _rollnoValidate == false &&
                          _regnoValidate == false &&
                          _cgpaValidate == false &&
                          _deptValidate == false) {
                        var result = await StudentAPI()
                            .addStudent(name, rollno, regno, cgpa, dept);
                        Navigator.pop(context, result);
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text('Save'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _nameController.text = "";
                        _rollnoController.text = "";
                        _regnoController.text = "";
                        _cgpaController.text = "";
                        _deptController.text = "";
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text('Clear')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
