from django.urls import path
from . import views

urlpatterns = [
    path("test_api/", views.test_api, name="home"),
    path("addstudent/", views.add_student, name="addStudent"),
    path("getstudent/", views.read_students, name="getstudents"),
    path("updatestudent/<roll_no>/", views.update_student, name="updatestudent"),
    path("delstudent/<roll_no>/", views.delete_student, name="deletestudent"),
]
