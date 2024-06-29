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
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                careerTitle,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 76, 159, 1),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Skills Required:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              for (var skill in skillsRequired)
                Text(
                  skill,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 30),
              const Text(
                "Technologies:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              for (var tech in technologies)
                Text(
                  tech,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 30),
              const Text(
                "Job Outlook:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                jobOutlook,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              const Text(
                "Average Salary:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                averageSalary,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              const Text(
                "Description:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
