import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/interview_tip.dart';
import '../widgets/stack_screen_appbar.dart';
import '../screens/interview_tip_detail_screen.dart';
import '../providers/profile.dart';

class InterviewTipsScreen extends StatefulWidget {
  static const routeName = '/interview-tips-screen';

  const InterviewTipsScreen({super.key});

  @override
  State<InterviewTipsScreen> createState() => _InterviewTipsScreenState();
}

class _InterviewTipsScreenState extends State<InterviewTipsScreen> {
  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  final Color _colour = const Color.fromRGBO(0, 166, 166, 1.0);

  final Color _white = Colors.white;

  bool _isLoading = false;

  Future<void> _generateTips(BuildContext context, Profile profile) async {
    final skills = profile.skills ?? '';
    final careerInterests = profile.careerInterests ?? '';
    final experiences = profile.experiences ?? '';

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<InterviewTipsProvider>(context, listen: false)
          .generateInterviewTips(skills, experiences, careerInterests);
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Failed to generate interview tips. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context, listen: false);
    final tips =
        Provider.of<InterviewTipsProvider>(context, listen: false).tips;

    return Scaffold(
      appBar: const StackScreenAppbar('Interview Tips'),
      backgroundColor: _backgroundColor,
      floatingActionButton: tips.isNotEmpty
          ? null
          : FloatingActionButton(
              backgroundColor: _colour,
              onPressed:
                  _isLoading ? null : () => _generateTips(context, profile),
              child: Icon(
                Icons.add,
                color: _white,
                size: 30,
              ),
            ),
      body: _isLoading
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
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Consumer<InterviewTipsProvider>(
                builder: (ctx, interviewTip, _) => interviewTip.tips.isEmpty
                    ? const Center(
                        child: Text(
                            'No interview tips yet. Press + button to generate interview tips.'))
                    : ListView.builder(
                        itemCount: interviewTip.tips.length,
                        itemBuilder: (ctx, index) {
                          String truncatedDescription =
                              interviewTip.tips[index].description;
                          if (truncatedDescription.length > 60) {
                            truncatedDescription =
                                "${truncatedDescription.substring(0, 60)}...";
                          }
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _colour,
                                foregroundColor: _white,
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                interviewTip.tips[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  truncatedDescription,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          InterviewTipDetailScreen(
                                              tip: interviewTip.tips[index]),
                                    ),
                                  );
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                            ),
                          );
                        },
                      ),
              ),
            ),
    );
  }
}
