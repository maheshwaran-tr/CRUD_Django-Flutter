// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:rest_api_crud/models/student.dart';
import 'package:rest_api_crud/services/studentAPI.dart';
import 'package:rest_api_crud/views/add_student.dart';
import 'package:rest_api_crud/views/update_student.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Student>? studentList;
  var isLoaded = false;

  @override
  void initState() {
    getRecords();
    super.initState();
  }

  Future<void> getRecords() async {
    studentList = await StudentAPI().getAllStudents();
    if (studentList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> refreshData() async {
    await getRecords();
  }

  Future<void> showMessageBox(String title, String msg) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(msg),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest-API CRUD'),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: studentList?.length,
            itemBuilder: (context, index) {
              return Container(
                child: ListTile(
                  title: Text(studentList![index].name),
                  subtitle: Text(studentList![index].rollno),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdateStudent(studentList![index]),
                            ),
                          ).then((resultData) {
                            if (resultData != null) {
                              getRecords();
                              showMessageBox("Success", "$resultData Updated");
                            }
                          });
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () async {
                          Student? res = await StudentAPI()
                              .deleteStudent(studentList![index].rollno);
                          showMessageBox(
                              "Success", "$res deleted successfully");
                          getRecords();
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          ).then((resultData) {
            if (resultData != null) {
              getRecords();
              showMessageBox("Success", "$resultData Added");
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
