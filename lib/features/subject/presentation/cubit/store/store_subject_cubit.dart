import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/core/servese/clo_report_data.dart';
import 'package:app_excle/features/subject/data/clo_controller.dart';
import 'package:app_excle/features/subject/data/home_repo_imp.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:app_excle/features/subject/data/models/count_quiz_type_model.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:app_excle/features/subject/data/question_controller.dart';
import 'package:app_excle/features/subject/data/quiz_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'store_subject_state.dart';

class StoreSubjectCubit extends Cubit<StoreSubjectState> {
  StoreSubjectCubit({
    required this.repositorySubjectImpl,
    required this.cloController,
    required this.questionController,
    required this.quizController,
    required this.cloReportDataController,
  }) : super(const StoreSubjectState());
  final RepositorySubjectImpl repositorySubjectImpl;
  final CloController cloController;
  final QuestionController questionController;
  final QuizController quizController;
  final CloReportDataController cloReportDataController;

  //
  List<SubjectModel> dataSubject = [];
  static StoreSubjectCubit get(context) => BlocProvider.of(context);
  //get all students
  void getAllSubject() async {
    //set state loading
    emit(
      state.copyWith(
        subjectRequestState: RequestState.Loading,
        dataSubject: const [],
      ),
    );

    //get all the subject
    final result = await repositorySubjectImpl.getAllSubject();

    //error

    result.fold(
      (l) {
        emit(
          state.copyWith(
            subjectRequestState: RequestState.Error,
            dataSubject: const [],
          ),
        );
      },
      //success

      (r) {
        emit(
          state.copyWith(
            subjectRequestState: RequestState.Success,
            dataSubject: r,
          ),
        );
      },
    );
  }

  //get Base Clo Data
  void getBaseCloData({
    required String baseDocsIdSubject,
  }) async {
    //
    final result = await cloController.getClo(
      baseDocsIdSubject: baseDocsIdSubject,
    );
    //Error
    result.fold(
      (l) {
        //Error
        emit(
          state.copyWith(
            cloRequestState: RequestState.Error,
            dataClo: [],
          ),
        );
        print("=========================");
        print("getBaseCloData");
        print(l.message);
        print("=========================");
      },
      //Success
      (r) {
        emit(
          state.copyWith(
            cloRequestState: RequestState.Success,
            dataClo: r,
          ),
        );
        print("=========================");
        print("getBaseCloData");
        print(r.length);
        print("=========================");
      },
    );
  }

  //get Count Quiz Type
  void getCountQuizType({
    required String baseDocsIdSubject,
    required String quizType,
  }) async {
    //
    final result = await quizController.getCountQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: quizType,
    );
    //Error
    result.fold(
      (l) {
        //Error
        emit(
          state.copyWith(
            quizTypeRequestState: RequestState.Error,
          ),
        );
        print("=========================");
        print("getCountQuizType");
        print(l.message);
        print("=========================");
      },
      //Success
      (r) {
        emit(
          state.copyWith(
            dataQuizType: r,
            quizTypeRequestState: RequestState.Success,
          ),
        );
        print("=========================");
        print("getCountQuizType");
        print(r.length);
        print("=========================");
      },
    );
  }

  //get Count Quiz Type
  Future<void> getQuestionDataOfQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsCollectionQuiz,
  }) async {
    //
    final result = await questionController.getQuestionDataOfQuiz(
      docsCollectionQuiz: docsCollectionQuiz,
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: quizType,
    );
    //Error
    result.fold(
      (l) {
        //Error
        emit(
          state.copyWith(
            questionDataRequestState: RequestState.Error,
          ),
        );
        print("=========================");
        print("getQuestionDataOfQuiz");
        print(l.message);
        print("=========================");
      },
      //Success
      (r) {
        emit(
          state.copyWith(
            dataQuestion: r,
            questionDataRequestState: RequestState.Success,
          ),
        );
        print("=========================");
        print("getQuestionDataOfQuiz");
        print(r.length);
        print("=========================");
      },
    );
  }

  //get Count Quiz Type
  Future<void> updateQuestionDataOfQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsQuiz,
    required String docsIdQuestionUpdate,
    required String newCloIdUpdateData,
    required String newCloNameData,
    required String name,
  }) async {
    //
    final result = await questionController.updateQuestionDataOfQuiz(
      docsQuiz: docsQuiz,
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: quizType,
      newCloIdUpdateData: newCloIdUpdateData,
      newCloNameData: newCloNameData,
      docsIdQuestionUpdate: docsIdQuestionUpdate,
      name: name,
    );
    //Error
    result.fold(
      (l) {
        //Error
        emit(
          state.copyWith(
            questionDataRequestState: RequestState.Error,
          ),
        );
        print("=========================");
        print(" Error update Question Data Of Quiz");
        print(l.message);
        print("=========================");
      },
      //Success
      (r) {
        emit(
          state.copyWith(),
        );
        print("=========================");
        print(" Success update Question Data Of Quiz");
        print(r);
        print("=========================");
      },
    );
  }

  //get Count Quiz Type
  Future<void> updateDegreeOfQuizType({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsQuiz,
    required String docsIdQuestionUpdate,
    required double newDegree,
  }) async {
    //
    final result = await questionController.updateDegreeOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: quizType,
      docsQuiz: docsQuiz,
      docsIdQuestionUpdate: docsIdQuestionUpdate,
      newDegree: newDegree,
    );
    //Error
    result.fold(
      (l) {
        //Error
        emit(
          state.copyWith(
            questionDataRequestState: RequestState.Error,
          ),
        );
        print("=========================");
        print(" Error update degree Data Of Quiz");
        print(l.message);
        print("=========================");
      },
      //Success
      (r) {
        emit(
          state.copyWith(),
        );
        print("=========================");
        print(" Success update degree Data Of Quiz");
        print(r);
        print("=========================");
      },
    );
  }

  //get Count Quiz Type
  Future<void> exportReportExcel({
    required String baseDocsIdSubject,
  }) async {
    //Loading
    emit(
      state.copyWith(
        cloReportRequestState: RequestState.Loading,
      ),
    );
    //
    final result = await cloReportDataController.collectTheData(
      baseDocsIdSubject: baseDocsIdSubject,
    );
    //Error
    result.fold(
      (l) {
        //Error
        emit(
          state.copyWith(
            cloReportRequestState: RequestState.Error,
          ),
        );
        print("=========================");
        print(" Error update degree Data Of Quiz");
        print(l.message);
        print("=========================");
      },
      //Success
      (r) {
        emit(
          state.copyWith(
            cloReportRequestState: RequestState.Success,
          ),
        );
        print("=========================");
        print(" Success export Report Excel ");
        print(r);
        print("=========================");
      },
    );
  }
}
