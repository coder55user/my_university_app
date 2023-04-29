import 'package:app_excle/core/components/base_progress_button.dart';
import 'package:app_excle/core/components/my_text_form_field.dart';
import 'package:app_excle/core/components/snack_bar.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/clo_subject/controller/base_controller_clo.dart';
import 'package:app_excle/features/clo_subject/cubit/clo_cubit.dart';
import 'package:app_excle/features/students/presentation/view/pages/home_students_screen.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AddCloSubjectScreen extends StatelessWidget {
  AddCloSubjectScreen({
    required this.data,
  });
  final SubjectModel data;
  TextEditingController cloDes = TextEditingController();
  TextEditingController knowledge = TextEditingController();
  TextEditingController skills = TextEditingController();
  TextEditingController value = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CloCubit(baseCloController: BaseCloController()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //custom app bar
                    const BaseCustomAppBar(title: "Add Clo"),

                    //

                    MyTextFormField(
                      hintText: "clo Description..",
                      controller: cloDes,
                    ),
                    MyTextFormField(
                      hintText: "Count Knowledge..",
                      controller: knowledge,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormField(
                            hintText: "Count Skills..",
                            controller: skills,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MyTextFormField(
                            hintText: "Count Value",
                            controller: value,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<CloCubit, CloState>(
                      listener: (context, state) {
                        if (state.requestState == RequestState.Success) {
                          StoreSubjectCubit.get(context).getBaseCloData(
                            baseDocsIdSubject: data.id!,
                          );
                          StoreSubjectCubit.get(context).getCountQuizType(
                            baseDocsIdSubject: data.id!,
                            quizType: "clos",
                          );
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      builder: (context, state) {
                        return BaseProgressButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (int.parse(skills.text) > 5) {
                                SnackBarMessage.showQuickAlert(
                                  message: "You can add more than 5 skills",
                                  context: context,
                                  contentType: QuickAlertType.error,
                                );
                              } else if (int.parse(value.text) >= 3) {
                                SnackBarMessage.showQuickAlert(
                                  message: "You can add more than 3 value",
                                  context: context,
                                  contentType: QuickAlertType.error,
                                );
                              } else if (int.parse(knowledge.text) >= 3) {
                                SnackBarMessage.showQuickAlert(
                                  message: "You can add more than 3 knowledge",
                                  context: context,
                                  contentType: QuickAlertType.error,
                                );
                              } else {
                                CloCubit.get(context).addClo(
                                  skillsCount: int.parse(skills.text),
                                  skillsValue: int.parse(value.text),
                                  skillsKnowledge: int.parse(knowledge.text),
                                  numberClo: 5,
                                  baseIdDocsSubjects: data.id!,
                                );
                              }
                            }
                          },
                          buttonState: state.buttonState ?? ButtonState.idle,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
