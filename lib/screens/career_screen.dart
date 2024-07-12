import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/career_listing_item.dart';
import '../providers/career.dart';

class CareerScreen extends StatelessWidget {
  final bool isLoading;

  const CareerScreen(this.isLoading, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color.fromRGBO(0, 76, 159, 1),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Generating...")
              ],
            ),
          )
        : Consumer<Career>(
            builder: (ctx, careerData, _) => careerData.careers.isEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Center(
                        child: Text(
                            'No suggested career paths yet. Press + button to generate career paths.')),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      final career = careerData.careers[index];
                      return CareerListingItem(
                        careerTitle: career.title,
                        skillsRequired: career.skills,
                        jobOutlook: career.outlook,
                        averageSalary: career.salary,
                        description: career.description,
                        technologies: career.technologies,
                      );
                    },
                    itemCount: careerData.careers.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  ),
          );
  }
}
