import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/clo_subject/controller/base_controller_clo.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_state_button/progress_button.dart';

part 'clo_state.dart';

class CloCubit extends Cubit<CloState> {
  CloCubit({required this.baseCloController}) : super(CloState());
  //BaseCloController
  BaseCloController baseCloController;
  //object
  static CloCubit get(context) => BlocProvider.of(context);

  //event
  void addClo({
    required int skillsCount,
    required int skillsValue,
    required int skillsKnowledge,
    required int numberClo,
    required String baseIdDocsSubjects,
  }) async {
    emit(CloState(
      buttonState: ButtonState.loading,
      requestState: RequestState.Loading,
    ));
    final result = await baseCloController.addClos(
      skillsCount: skillsCount,
      skillsValue: skillsValue,
      skillsKnowledge: skillsKnowledge,
      numberClo: numberClo,
      baseIdDocsSubjects: baseIdDocsSubjects,
    );
    result.fold(
      //Error
      (l) => emit(CloState(
        buttonState: ButtonState.fail,
        requestState: RequestState.Error,
      )),
      //Success
      (r) => emit(CloState(
        buttonState: ButtonState.success,
        requestState: RequestState.Success,
      )),
    );
  }

  //delete clo
  void deleteClo({
    required String baseIdDocsSubjects,
    required String docsCloDelete,
  }) async {
    emit(CloState(
      buttonState: ButtonState.loading,
      requestState: RequestState.Loading,
    ));
    final result = await baseCloController.deleteClo(
      docsCloDelete: docsCloDelete,
      baseIdDocsSubjects: baseIdDocsSubjects,
    );
    result.fold(
      //Error
      (l) {
        emit(CloState(
          buttonState: ButtonState.fail,
          requestState: RequestState.Error,
        ));
        print(l);
      },
      //Success
      (r) {
        emit(CloState(
          buttonState: ButtonState.success,
          requestState: RequestState.Success,
        ));
        print(r);
      },
    );
  }

  //update clo
  void updateClo({
    required String baseIdDocsSubjects,
    required String docsCloUpdate,
    required String newCloId,
    required String newCloDescription,
  }) async {
    emit(CloState(
      buttonState: ButtonState.loading,
      requestState: RequestState.Loading,
    ));
    final result = await baseCloController.updateClo(
      baseIdDocsSubjects: baseIdDocsSubjects,
      docsCloUpdate: docsCloUpdate,
      cloId: newCloId,
      cloDescription: newCloDescription,
    );
    result.fold(
      //Error
      (l) {
        emit(CloState(
          buttonState: ButtonState.fail,
          requestState: RequestState.Error,
        ));
        print(l);
      },
      //Success
      (r) {
        emit(CloState(
          buttonState: ButtonState.success,
          requestState: RequestState.Success,
        ));
        print(r);
      },
    );
  }

  //update clo
  Future<void> updateCloDetail({
    required String baseIdDocsSubjects,
    required String docsCloUpdate,
    required String docsKnowledgeCloUpdate,
    required bool newKnowledgeData,
    required String newKey,
    required String docsNameCollectionDetail,
  }) async {
    emit(CloState(
      buttonState: ButtonState.loading,
      requestState: RequestState.Loading,
    ));
    final result = await baseCloController.updateCloKnowledge(
      baseIdDocsSubjects: baseIdDocsSubjects,
      docsCloUpdate: docsCloUpdate,
      docsKnowledgeCloUpdate: docsKnowledgeCloUpdate,
      newKnowledgeData: newKnowledgeData,
      newKey: newKey,
      collectionNameDetail: docsNameCollectionDetail,
    );
    result.fold(
      //Error
      (l) {
        emit(CloState(
          buttonState: ButtonState.fail,
          requestState: RequestState.Error,
        ));
        print(l);
      },
      //Success
      (r) {
        emit(CloState(
          buttonState: ButtonState.success,
          requestState: RequestState.Success,
        ));
        print(r);
      },
    );
  }

  //get data clo detail
  Future<void> getDataCloDetail({
    required String baseIdDocsSubjects,
    required String docsCloId,
    required String nameCollectionInClo,
  }) async {
    emit(CloState(
      buttonState: ButtonState.loading,
      requestState: RequestState.Loading,
      data: const [],
    ));
    final result = await baseCloController.getDataCloDetail(
      baseIdDocsSubjects: baseIdDocsSubjects,
      docsCloId: docsCloId,
      nameCollectionInClo: nameCollectionInClo,
    );
    result.fold(
      //Error
      (l) {
        emit(CloState(
          buttonState: ButtonState.fail,
          requestState: RequestState.Error,
          data: [],
        ));
        print(l);
      },
      //Success
      (r) {
        emit(CloState(
          buttonState: ButtonState.success,
          requestState: RequestState.Success,
          isBottomSheet: true,
          data: r,
        ));
        print(r);
      },
    );
  }
}
