import 'package:app_excle/core/components/base_bottom_sheet.dart';
import 'package:app_excle/core/themes/light_mode.dart';
import 'package:app_excle/features/students/presentation/cubit/get_all_student/get_student_cubit.dart';
import 'package:app_excle/features/students/presentation/view/widgets/base_bottom_sheet_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_students_screen.dart';

class BaseStudentSection extends StatelessWidget {
  const BaseStudentSection({
    super.key,
    required this.baseIdDocsSubject,
    required this.idDocsStudent,
    required this.nameCollectionSection,
    required this.nameStudent,
  });
  final String nameStudent;
  final String baseIdDocsSubject;
  final String idDocsStudent;
  final String nameCollectionSection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseCustomAppBar(title: nameStudent),
            BlocBuilder<StoreStudentCubit, StoreStudentState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      for (int i = 0; i < state.dataSectionType.length; i++)
                        Item(
                          counter: i + 1,
                          title: state.dataSectionType[i].name!,
                          onTap: () async {
                            StoreStudentCubit.get(context).getSumOfQuiz(
                              idDocsStudent: idDocsStudent,
                              baseIdDocsSubject: baseIdDocsSubject,
                              idDocsQuizSection:
                                  state.dataSectionType[i].idDocs!,
                              // nameCollectionSection: "quizzes",
                              nameCollectionSection: nameCollectionSection,
                            );
                            StoreStudentCubit.get(context)
                                .getDataQuestionSectionType(
                              idDocsStudent: idDocsStudent,
                              baseIdDocsSubject: baseIdDocsSubject,
                              idDocsQuizSection:
                                  state.dataSectionType[i].idDocs!,
                              // nameCollectionSection: "quizzes",
                              nameCollectionSection: nameCollectionSection,
                            )
                                .then((value) {
                              showBottomSheetFunction(
                                context: context,
                                child: BaseBottomSheetStudent(
                                  idDocsQuizSection:
                                      state.dataSectionType[i].idDocs!,
                                  baseIdDocsSubject: baseIdDocsSubject,
                                  idDocsStudent: idDocsStudent,
                                  // nameCollectionSection: "quizzes",
                                  nameCollectionSection: nameCollectionSection,
                                ),
                              );
                            });
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  Item({
    super.key,
    this.onTap,
    this.title,
    this.counter,
  });
  void Function()? onTap;
  final String? title;
  final int? counter;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorsManager.secondaryGray,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!.toUpperCase(),
              style: titleSmall(context),
            ),
            FittedBox(
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                child: Text(
                  "$counter",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
