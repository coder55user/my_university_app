import 'package:app_excle/core/components/base_progress_button.dart';
import 'package:app_excle/core/components/my_text_form_field.dart';
import 'package:app_excle/core/components/snack_bar.dart';

import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/features/quiz/controller/base_controller_quiz.dart';
import 'package:app_excle/features/quiz/cubit/quiz_cubit.dart';
import 'package:app_excle/features/students/presentation/view/pages/home_students_screen.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AddMedTermScreen extends StatelessWidget {
  AddMedTermScreen({super.key, required this.data});
  final SubjectModel data;

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(baseControllerQuiz: BaseControllerQuiz()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //custom app bar
                                     const BaseCustomAppBar(title: "Add Med Term "),
              
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextFormField(
                      controller: number,
                      hintText: "number of question for lpas",
                    ),
                    MyTextFormField(
                      hintText: "name of new lpas",
                      controller: name,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocConsumer<QuizCubit, QuizState>(
                      listener: (context, state) async {
                        StoreSubjectCubit.get(context).getBaseCloData(
                          baseDocsIdSubject: data.id!,
                        );
                        StoreSubjectCubit.get(context).getCountQuizType(
                          baseDocsIdSubject: data.id!,
                          quizType: "midTermExams",
                        );
                        if (state.buttonState == ButtonState.success) {
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      builder: (context, state) {
                        var cubit = QuizCubit.get(context);
                        return BaseProgressButton(
                          onPressed: () {
                         if (_formKey.currentState!.validate()) {
                              if (int.parse(number.text) >= 10) {
                                SnackBarMessage.showQuickAlert(
                                  message: "You can add more than 10 Questions",
                                  context: context,
                                  contentType: QuickAlertType.warning,
                                );
                              } else {
                                cubit.addQuiz(
                                  baseDocsIdSubject: data.id!,
                                  quizType: "midTermExams",
                                  name: name.text,
                                  numberQuestion: int.parse(number.text),
                                );
                              }
                            }
                          },
                          buttonState: state.buttonState ?? ButtonState.idle,
                        );
                      },
                    ),
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
