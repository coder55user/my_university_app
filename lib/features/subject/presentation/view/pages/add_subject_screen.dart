import 'package:app_excle/core/components/base_progress_button.dart';
import 'package:app_excle/core/components/my_text_form_field.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/presentation/cubit/add/add_subject_cubit.dart';
import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../../../students/presentation/view/pages/home_students_screen.dart';

class AddSubjectScreen extends StatelessWidget {
  AddSubjectScreen({super.key});
  TextEditingController department = TextEditingController();
  TextEditingController section = TextEditingController();
  TextEditingController creditHours = TextEditingController();
  TextEditingController classEs = TextEditingController();
  TextEditingController numberOfStudents = TextEditingController();
  TextEditingController courseTitle = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController instructor = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //custom app bar
                const BaseCustomAppBar(title: "Add Subject"),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      MyTextFormField(
                        hintText: "Department",
                        controller: department,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextFormField(
                              hintText: "section",
                              keyboardType: TextInputType.number,
                              controller: section,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: MyTextFormField(
                              hintText: "Credit Hours",
                              keyboardType: TextInputType.number,
                              controller: creditHours,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextFormField(
                              hintText: "class",
                              controller: classEs,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: MyTextFormField(
                              hintText: "No. of Students",
                              controller: numberOfStudents,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      MyTextFormField(
                        hintText: "Course Title",
                        controller: courseTitle,
                      ),
                      MyTextFormField(
                        hintText: "Instructor name",
                        controller: instructor,
                      ),
                      MyTextFormField(
                        hintText: "Semester",
                        controller: semester,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<AddSubjectCubit, AddSubjectState>(
                        listener: (context, state) async {
                          if (state.buttonState == ButtonState.success) {
                            AddSubjectCubit.get(context).createAnotherOperation(
                              baseIdSubject: state.idSubject!,
                            );
                            StoreSubjectCubit.get(context).getAllSubject();
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          var cubit = AddSubjectCubit.get(context);
                          print(state.buttonState);
                          return Row(
                            children: [
                              Expanded(
                                child: BaseProgressButton(
                                  buttonState:
                                      state.buttonState ?? ButtonState.idle,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      SubjectModel subjectModel = SubjectModel(
                                        courseTitle: courseTitle.text,
                                        creditHours:
                                            int.parse(creditHours.text),
                                        department: department.text,
                                        instructorName: instructor.text,
                                        mClass: classEs.text,
                                        noOfStudents:
                                            int.parse(numberOfStudents.text),
                                        section: int.parse(section.text),
                                        semester: semester.text,
                                      );
                                      cubit.addSubject(subjectModel);
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
