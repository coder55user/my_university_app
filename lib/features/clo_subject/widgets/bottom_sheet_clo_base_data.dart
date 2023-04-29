import 'package:app_excle/core/components/base_progress_button.dart';
import 'package:app_excle/core/components/base_table.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/clo_subject/controller/base_controller_clo.dart';
import 'package:app_excle/features/clo_subject/cubit/clo_cubit.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';

class BottomSheetCloBaseData extends StatelessWidget {
  const BottomSheetCloBaseData({
    super.key,
    required this.cloModel,
    required this.baseIdDocsSubjects,
  });

  final CloModel cloModel;
  final String baseIdDocsSubjects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseTable(
          firstChildren: [
            _myInput(hint: cloModel.baseCloId!),
          ],
          secondChildren: [
            _myInput(hint: cloModel.cloDescription!),
          ],
        ),
        BlocConsumer<CloCubit, CloState>(
          listener: (context, state) async {
            if (state.requestState == RequestState.Success) {
              Future.delayed(const Duration(seconds: 1)).then((value) {
                StoreSubjectCubit.get(context).getBaseCloData(
                  baseDocsIdSubject: baseIdDocsSubjects,
                );
              });
            }
          },
          builder: (context, state) {
            return BaseProgressButton(
              text: "Update",
              buttonState: state.buttonState ?? ButtonState.idle,
              onPressed: () {
                CloCubit.get(context).updateClo(
                  baseIdDocsSubjects: baseIdDocsSubjects,
                  docsCloUpdate: cloModel.baseIdDocs!,
                  newCloId: "new id clo",
                  newCloDescription: " develope app using flutter",
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _myInput extends StatelessWidget {
  _myInput({
    super.key,
    this.hint,
  });
  String? hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      maxLength: null,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: const TextStyle(),
        fillColor: Colors.transparent,
        hintText: hint ??
            "clo description clo description clo description clo description clo description ",
        border: InputBorder.none,
      ),
    );
  }
}
