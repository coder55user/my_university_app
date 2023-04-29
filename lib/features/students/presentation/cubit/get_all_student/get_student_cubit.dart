import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/students/data/controller/get_data_student_controller.dart';
import 'package:app_excle/features/students/data/controller/student_repo_imp.dart';
import 'package:app_excle/features/students/data/models/student_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'get_student_state.dart';

class StoreStudentCubit extends Cubit<StoreStudentState> {
  StoreStudentCubit(this.repositorySubjectImpl, this.getDataStudentController)
      : super(StoreStudentState());
  //Student Cubit
  static StoreStudentCubit get(context) => BlocProvider.of(context);
  RepositoryStudentImpl repositorySubjectImpl;
  GetDataStudentController getDataStudentController;

  //get all students
  Future<void> getAllStudent(
    String docs,
  ) async {
    final result = await repositorySubjectImpl.getAllStudent(docs);
    //Error
    result.fold((l) {
      emit(
        state.copyWith(
          dataStudents: [],
          requestStateDataStudents: RequestState.Error,
        ),
      );
    },
        //Success
        (r) {
      emit(
        state.copyWith(
          dataStudents: r,
          requestStateDataStudents: RequestState.Success,
        ),
      );
    });
  }

  //get all students
  Future<void> getDataSectionType({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsNameSection,
  }) async {
    final result = await getDataStudentController.getDataSectionType(
      idDocsStudent: idDocsStudent,
      baseIdDocsSubject: baseIdDocsSubject,
      idDocsNameSection: idDocsNameSection,
    );
    //Error
    result.fold((l) {
      emit(
        state.copyWith(
          requestSectionTypeState: RequestState.Error,
          dataSectionType: [],
        ),
      );
    },
        //Success
        (r) {
      emit(
        state.copyWith(
          requestSectionTypeState: RequestState.Success,
          dataSectionType: r,
        ),
      );
    });
  }

  //get Data Question Section Type
  Future<void> getDataQuestionSectionType({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsQuizSection,
    required String nameCollectionSection,
  }) async {
    final result = await getDataStudentController.getDataQuestionSectionType(
      idDocsStudent: idDocsStudent,
      baseIdDocsSubject: baseIdDocsSubject,
      idDocsQuizSection: idDocsQuizSection,
      nameCollectionSection: nameCollectionSection,
    );
    //Error
    result.fold((l) {
      emit(
        state.copyWith(
          requestQuestionSectionState: RequestState.Error,
          dataQuestionSection: [],
        ),
      );
    },
        //Success
        (r) {
      print(r.length);
      emit(
        state.copyWith(
          requestQuestionSectionState: RequestState.Success,
          dataQuestionSection: r,
        ),
      );
    });
  }

  //get Data Question Section Type
  Future<void> getSumOfQuiz({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsQuizSection,
    required String nameCollectionSection,
  }) async {
    final result = await getDataStudentController.getSumOfQuiz(
      idDocsStudent: idDocsStudent,
      baseIdDocsSubject: baseIdDocsSubject,
      idDocsQuizSection: idDocsQuizSection,
      nameCollectionSection: nameCollectionSection,
    );
    //Error
    result.fold((l) {
      emit(
        state.copyWith(
          sumOfQuiz: 0.0,
        ),
      );
    },
        //Success
        (r) {
      emit(
        state.copyWith(
          sumOfQuiz: r,
        ),
      );
    });
  }
}
