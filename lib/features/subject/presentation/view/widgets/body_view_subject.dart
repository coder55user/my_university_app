import 'package:app_excle/core/components/dialogs.dart';
import 'package:app_excle/core/components/no_data.dart';
import 'package:app_excle/core/components/shimmer_base.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/core/themes/light_mode.dart';
import 'package:app_excle/core/utils/accordion_section_custom.dart';
import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/features/assignment/pages/assignment_screen.dart';
import 'package:app_excle/features/clo_subject/pages/clo_subject_screen.dart';
import 'package:app_excle/features/final_exam/pages/final_screen.dart';
import 'package:app_excle/features/lap/pages/lap_screen.dart';
import 'package:app_excle/features/mid_term/pages/mid_term_screen.dart';
import 'package:app_excle/features/quiz/pages/quiz_screen.dart';
import 'package:app_excle/features/students/presentation/cubit/get_all_student/get_student_cubit.dart';
import 'package:app_excle/features/students/presentation/view/pages/home_students_screen.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/presentation/cubit/delete/delete_subject_cubit.dart';
import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'option_item.dart';

class BodyViewSubject extends StatelessWidget {
  const BodyViewSubject({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreSubjectCubit, StoreSubjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        var data = StoreSubjectCubit.get(context).dataSubject;

        print(state.subjectRequestState);
        switch (state.subjectRequestState) {
          case RequestState.Loading:
            return BaseShimmer(
              child: AccordionCustom(
                children: [
                  for (int i = 0; i < 4; i++)
                    AccordionSectionCustom.accordionSectionItem(
                      counter: i + 1,
                      header: "",
                      content: const SizedBox(),
                    ),
                ],
              ),
            );
          case RequestState.Error:
            return const CircularProgressIndicator.adaptive();
          case RequestState.Success:
            return _MainItem(
              dataSubject: state.dataSubject,
            );
        }
      },
    );
  }
}

class _MainItem extends StatelessWidget {
  const _MainItem({super.key, required this.dataSubject});
  final List<SubjectModel> dataSubject;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Subjects",
            style: TextStyle(fontFamily: AssetsFonts.medium, fontSize: 20),
          ),
        ),
        BlocListener<DeleteSubjectCubit, DeleteSubjectState>(
          listener: (context, state) {
            if (state.requestState == RequestState.Success) {
              StoreSubjectCubit.get(context).getAllSubject();
            }
          },
          child: dataSubject.isEmpty
              ? const NoData()
              : BlocBuilder<StoreSubjectCubit, StoreSubjectState>(
                  builder: (context, state) {
                    if (state.cloReportRequestState == RequestState.Loading) {
                      return AccordionCustom(
                        children: [
                          AccordionSectionCustom.accordionSectionItem(
                            counter: 1,
                            header: "export a report Excel file pleas wait"
                                .toUpperCase(),
                            content: const SizedBox(),
                            isShimmer: true,
                          )
                        ],
                      );
                    }
                    return AccordionCustom(
                      children: [
                        for (int i = 0; i < state.dataSubject.length; i++)
                          AccordionSectionCustom.accordionSectionItem(
                            onPressedExport: () {
                              showMyDialog(
                                context: context,
                                onPressedExcel: () async {
                                  StoreSubjectCubit.get(context)
                                      .exportReportExcel(
                                    baseDocsIdSubject: dataSubject[i].id!,
                                  );
                                },
                              );
                            },
                            onPressedDelete: () {
                              DeleteSubjectCubit.get(context).deleteSubject(
                                dataSubject[i].id!,
                              );
                            },
                            counter: i + 1,
                            header: dataSubject[i].courseTitle!,
                            content: _Item(
                              data: dataSubject[i],
                              index: i,
                            ),
                          ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.index,
    required this.data,
  });
  final int index;
  final SubjectModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //students
        ItemOption(
          color: ColorsManager.color1,
          text: "Students",
          onTap: () {
            StoreStudentCubit.get(context)
                .getAllStudent(data.id!)
                .then((value) {
              NavigatorManager.navigateTo(
                context: context,
                page: HomeStudentsScreen(
                  data: data,
                ),
              );
            });
          },
          textAvatar: "1",
        ),
        //Quiz

        ItemOption(
          text: "Quiz",
          onTap: () async {
            NavigatorManager.navigateTo(
              context: context,
              page: QuizSubjectScreen(data: data),
            );
            StoreSubjectCubit.get(context).getBaseCloData(
              baseDocsIdSubject: data.id!,
            );
            StoreSubjectCubit.get(context).getCountQuizType(
              baseDocsIdSubject: data.id!,
              quizType: "quizzes",
            );
          },
          textAvatar: "2",
        ),
        //Assignment

        ItemOption(
          text: "Assignment",
          onTap: () {
            NavigatorManager.navigateTo(
              context: context,
              page: AssignmentSubjectScreen(data: data),
            );
            StoreSubjectCubit.get(context).getBaseCloData(
              baseDocsIdSubject: data.id!,
            );
            StoreSubjectCubit.get(context).getCountQuizType(
              baseDocsIdSubject: data.id!,
              quizType: "assignments",
            );
          },
          textAvatar: "3",
        ),
        //laps
        ItemOption(
          color: ColorsManager.color6,
          text: "Laps",
          onTap: () {
            NavigatorManager.navigateTo(
              context: context,
              page: LapSubjectScreen(data: data),
            );
            StoreSubjectCubit.get(context).getBaseCloData(
              baseDocsIdSubject: data.id!,
            );
            StoreSubjectCubit.get(context).getCountQuizType(
              baseDocsIdSubject: data.id!,
              quizType: "laps",
            );
          },
          textAvatar: "4",
        ),
        //Mid Term Exams
        ItemOption(
          color: ColorsManager.color4,
          text: "Mid Term Exams",
          onTap: () {
            NavigatorManager.navigateTo(
              context: context,
              page: MedTermSubjectScreen(data: data),
            );
            StoreSubjectCubit.get(context).getBaseCloData(
              baseDocsIdSubject: data.id!,
            );
            StoreSubjectCubit.get(context).getCountQuizType(
              baseDocsIdSubject: data.id!,
              quizType: "midTermExams",
            );
          },
          textAvatar: "5",
        ),

        //Final Exam
        ItemOption(
          color: ColorsManager.color5,
          text: "Final Exam",
          onTap: () {
            NavigatorManager.navigateTo(
              context: context,
              page: FinalSubjectScreen(data: data),
            );
            StoreSubjectCubit.get(context).getBaseCloData(
              baseDocsIdSubject: data.id!,
            );
            StoreSubjectCubit.get(context).getCountQuizType(
              baseDocsIdSubject: data.id!,
              quizType: "finalExam",
            );
          },
          textAvatar: "6",

          //finalExam
        ),

        //laps
        ItemOption(
          color: ColorsManager.color6,
          text: "Clos",
          onTap: () {
            NavigatorManager.navigateTo(
              context: context,
              page: CloSubjectScreen(data: data),
            );
            StoreSubjectCubit.get(context).getBaseCloData(
              baseDocsIdSubject: data.id!,
            );
          },
          textAvatar: "7",
        ),
      ],
    );
  }
}
