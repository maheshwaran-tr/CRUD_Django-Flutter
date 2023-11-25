from django.shortcuts import get_object_or_404
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Student
from .serializers import StudentSerializer
from rest_framework import status
from rest_framework import serializers


@api_view(["GET"])
def test_api(request):
    return Response({"Succcess": "You are in Testing"})


@api_view(["POST"])
def add_student(request):
    student = StudentSerializer(data=request.data)

    # validating for already existing data
    if Student.objects.filter(**request.data).exists():
        raise serializers.ValidationError("This data already exists")

    if student.is_valid():
        student.save()
        return Response(student.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)


@api_view(["GET"])
def read_students(request):
    if request.query_params:
        students = Student.objects.filter(**request.query_params.dict())
    else:
        students = Student.objects.all()

    if students:
        serializer = StudentSerializer(students, many=True)
        return Response(serializer.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
@api_view(["POST"])
def update_student(request,roll_no):
    student = Student.objects.get(rollno = roll_no)
    data = StudentSerializer(instance=student,data=request.data)
    
    if data.is_valid():
        data.save()
        return Response(data.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)

@api_view(["DELETE"])
def delete_student(request,roll_no):
    student = get_object_or_404(Student, rollno=roll_no)
    
	# Serialize the student data before deletion
    serializer = StudentSerializer(student)
    student_data = serializer.data

    student.delete()
    return Response(student_data,status=status.HTTP_200_OK)