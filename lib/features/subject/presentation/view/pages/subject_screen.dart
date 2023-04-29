import 'dart:io';

import 'package:app_excle/core/components/custom_app_bar.dart';
import 'package:app_excle/core/components/snack_bar.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/core/resources/size_config.dart';
import 'package:app_excle/core/themes/light_mode.dart';

import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/features/subject/data/home_repo_imp.dart';
import 'package:app_excle/features/subject/presentation/cubit/add/add_subject_cubit.dart';
import 'package:app_excle/features/subject/presentation/cubit/delete/delete_subject_cubit.dart';
import 'package:app_excle/features/subject/presentation/view/widgets/body_view_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

import 'add_subject_screen.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => DeleteSubjectCubit(RepositorySubjectImpl()),
      child: Scaffold(
        drawer: Drawer(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorsManager.secondMain,
                    ),
                    child: const ListTile(
                      leading: CircleAvatar(child: Text("1")),
                      subtitle: Text(
                        "443207401",
                        style: TextStyle(
                          fontFamily: AssetsFonts.ios,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        " خالد عبدالرحمن هادي اليامي",
                        style: TextStyle(
                          fontFamily: AssetsFonts.ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  //
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorsManager.secondMain,
                    ),
                    child: const ListTile(
                      leading: CircleAvatar(child: Text("2")),
                      subtitle: Text(
                        "443105075",
                        style: TextStyle(
                          fontFamily: AssetsFonts.ios,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        " جواد صالح ال سالم",
                        style: TextStyle(
                          fontFamily: AssetsFonts.ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorsManager.secondMain,
                    ),
                    child: const ListTile(
                      leading: CircleAvatar(child: Text("3")),
                      subtitle: Text(
                        "",
                        style: TextStyle(
                          fontFamily: AssetsFonts.ios,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "خالد حارث آل عامر",
                        style: TextStyle(
                          fontFamily: AssetsFonts.ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(),
        floatingActionButton: BlocBuilder<AddSubjectCubit, AddSubjectState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () async {
                if (state.anotherRequestState == RequestState.Loading) {
                  SnackBarMessage.showQuickAlert(
                    message:
                        "we are still some operation for the last subject the you have created",
                    context: context,
                    contentType: QuickAlertType.loading,
                  );
                } else {
                  NavigatorManager.navigateTo(
                    context: context,
                    page: AddSubjectScreen(),
                  );
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //custom app bar
                CustomAppBar(),

                //body
                const BodyViewSubject(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
