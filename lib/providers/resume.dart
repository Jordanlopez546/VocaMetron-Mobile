import 'package:flutter/material.dart';

class ResumeData {
  String fullName;
  String email;
  String phone;
  String address;
  String summary;
  List<Education> education;
  List<Experience> experience;
  List<Skill> skills;

  ResumeData({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.summary,
    required this.education,
    required this.experience,
    required this.skills,
  });
}

class Education {
  String schoolName;
  String degree;
  String startDate;
  String endDate;

  Education({
    required this.schoolName,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });
}

class Experience {
  String jobTitle;
  String company;
  String startDate;
  String endDate;
  String description;

  Experience({
    required this.jobTitle,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
}

class Skill {
  String skillName;

  Skill({required this.skillName});
}

class ResumeProvider with ChangeNotifier {
  final ResumeData _resumeData = ResumeData(
      fullName: '',
      email: '',
      phone: '',
      address: '',
      summary: '',
      education: [],
      experience: [],
      skills: []);

  ResumeData get resumeData => _resumeData;

  void updateFullName(String fullName) {
    _resumeData.fullName = fullName;
    notifyListeners();
  }

  void updateEmail(String email) {
    _resumeData.email = email;
    notifyListeners();
  }

  void updatePhone(String phone) {
    _resumeData.phone = phone;
    notifyListeners();
  }

  void updateAddress(String address) {
    _resumeData.address = address;
    notifyListeners();
  }

  void updateSummary(String summary) {
    _resumeData.summary = summary;
    notifyListeners();
  }

  void addEducation(Education education) {
    _resumeData.education.add(education);
    notifyListeners();
  }

  void addExperience(Experience experience) {
    _resumeData.experience.add(experience);
    notifyListeners();
  }

  void addSkill(Skill skill) {
    _resumeData.skills.add(skill);
    notifyListeners();
  }
}
