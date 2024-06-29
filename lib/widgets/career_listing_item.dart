import 'package:flutter/material.dart';

import '../screens/career_detail_screen.dart';

class CareerListingItem extends StatelessWidget {
  final String careerTitle, jobOutlook, averageSalary, description;

  final List<String> technologies, skillsRequired;

  const CareerListingItem(
      {super.key,
      required this.careerTitle,
      required this.skillsRequired,
      required this.jobOutlook,
      required this.averageSalary,
      required this.description,
      required this.technologies});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CareerDetailScreen.routeName, arguments: {
            'careerTitle': careerTitle,
            'skillsRequired': skillsRequired,
            'jobOutlook': jobOutlook,
            'averageSalary': averageSalary,
            'description': description,
            'techologies': technologies,
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                careerTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 76, 159, 1),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Skills Required:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              for (var skill in skillsRequired)
                Text(
                  "- $skill",
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              Text(
                "Job Outlook: $jobOutlook",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Average Salary: $averageSalary",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
