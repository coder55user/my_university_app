import 'package:app_excle/core/components/my_text_form_field.dart';

import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/features/students/data/controller/student_repo_imp.dart';
import 'package:app_excle/features/students/data/models/student_model.dart';
import 'package:app_excle/features/students/presentation/cubit/add_student/add_student_cubit.dart';
import 'package:app_excle/features/students/presentation/cubit/get_all_student/get_student_cubit.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import 'home_students_screen.dart';

class AddStudentScreen extends StatelessWidget {
  AddStudentScreen({super.key, required this.data});
  final SubjectModel data;

  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const BaseCustomAppBar(title: "Add Student "),

                  const SizedBox(
                    height: 15,
                  ),
                  MyTextFormField(
                    controller: name,
                    hintText: "name",
                  ),
                  MyTextFormField(
                    hintText: "id",
                    controller: id,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocConsumer<AddStudentCubit, AddStudentState>(
                    listener: (context, state) async {
                      if (state.buttonState == ButtonState.success) {
                        StoreStudentCubit.get(context).getAllStudent(data.id!);
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      var cubit = AddStudentCubit.get(context);
                      print(state.buttonState);
                      return ProgressButton.icon(
                        iconedButtons: {
                          //
                          ButtonState.idle: IconedButton(
                            text: "Create",
                            icon: const Icon(Icons.send, color: Colors.white),
                            color: Colors.deepPurple.shade500,
                          ),
                          //
                          ButtonState.loading: IconedButton(
                            text: "Loading",
                            color: Colors.deepPurple.shade700,
                          ),
                          //
                          ButtonState.fail: IconedButton(
                            text: "Failed",
                            icon: const Icon(Icons.cancel, color: Colors.white),
                            color: Colors.red.shade300,
                          ),
                          //
                          ButtonState.success: IconedButton(
                            text: "Success",
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            color: Colors.green.shade400,
                          )
                        },
                        onPressed: () {
                          StudentModel studentModel = StudentModel(
                            ID: int.parse(id.text),
                            name: name.text,
                          );
                          if (_formKey.currentState!.validate()) {
                            cubit.addStudent(
                              studentModel: studentModel,
                              docsIdSubject: data.id!,
                            );
                          }
                        },
                        state: state.buttonState ?? ButtonState.idle,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
