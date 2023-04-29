import 'package:app_excle/core/components/base_table.dart';
import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/features/clo_subject/cubit/clo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_popup_menu_clo.dart';

class BottomSheetCloSKills extends StatelessWidget {
  BottomSheetCloSKills({
    this.baseIdDocsSubjects,
    this.baseIdCloDocs,
  });
  final String? baseIdDocsSubjects;
  String? baseIdCloDocs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Skills",
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
                    docsNameCollectionDetail: "skill",
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

