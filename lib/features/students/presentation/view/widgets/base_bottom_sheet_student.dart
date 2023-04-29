import 'package:app_excle/core/components/base_my_text.dart';
import 'package:app_excle/core/components/base_table.dart';
import 'package:app_excle/features/students/data/controller/update_student_controller.dart';
import 'package:app_excle/features/students/presentation/cubit/get_all_student/get_student_cubit.dart';
import 'package:app_excle/features/students/presentation/cubit/update_student/update_student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBottomSheetStudent extends StatelessWidget {
  BaseBottomSheetStudent({
    super.key,
    required this.idDocsQuizSection,
    required this.baseIdDocsSubject,
    required this.idDocsStudent,
    required this.nameCollectionSection,
  });
  final String idDocsQuizSection;
  final String idDocsStudent;
  final String baseIdDocsSubject;
  final String nameCollectionSection;
  double sum = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateStudentCubit(
          updateStudentController: UpdateStudentController()),
      child: BlocBuilder<StoreStudentCubit, StoreStudentState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BaseTable(
              firstChildren: [
                for (int i = 0; i < state.dataQuestionSection.length; i++)
                  BaseMyText(title: "${state.dataQuestionSection[i].name} "),
                BaseMyText(title: "total".toUpperCase()),
              ],
              secondChildren: [
                for (int i = 0; i < state.dataQuestionSection.length; i++)
                  _myInput(
                    hintText: "${state.dataQuestionSection[i].degree}",

                    //passing data
                    baseIdDocsSubject: baseIdDocsSubject,
                    idDocsStudent: idDocsStudent,
                    nameCollectionSection: nameCollectionSection,
                    idDocsQuizSection: idDocsQuizSection,
                    idDocsOfQuestionUpdate:
                        state.dataQuestionSection[i].idDocs!,
                    newKey: state.dataQuestionSection[i].name!,
                  ),
                _myInput(
                  readOnly: true,
                  hintText: "${state.sumOfQuiz}",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _myInput extends StatelessWidget {
  _myInput({
    super.key,
    this.hintText,
    this.baseIdDocsSubject = "",
    this.idDocsStudent = "",
    this.idDocsOfQuestionUpdate = "",
    this.idDocsQuizSection = "",
    this.nameCollectionSection = "",
    this.newKey = "",
    this.readOnly = false,
  });
  String? hintText;
  final String idDocsStudent;
  final String baseIdDocsSubject;
  final String idDocsQuizSection;
  final String nameCollectionSection;
  final String idDocsOfQuestionUpdate;
  final String newKey;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateStudentCubit, UpdateStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return TextField(
          readOnly: readOnly,
          keyboardType: TextInputType.number,
          autofocus: false,
          onChanged: (val) {
            print(val);
            UpdateStudentCubit.get(context).updateStudentDegree(
              idDocsStudent: idDocsStudent,
              baseIdDocsSubject: baseIdDocsSubject,
              idDocsQuizSection: idDocsQuizSection,
              nameCollectionSection: nameCollectionSection,
              idDocsOfQuestionUpdate: idDocsOfQuestionUpdate,
              newDegree: double.parse(val),
              newKey: newKey,
            );
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintStyle: const TextStyle(),
            fillColor: Colors.transparent,
            hintText: hintText ?? "0.0",
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}
