import 'package:app_excle/core/components/snack_bar.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/core/resources/size_config.dart';
import 'package:app_excle/core/themes/light_mode.dart';
import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/features/students/presentation/cubit/add_student/add_student_cubit.dart';
import 'package:app_excle/features/students/presentation/view/pages/add_students_screen.dart';
import 'package:app_excle/features/students/presentation/view/widgets/body_view_students.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class HomeStudentsScreen extends StatelessWidget {
  const HomeStudentsScreen({super.key, required this.data});
  final SubjectModel data;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: BlocBuilder<AddStudentCubit, AddStudentState>(
        builder: (context, state) {
          return FloatingActionButton(
            child: const Icon(Icons.add, size: 30),
            onPressed: () {
              if (state.anotherRequestState == RequestState.Loading) {
                SnackBarMessage.showQuickAlert(
                  message:
                      "we are still some operation for the last student that you have created",
                  context: context,
                  contentType: QuickAlertType.loading,
                );
              } else {
                NavigatorManager.navigateTo(
                  context: context,
                  page: AddStudentScreen(
                    data: data,
                  ),
                );
              }
            },
          );
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //custom app bar
            const BaseCustomAppBar(title: "All Students"),

            //body
            Expanded(
              child: BodyViewStudents(baseIdDocsSubject: data.id!),
            ),
          ],
        ),
      ),
    );
  }
}

class BaseCustomAppBar extends StatelessWidget {
  const BaseCustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorsManager.main,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: AssetsFonts.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
