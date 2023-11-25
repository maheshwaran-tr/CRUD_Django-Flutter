import 'dart:convert';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  String cgpa;
  String dept;
  String name;
  String regno;
  String rollno;

  Student({
    required this.cgpa,
    required this.dept,
    required this.name,
    required this.regno,
    required this.rollno,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        rollno: json["rollno"],
        cgpa: json["cgpa"],
        dept: json["dept"],
        name: json["name"],
        regno: json["regno"]
  );

  Map<String, dynamic> toJson() => {
        "cgpa": cgpa,
        "dept": dept,
        "name": name,
        "regno": regno,
        "rollno": rollno,
      };

  @override
  String toString() {
    return rollno;
  }
}
