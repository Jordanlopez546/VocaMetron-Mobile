import 'package:flutter/material.dart';

import '../widgets/career_listing_item.dart';

class CareerScreen extends StatelessWidget {
  CareerScreen({super.key});

  final List<Map<String, dynamic>> careers = [
    {
      'title': 'Software Engineer',
      'skills': ['Programming', 'Problem Solving', 'Teamwork'],
      'technologies': [
        'Python',
        'JavaScript',
        'Java',
        'C++',
        'React',
        'Node.js'
      ],
      'outlook': 'Excellent',
      'salary': '\$100,000',
      'description':
          'Software engineers develop and maintain software applications...'
    },
    {
      'title': 'Data Scientist',
      'skills': ['Data Analysis', 'Machine Learning', 'Statistics'],
      'technologies': ['Python', 'R', 'SQL', 'TensorFlow', 'Pandas'],
      'outlook': 'Very Good',
      'salary': '\$120,000',
      'description':
          'Data scientists analyze large amounts of data to extract meaningful insights...'
    },
    {
      'title': 'Digital Marketer',
      'skills': ['SEO', 'Content Creation', 'Social Media Management'],
      'technologies': [
        'Google Analytics',
        'SEO Tools',
        'Hootsuite',
        'Mailchimp'
      ],
      'outlook': 'Good',
      'salary': '\$70,000',
      'description':
          'Digital marketers develop and implement strategies to promote products or services online...'
    },
    {
      'title': 'Graphic Designer',
      'skills': ['Creativity', 'Design Software', 'Communication'],
      'technologies': ['Adobe Photoshop', 'Illustrator', 'InDesign'],
      'outlook': 'Good',
      'salary': '\$50,000',
      'description':
          'Graphic designers create visual concepts to communicate ideas that inspire, inform, or captivate consumers...'
    },
    {
      'title': 'Product Manager',
      'skills': ['Leadership', 'Market Research', 'Strategic Thinking'],
      'technologies': ['JIRA', 'Confluence', 'Trello'],
      'outlook': 'Very Good',
      'salary': '\$110,000',
      'description':
          'Product managers oversee the development and lifecycle of a product, ensuring it meets market needs and business goals...'
    },
    {
      'title': 'Cybersecurity Analyst',
      'skills': ['Network Security', 'Risk Assessment', 'Ethical Hacking'],
      'technologies': ['Wireshark', 'Kali Linux', 'Metasploit'],
      'outlook': 'Excellent',
      'salary': '\$90,000',
      'description':
          'Cybersecurity analysts protect an organization’s computer systems and networks from security breaches and cyberattacks...'
    },
    {
      'title': 'Civil Engineer',
      'skills': ['Project Management', 'Structural Analysis', 'CAD Software'],
      'technologies': ['AutoCAD', 'Civil 3D', 'Revit'],
      'outlook': 'Good',
      'salary': '\$80,000',
      'description':
          'Civil engineers design, build, and maintain infrastructure projects such as roads, bridges, and water supply systems...'
    },
    {
      'title': 'UX/UI Designer',
      'skills': ['User Research', 'Prototyping', 'Wireframing'],
      'technologies': ['Sketch', 'Figma', 'Adobe XD'],
      'outlook': 'Very Good',
      'salary': '\$85,000',
      'description':
          'UX/UI designers focus on creating user-friendly interfaces that provide a seamless experience for users...'
    },
    {
      'title': 'Financial Analyst',
      'skills': ['Financial Modeling', 'Data Analysis', 'Critical Thinking'],
      'technologies': ['Excel', 'Bloomberg Terminal', 'SQL'],
      'outlook': 'Good',
      'salary': '\$75,000',
      'description':
          'Financial analysts assess the performance of stocks, bonds, and other types of investments to guide business and investment decisions...'
    },
    {
      'title': 'Biomedical Engineer',
      'skills': ['Biology', 'Engineering', 'Problem Solving'],
      'technologies': ['LabVIEW', 'MATLAB', 'SolidWorks'],
      'outlook': 'Excellent',
      'salary': '\$95,000',
      'description':
          'Biomedical engineers apply engineering principles to healthcare, designing devices, systems, and software used in medical care...'
    },
    {
      'title': 'Environmental Scientist',
      'skills': ['Data Collection', 'Environmental Policy', 'Analysis'],
      'technologies': ['GIS Software', 'R', 'Python'],
      'outlook': 'Good',
      'salary': '\$70,000',
      'description':
          'Environmental scientists study and develop policies to protect the environment and human health from environmental hazards...'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final career = careers[index];
        return CareerListingItem(
          careerTitle: career['title']!,
          skillsRequired: career['skills']!,
          jobOutlook: career['outlook']!,
          averageSalary: career['salary']!,
          description: career['description']!,
          technologies: career['technologies']!,
        );
      },
      itemCount: careers.length,
    );
  }
}
