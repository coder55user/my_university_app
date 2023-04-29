import 'package:app_excle/core/components/base_progress_button.dart';
import 'package:app_excle/core/components/base_table.dart';
import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/features/clo_subject/cubit/clo_cubit.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';

import 'base_popup_menu_clo.dart';

class BottomSheetCloKnowledge extends StatelessWidget {
  BottomSheetCloKnowledge({
    super.key,
    this.baseIdDocsSubjects,
    this.baseIdCloDocs,
  });
  final String? baseIdDocsSubjects;
  String? baseIdCloDocs;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Knowledge & Understanding",
            style: TextStyle(
              fontFamily: AssetsFonts.medium,
              fontSize: 20,
            ),
          ),
        ),
        BlocBuilder<CloCubit, CloState>(
          buildWhen: (previous, current) {
            return previous.requestState == current.requestState;
          },
          builder: (context, state) {
            return BaseTable(
              firstChildren: [
                for (int i = 0; i < state.data!.length; i++)
                  Text(
                    state.data![i].subCloId!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
              ],
              secondChildren: [
                for (int i = 0; i < state.data!.length; i++)
                  BasePopupMenuClo(
                    baseIdDocsSubjects: baseIdDocsSubjects,
                    baseIdCloDocs: baseIdCloDocs,
                    docsKNol: state.data![i].subIdDocs!,
                    data: state.data![i].data,
                    subCloId: state.data![i].subCloId!,
                    docsNameCollectionDetail: "knowledge",
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
