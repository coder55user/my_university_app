import 'package:app_excle/core/components/snack_bar.dart';
import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/features/quiz/cubit/quiz_cubit.dart';
import 'package:app_excle/features/quiz/pages/add_quiz_screen.dart';
import 'package:app_excle/features/students/data/controller/method_helper.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/data/quiz_controller.dart';
import 'package:app_excle/features/subject/presentation/view/widgets/base_section_subject.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class QuizSubjectScreen extends StatelessWidget {
  const QuizSubjectScreen({
    super.key,
    required this.data,
  });
  final SubjectModel data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(quizController: QuizController()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            MethodStudentHelper.getCountOfSection(
              baseDocsIdSubject: data.id!,
              collectionName: "quizzes",
            ).then((value) {
              if (value >= 3) {
                SnackBarMessage.showQuickAlert(
                  message: "You Can Create more than 4 quizzes",
                  context: context,
                  contentType: QuickAlertType.warning,
                );
              } else {
                NavigatorManager.navigateTo(
                  context: context,
                  page: AddQuizScreen(data: data),
                );
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //body
              BaseBodyViewSectionSubject(
                baseIdDocsSubject: data.id!,
                nameCollectionSection: "quizzes",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
