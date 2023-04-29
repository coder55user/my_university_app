import 'package:app_excle/core/components/no_data.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/core/utils/accordion_section_custom.dart';
import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/features/students/data/controller/update_student_controller.dart';
import 'package:app_excle/features/students/presentation/cubit/delete_student/delete_student_cubit.dart';
import 'package:app_excle/features/students/presentation/cubit/get_all_student/get_student_cubit.dart';
import 'package:app_excle/features/students/presentation/view/pages/base_student_section.dart';
import 'package:app_excle/features/subject/presentation/view/widgets/option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyViewStudents extends StatelessWidget {
  const BodyViewStudents({super.key, required this.baseIdDocsSubject});
  final String baseIdDocsSubject;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteStudentCubit(
          updateStudentController: UpdateStudentController()),
      child: BlocListener<DeleteStudentCubit, DeleteStudentState>(
        listener: (context, stateDeleteCubit) {
          if (stateDeleteCubit.requestState == RequestState.Success) {
            StoreStudentCubit.get(context).getAllStudent(baseIdDocsSubject);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "All Students",
                  style:
                      TextStyle(fontFamily: AssetsFonts.medium, fontSize: 20),
                ),
              ),

              //
              BlocBuilder<StoreStudentCubit, StoreStudentState>(
                builder: (context, state) {
                  switch (state.requestStateDataStudents) {
                    //Loading
                    case RequestState.Loading:
                      return const Align(
                        child: CircularProgressIndicator(),
                      );
                    //Success
                    case RequestState.Success:
                      return state.dataStudents.isEmpty
                          ? const NoData()
                          : Expanded(
                              child: AccordionCustom(
                                children: [
                                  for (int i = 0;
                                      i < state.dataStudents.length;
                                      i++)
                                    AccordionSectionCustom.accordionSectionItem(
                                      onPressedDelete: () {
                                        DeleteStudentCubit.get(context)
                                            .deleteSubject(
                                          idDocsStudent:
                                              state.dataStudents[i].idDocs!,
                                          baseIdDocsSubject: baseIdDocsSubject,
                                        );
                                      },
                                      counter: i + 1,
                                      header: state.dataStudents[i].name!,
                                      content: Item(
                                        idDocsStudent:
                                            state.dataStudents[i].idDocs!,
                                        baseIdDocsSubject: baseIdDocsSubject,
                                        nameStudent:
                                            state.dataStudents[i].name!,
                                      ),
                                    ),
                                ],
                              ),
                            );
                    //Error
                    case RequestState.Error:
                      return const Align(child: CircularProgressIndicator());
                    default:
                      return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  Item({
    super.key,
    required this.idDocsStudent,
    required this.baseIdDocsSubject,
    required this.nameStudent,
  });
  final String nameStudent;
  final String idDocsStudent;
  final String baseIdDocsSubject;
  List<String> item = [
    "quizzes",
    "assignments",
    "laps",
    "midTermExams",
    "finalExam",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < 5; i++)
          _Item(
            idDocsStudent: idDocsStudent,
            baseIdDocsSubject: baseIdDocsSubject,
            nameCollectionSection: item[i],
            title: item[i],
            counter: i + 1,
            nameStudent: nameStudent,
          ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.idDocsStudent,
    required this.baseIdDocsSubject,
    required this.nameCollectionSection,
    required this.title,
    required this.counter,
    required this.nameStudent,
  });
  final String nameStudent;
  final String idDocsStudent;
  final String baseIdDocsSubject;
  final String nameCollectionSection;
  final String title;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return ItemOption(
      text: title,
      onTap: () {
        StoreStudentCubit.get(context)
            .getDataSectionType(
          idDocsStudent: idDocsStudent,
          baseIdDocsSubject: baseIdDocsSubject,
          idDocsNameSection: nameCollectionSection,
        )
            .then((value) {
          NavigatorManager.navigateTo(
            context: context,
            page: BaseStudentSection(
              baseIdDocsSubject: baseIdDocsSubject,
              idDocsStudent: idDocsStudent,
              nameCollectionSection: nameCollectionSection,
              nameStudent: nameStudent,
            ),
          );
        });
      },
      textAvatar: "$counter",
    );
  }
}
