import 'package:tunceducationn/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:tunceducationn/src/quick_access/presentation/widgets/exam_history_answer_tile.dart';
import 'package:tunceducationn/src/quick_access/presentation/widgets/exam_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamHistoryDetailsScreen extends StatelessWidget {
  const ExamHistoryDetailsScreen(this.exam, {super.key});

  static const routeName = '/exam-history-details';

  final UserExam exam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('${exam.examTitle} Details')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExamHistoryTile(exam, navigateToDetails: false),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  text: 'Date Submitted: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: DateFormat.yMMMMd().format(exam.dateSubmitted),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  itemCount: exam.answers.length,
                  separatorBuilder: (_, __) => Divider(
                    thickness: 1,
                    color: Color(0xFFE6E8EC),
                  ),
                  itemBuilder: (_, index) {
                    final answer = exam.answers[index];
                    return ExamHistoryAnswerTile(answer, index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
