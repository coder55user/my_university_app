import 'package:app_excle/core/components/snack_bar.dart';
import 'package:app_excle/core/resources/size_config.dart';
import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/features/mid_term/pages/add_mid_term_screen.dart';
import 'package:app_excle/features/quiz/cubit/quiz_cubit.dart';
import 'package:app_excle/features/students/data/controller/method_helper.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/data/quiz_controller.dart';
import 'package:app_excle/features/subject/presentation/view/widgets/base_section_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class MedTermSubjectScreen extends StatelessWidget {
  const MedTermSubjectScreen({
    super.key,
    required this.data,
  });
  final SubjectModel data;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => QuizCubit(quizController: QuizController()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           MethodStudentHelper.getCountOfSection(
              baseDocsIdSubject: data.id!,
              collectionName: "midTermExams",
            ).then((value) {
              if (value >= 2) {
                SnackBarMessage.showQuickAlert(
                  message: "You Can Create more than 4 mid Term Exams",
                  context: context,
                  contentType: QuickAlertType.warning,
                );
              } else {
                NavigatorManager.navigateTo(
                  context: context,
                  page: AddMedTermScreen(data: data),
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
              // BodyViewMedTerm(data: data),
              BaseBodyViewSectionSubject(
                baseIdDocsSubject: data.id!,
                nameCollectionSection: "midTermExams",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
