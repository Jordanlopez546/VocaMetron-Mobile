import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../providers/resume.dart';

class ResumePreviewScreen extends StatelessWidget {
  static const routeName = '/resume-preview-screen';

  final String template;

  const ResumePreviewScreen({super.key, required this.template});

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  @override
  Widget build(BuildContext context) {
    final resumeData = context.watch<ResumeProvider>().resumeData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadResume(context, resumeData),
          ),
        ],
      ),
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildResumePreview(resumeData),
        ),
      ),
    );
  }

  Widget _buildResumePreview(ResumeData resumeData) {
    switch (template) {
      case 'Modern':
        return _buildModernTemplate(resumeData);
      case 'Classic':
        return _buildClassicTemplate(resumeData);
      case 'Creative':
        return _buildCreativeTemplate(resumeData);
      default:
        return _buildModernTemplate(resumeData);
    }
  }

  Widget _buildModernTemplate(ResumeData resumeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          resumeData.fullName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(resumeData.email),
        Text(resumeData.phone),
        Text(resumeData.address),
        const SizedBox(height: 16),
        const Text('Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(resumeData.summary),
        const SizedBox(height: 16),
        const Text('Education',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...resumeData.education.map((edu) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(edu.schoolName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${edu.degree} (${edu.startDate} - ${edu.endDate})'),
                const SizedBox(height: 8),
              ],
            )),
        const SizedBox(height: 16),
        const Text('Experience',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...resumeData.experience.map((exp) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exp.jobTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${exp.company} (${exp.startDate} - ${exp.endDate})'),
                Text(exp.description),
                const SizedBox(height: 8),
              ],
            )),
        const SizedBox(height: 16),
        const Text('Skills',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: resumeData.skills
              .map((skill) => Chip(label: Text(skill.skillName)))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildClassicTemplate(ResumeData resumeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          resumeData.fullName.toUpperCase(),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(resumeData.email),
        Text(resumeData.phone),
        Text(resumeData.address),
        const Divider(thickness: 2),
        const SizedBox(height: 16),
        const Text('SUMMARY',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(resumeData.summary, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        const Text('EDUCATION',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...resumeData.education.map((edu) => Column(
              children: [
                Text(edu.schoolName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(edu.degree),
                Text('${edu.startDate} - ${edu.endDate}'),
                const SizedBox(height: 8),
              ],
            )),
        const SizedBox(height: 16),
        const Text('EXPERIENCE',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...resumeData.experience.map((exp) => Column(
              children: [
                Text(exp.jobTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(exp.company),
                Text('${exp.startDate} - ${exp.endDate}'),
                Text(exp.description),
                const SizedBox(height: 8),
              ],
            )),
        const SizedBox(height: 16),
        const Text('SKILLS',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(resumeData.skills.map((skill) => skill.skillName).join(', ')),
      ],
    );
  }

  Widget _buildCreativeTemplate(ResumeData resumeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                resumeData.fullName,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(resumeData.email,
                  style: const TextStyle(color: Colors.white)),
              Text(resumeData.phone,
                  style: const TextStyle(color: Colors.white)),
              Text(resumeData.address,
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('About Me',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Text(resumeData.summary),
              const SizedBox(height: 16),
              const Text('Education',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              ...resumeData.education.map((edu) => ListTile(
                    leading: const Icon(Icons.school, color: Colors.blue),
                    title: Text(edu.schoolName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${edu.degree}\n${edu.startDate} - ${edu.endDate}'),
                  )),
              const SizedBox(height: 16),
              const Text('Experience',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              ...resumeData.experience.map((exp) => ListTile(
                    leading: const Icon(Icons.work, color: Colors.blue),
                    title: Text(exp.jobTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${exp.company}\n${exp.startDate} - ${exp.endDate}\n${exp.description}'),
                  )),
              const SizedBox(height: 16),
              const Text('Skills',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Wrap(
                spacing: 8,
                children: resumeData.skills
                    .map((skill) => Chip(
                          label: Text(skill.skillName),
                          backgroundColor: Colors.blue.withOpacity(0.1),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _downloadResume(
      BuildContext context, ResumeData resumeData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(resumeData.fullName),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/resume.pdf");
    await file.writeAsBytes(await pdf.save());

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resume downloaded to ${file.path}')),
    );
  }
}
