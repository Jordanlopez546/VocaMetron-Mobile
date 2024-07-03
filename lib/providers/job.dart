import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class Job with ChangeNotifier {
  final List<Map<String, String>> _jobs = [
    {
      'title': 'Software Engineer',
      'company': 'Tech Corp',
      'location': 'New York, NY',
      'description': 'Develop and maintain software applications.',
      'url': 'https://example.com/software-engineer-job',
    },
    {
      'title': 'Product Manager',
      'company': 'Innovate Ltd',
      'location': 'San Francisco, CA',
      'description': 'Lead product development from ideation to launch.',
      'url': 'https://example.com/product-manager-job',
    },
    {
      'title': 'Data Analyst',
      'company': 'Data Insights',
      'location': 'Austin, TX',
      'description': 'Analyze and interpret complex data sets.',
      'url': 'https://example.com/data-analyst-job',
    },
    {
      'title': 'UI/UX Designer',
      'company': 'Creative Designs',
      'location': 'Los Angeles, CA',
      'description':
          'Design user interfaces and experiences for web and mobile apps.',
      'url': 'https://example.com/ui-ux-designer-job',
    },
    {
      'title': 'Marketing Specialist',
      'company': 'Digital Trends',
      'location': 'Chicago, IL',
      'description':
          'Plan and execute marketing campaigns across various channels.',
      'url': 'https://example.com/marketing-specialist-job',
    },
    {
      'title': 'Financial Analyst',
      'company': 'Finance Solutions',
      'location': 'Boston, MA',
      'description': 'Provide financial analysis and forecasting reports.',
      'url': 'https://example.com/financial-analyst-job',
    },
    {
      'title': 'Customer Support Representative',
      'company': 'HelpDesk Inc',
      'location': 'Orlando, FL',
      'description': 'Assist customers with their queries and provide support.',
      'url': 'https://example.com/customer-support-job',
    },
    {
      'title': 'Network Administrator',
      'company': 'SecureNet',
      'location': 'Seattle, WA',
      'description': 'Manage and maintain company’s network infrastructure.',
      'url': 'https://example.com/network-administrator-job',
    },
    {
      'title': 'Human Resources Manager',
      'company': 'People First',
      'location': 'Denver, CO',
      'description': 'Oversee HR operations and manage employee relations.',
      'url': 'https://example.com/hr-manager-job',
    },
    {
      'title': 'Content Writer',
      'company': 'Creative Agency',
      'location': 'Miami, FL',
      'description':
          'Create engaging and original content for various platforms.',
      'url': 'https://example.com/content-writer-job',
    },
    {
      'title': 'Sales Executive',
      'company': 'Salesforce',
      'location': 'Dallas, TX',
      'description': 'Drive sales and build relationships with clients.',
      'url': 'https://example.com/sales-executive-job',
    },
  ];

  List<Map<String, String>> get jobs {
    return [..._jobs];
  }

  Future<void> getUserJobs() async {}

  Future<void> launchURL(String url) async {
    try {
      if (await launcher.canLaunchUrl(Uri.parse(url))) {
        await launcher.launchUrl(
          Uri.parse(url),
          mode: launcher.LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw 'Error launching URL: $e';
    }
  }
}
