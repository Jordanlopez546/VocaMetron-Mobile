import 'package:flutter/material.dart';

import '../widgets/stack_screen_appbar.dart';

class CareerDetailScreen extends StatelessWidget {
  static const routeName = '/career/career-detail-screen';

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  const CareerDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Retrieve the arguments
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Extract the values from the arguments
    final String careerTitle = args['careerTitle'];
    final List<String> skillsRequired =
        List<String>.from(args['skillsRequired']);
    final String jobOutlook = args['jobOutlook'];
    final String averageSalary = args['averageSalary'];
    final String description = args['description'];
    final List<String> technologies = List<String>.from(args['techologies']);

    return Scaffold(
      appBar: const StackScreenAppbar('Career Details'),
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                careerTitle,
                style: TextStyle(
                  fontSize: screenWidth * 0.065,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(0, 76, 159, 1),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                "Skills Required:",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              for (var skill in skillsRequired)
                Text(
                  skill,
                  style: TextStyle(fontSize: screenWidth * 0.043),
                ),
              const SizedBox(height: 30),
              Text(
                "Technologies:",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              for (var tech in technologies)
                Text(
                  tech,
                  style: TextStyle(fontSize: screenWidth * 0.043),
                ),
              const SizedBox(height: 30),
              Text(
                "Job Outlook:",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                jobOutlook,
                style: TextStyle(fontSize: screenWidth * 0.043),
              ),
              const SizedBox(height: 30),
              Text(
                "Average Salary:",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                averageSalary,
                style: TextStyle(fontSize: screenWidth * 0.043),
              ),
              const SizedBox(height: 30),
              Text(
                "Description:",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: TextStyle(fontSize: screenWidth * 0.043),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
