import 'package:app_excle/core/components/base_bottom_sheet.dart';
import 'package:app_excle/core/components/base_progress_button.dart';
import 'package:app_excle/core/components/base_table.dart';
import 'package:app_excle/core/components/base_button.dart';
import 'package:app_excle/core/components/snack_bar.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/core/themes/light_mode.dart';
import 'package:app_excle/core/utils/accordion_section_custom.dart';
import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/core/components/custom_app_bar.dart';
import 'package:app_excle/features/clo_subject/controller/base_controller_clo.dart';
import 'package:app_excle/features/clo_subject/cubit/clo_cubit.dart';
import 'package:app_excle/features/clo_subject/widgets/bottom_sheet_clo_base_data.dart';
import 'package:app_excle/features/clo_subject/widgets/bottom_sheet_clo_knowledge.dart';
import 'package:app_excle/features/clo_subject/widgets/bottom_sheet_clo_skills.dart';
import 'package:app_excle/features/clo_subject/widgets/bottom_sheet_clo_value.dart';
import 'package:app_excle/features/students/data/controller/method_helper.dart';
import 'package:app_excle/features/students/presentation/view/pages/home_students_screen.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:quickalert/quickalert.dart';

import 'add_clo_subject_screen.dart';

class CloSubjectScreen extends StatelessWidget {
  const CloSubjectScreen({
    super.key,
    required this.data,
  });
  final SubjectModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            MethodStudentHelper.getCountOfSection(
            baseDocsIdSubject: data.id!,
            collectionName: "clos",
          ).then((value) {
            if (value >= 10) {
              SnackBarMessage.showQuickAlert(
                message: "You Can Create more than 4 clos",
                context: context,
                contentType: QuickAlertType.warning,
              );
            } else {
              NavigatorManager.navigateTo(
                context: context,
                page: AddCloSubjectScreen(data: data),
              );
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BaseCustomAppBar(title: "Clos"),

              //body
              BlocConsumer<StoreSubjectCubit, StoreSubjectState>(
                listener: (context, state) {},
                builder: (context, stateSubject) {
                  return AccordionCustom(
                    children: [
                      for (int i = 0; i < stateSubject.dataClo.length; i++)
                        AccordionSectionCustom.accordionSectionItem(
                          onPressedDelete: () {
                            CloCubit.get(context).deleteClo(
                              baseIdDocsSubjects: data.id!,
                              docsCloDelete:
                                  stateSubject.dataClo[i].baseIdDocs!,
                            );
                            StoreSubjectCubit.get(context).getBaseCloData(
                              baseDocsIdSubject: data.id!,
                            );
                          },
                          counter: i + 1,
                          header: stateSubject.dataClo[i].baseCloId!,
                          content: Column(
                            children: [
                              _BaseItem(
                                counter: "1",
                                title: "base data",
                                onTap: () {
                                  showBottomSheetFunction(
                                      context: context,
                                      child: BottomSheetCloBaseData(
                                        baseIdDocsSubjects: data.id!,
                                        cloModel: stateSubject.dataClo[i],
                                      ));
                                },
                              ),

                              //Knowledge
                              _BaseItem(
                                counter: "2",
                                title: "Knowledge",
                                onTap: () {
                                  CloCubit.get(context)
                                      .getDataCloDetail(
                                    baseIdDocsSubjects: data.id!,
                                    docsCloId:
                                        stateSubject.dataClo[i].baseIdDocs!,
                                    nameCollectionInClo: "knowledge",
                                  )
                                      .then((value) {
                                    showBottomSheetFunction(
                                      context: context,
                                      child: BottomSheetCloKnowledge(
                                        baseIdDocsSubjects: data.id!,
                                        baseIdCloDocs:
                                            stateSubject.dataClo[i].baseIdDocs,
                                      ),
                                    );
                                  });
                                },
                              ),
                              _BaseItem(
                                counter: "3",
                                title: "Skills",
                                onTap: () {
                                  CloCubit.get(context)
                                      .getDataCloDetail(
                                    baseIdDocsSubjects: data.id!,
                                    docsCloId:
                                        stateSubject.dataClo[i].baseIdDocs!,
                                    nameCollectionInClo: "skill",
                                  )
                                      .then((value) {
                                    showBottomSheetFunction(
                                      context: context,
                                      child: BottomSheetCloSKills(
                                        baseIdDocsSubjects: data.id!,
                                        baseIdCloDocs:
                                            stateSubject.dataClo[i].baseIdDocs,
                                      ),
                                    );
                                  });
                                },
                              ),
                              _BaseItem(
                                counter: "4",
                                title: "Values",
                                onTap: () {
                                  CloCubit.get(context)
                                      .getDataCloDetail(
                                    baseIdDocsSubjects: data.id!,
                                    docsCloId:
                                        stateSubject.dataClo[i].baseIdDocs!,
                                    nameCollectionInClo: "value",
                                  )
                                      .then((value) {
                                    showBottomSheetFunction(
                                        context: context,
                                        child: BottomSheetCloValue(
                                          baseIdDocsSubjects: data.id!,
                                          baseIdCloDocs: stateSubject
                                              .dataClo[i].baseIdDocs,
                                        ));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BaseItem extends StatelessWidget {
  _BaseItem({
    super.key,
    this.onTap,
    required this.title,
    required this.counter,
  });
  void Function()? onTap;
  final String title;
  final String counter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorsManager.secondaryGray,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: titleSmall(context),
            ),
            CircleAvatar(
              backgroundColor: ColorsManager.color2,
              child: Text(counter),
            ),
          ],
        ),
      ),
    );
  }
}
