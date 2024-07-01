import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/career_listing_item.dart';
import '../providers/career.dart';

class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<Career>(
      builder: (ctx, careerData, _) => ListView.builder(
        itemBuilder: (ctx, index) {
          final career = careerData.careers[index];
          return CareerListingItem(
            careerTitle: career['title']!,
            skillsRequired: career['skills']!,
            jobOutlook: career['outlook']!,
            averageSalary: career['salary']!,
            description: career['description']!,
            technologies: career['technologies']!,
          );
        },
        itemCount: careerData.careers.length,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      ),
    );
  }
}
