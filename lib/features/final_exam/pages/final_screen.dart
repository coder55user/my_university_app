import 'package:app_excle/features/quiz/cubit/quiz_cubit.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/data/quiz_controller.dart';
import 'package:app_excle/features/subject/presentation/view/widgets/base_section_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalSubjectScreen extends StatelessWidget {
  const FinalSubjectScreen({
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
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //body
              // BodyViewFinal(data: data),
                  BaseBodyViewSectionSubject(
                baseIdDocsSubject: data.id!,
                nameCollectionSection: "finalExam",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
