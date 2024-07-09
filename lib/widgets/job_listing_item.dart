import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/job.dart';

class JobListingItem extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String description;
  final String jobUrl;

  const JobListingItem(
      {super.key,
      required this.title,
      required this.company,
      required this.location,
      required this.description,
      required this.jobUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final jobInstance = Provider.of<Job>(context, listen: false);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: InkWell(
        onTap: () => jobInstance.launchURL(
            "https://jordanlopez546.github.io/Jordan/"), // Leave it as the default,
        // when you set it up completely, you change it to the updated Url
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: const Color.fromRGBO(0, 76, 159, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                "Company: $company",
                style: TextStyle(
                  fontSize: screenWidth * 0.043,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Location: $location",
                style: TextStyle(
                  fontSize: screenWidth * 0.043,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Role: $description",
                style: TextStyle(
                  fontSize: screenWidth * 0.043,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 76, 159, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
