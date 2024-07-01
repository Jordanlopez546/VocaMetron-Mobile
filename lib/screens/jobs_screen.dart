import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/job_listing_item.dart';

import '../providers/job.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<Job>(
      builder: (ctx, jobData, _) => ListView.builder(
        itemBuilder: (ctx, index) {
          final job = jobData.jobs[index];
          return JobListingItem(
            title: job['title']!,
            company: job['company']!,
            location: job['location']!,
            description: job['description']!,
            jobUrl: job['url']!,
          );
        },
        itemCount: jobData.jobs.length,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      ),
    );
  }
}
