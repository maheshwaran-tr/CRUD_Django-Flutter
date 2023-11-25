from django.db import models

# Create your models here.
class Student(models.Model):
    rollno = models.CharField(max_length=10,primary_key=True)
    name = models.CharField(max_length=100)
    regno = models.CharField(max_length=20)
    cgpa = models.CharField(max_length=10,null=True,blank=True)
    dept = models.CharField(max_length=100)