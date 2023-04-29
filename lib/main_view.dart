import 'package:app_excle/core/servese/clo_report_data.dart';
import 'package:app_excle/features/clo_subject/controller/base_controller_clo.dart';
import 'package:app_excle/features/clo_subject/cubit/clo_cubit.dart';
import 'package:app_excle/features/students/data/controller/get_data_student_controller.dart';
import 'package:app_excle/features/students/presentation/cubit/get_all_student/get_student_cubit.dart';
import 'package:app_excle/features/subject/data/clo_controller.dart';
import 'package:app_excle/features/subject/data/question_controller.dart';
import 'package:app_excle/features/subject/data/quiz_controller.dart';
import 'package:app_excle/features/subject/presentation/cubit/add/add_subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/resources/routes_manager.dart';
import 'core/themes/light_mode.dart';
import 'features/students/data/controller/student_repo_imp.dart';

import 'features/students/presentation/cubit/add_student/add_student_cubit.dart';
import 'features/subject/data/home_repo_imp.dart';
import 'features/subject/presentation/cubit/store/store_subject_cubit.dart';
import 'features/subject/presentation/view/pages/subject_screen.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoreSubjectCubit(
            cloReportDataController: CloReportDataController(),
            cloController: CloController(),
            questionController: QuestionController(),
            quizController: QuizController(),
            repositorySubjectImpl: RepositorySubjectImpl(),
          )..getAllSubject(),
        ),
        BlocProvider(
          create: (context) => StoreStudentCubit(
            RepositoryStudentImpl(),
            GetDataStudentController(),
          ),
        ),
        BlocProvider(
          create: (context) => CloCubit(baseCloController: BaseCloController()),
        ),
        BlocProvider(
          create: (context) => AddSubjectCubit(RepositorySubjectImpl()),
        ),
        BlocProvider(
          create: (context) => AddStudentCubit(RepositoryStudentImpl()),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: RouterGenerator.getRoute,
        initialRoute: RoutesManager.main,
        theme: getLightMode(),
        title: 'managements system',
        themeAnimationCurve: Curves.easeInCirc,
        themeAnimationDuration: const Duration(seconds: 1),
        debugShowCheckedModeBanner: false,
        home: const SubjectScreen(),
      ),
    );
  }
}
