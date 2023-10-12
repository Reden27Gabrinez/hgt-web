import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomerFeedbackPage extends StatefulWidget {
  const CustomerFeedbackPage({super.key});

  @override
  State<CustomerFeedbackPage> createState() => _CustomerFeedbackPageState();
}

class _CustomerFeedbackPageState extends State<CustomerFeedbackPage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('feedback').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userfeedback = snapshot.data?.docs.toList();
          List<Column> feedback = [];
          for (var feedbacks in userfeedback!) {
            final feedbackWidget = Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Color.fromARGB(255, 31, 31, 176),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(feedbacks['feedback_text']),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1),
                              child: Column(
                                children: [],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );

            feedback.add(feedbackWidget);
          }
          return ListView(children: feedback);
        } else {
          return const SpinKitCircle(
            color: Color.fromARGB(255, 31, 31, 176),
          );
        }
      },
    );
  }
}
