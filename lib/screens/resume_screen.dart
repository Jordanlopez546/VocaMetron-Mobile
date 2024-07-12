import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/resume.dart';
import './resume_preview_screen.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  int _currentStep = 0;
  String _selectedTemplate = 'Modern';

  void _navigateToPreview() {
    Navigator.of(context)
        .pushNamed(ResumePreviewScreen.routeName, arguments: _selectedTemplate);
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep < 5) {
          setState(() {
            _currentStep++;
          });
        } else {
          _navigateToPreview();
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) {
          setState(() {
            _currentStep--;
          });
        }
      },
      steps: _buildSteps(context),
    );
  }

  List<Step> _buildSteps(BuildContext context) {
    return [
      Step(
        title: const Text('Template'),
        content: _buildTemplateStep(context),
        isActive: _currentStep >= 0,
      ),
      Step(
          title: const Text('Personal Information'),
          content: _buildPersonalInfoStep(context),
          isActive: _currentStep >= 1),
      Step(
        title: const Text('Summary'),
        content: _buildSummaryStep(context),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: const Text('Education'),
        content: _buildEducationStep(context),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: const Text('Experience'),
        content: _buildExperienceStep(context),
        isActive: _currentStep >= 4,
      ),
      Step(
        title: const Text('Skills'),
        content: _buildSkillsStep(context),
        isActive: _currentStep >= 5,
      ),
    ];
  }

  Widget _buildTemplateStep(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedTemplate,
      items: <String>['Modern', 'Classic', 'Creative'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedTemplate = newValue;
          });
        }
      },
    );
  }

  Widget _buildPersonalInfoStep(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Full Name'),
          onChanged: (value) =>
              context.read<ResumeProvider>().updateFullName(value),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (value) =>
              context.read<ResumeProvider>().updateEmail(value),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Phone'),
          onChanged: (value) =>
              context.read<ResumeProvider>().updatePhone(value),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Address'),
          onChanged: (value) =>
              context.read<ResumeProvider>().updateAddress(value),
        ),
      ],
    );
  }

  Widget _buildSummaryStep(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(labelText: 'Summary'),
      maxLines: 5,
      onChanged: (value) => context.read<ResumeProvider>().updateSummary(value),
    );
  }

  Widget _buildEducationStep(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'School Name'),
          onChanged: (value) {
            // Save the school name to provider
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Degree'),
          onChanged: (value) {
            // Save the degree to provider
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Start Date'),
          onChanged: (value) {
            // Save the start date to provider
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'End Date'),
          onChanged: (value) {
            // Save the end date to provider
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Add education to provider
          },
          child: const Text('Add Education'),
        ),
      ],
    );
  }

  Widget _buildExperienceStep(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Job Title'),
          onChanged: (value) {
            // Save the job title to provider
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Company'),
          onChanged: (value) {
            // Save the company to provider
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Start Date'),
          onChanged: (value) {
            // Save the start date to provider
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'End Date'),
          onChanged: (value) {
            // Save the end date to provider
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Description'),
          maxLines: 5,
          onChanged: (value) {
            // Save the description to provider
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Add experience to provider
          },
          child: const Text('Add Experience'),
        ),
      ],
    );
  }

  Widget _buildSkillsStep(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Skill'),
          onChanged: (value) {
            // Save the skill to provider
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Add skill to provider
          },
          child: const Text('Add Skill'),
        ),
      ],
    );
  }
}
