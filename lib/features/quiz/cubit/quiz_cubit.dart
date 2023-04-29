import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/quiz/controller/base_controller_quiz.dart';
import 'package:app_excle/features/subject/data/quiz_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_state_button/progress_button.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({
    this.quizController,
    this.baseControllerQuiz,
  }) : super(QuizState());

  //
  static QuizCubit get(context) => BlocProvider.of(context);
  QuizController? quizController;
  BaseControllerQuiz? baseControllerQuiz;

  //method
  void deleteQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsCollectionQuiz,
    required String nameQuiz,

  }) async {
    emit(QuizState(requestState: RequestState.Loading));
    final result = await quizController!.deleteQuiz(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: quizType,
      docsQuizDelete: docsCollectionQuiz,
      nameQuiz: nameQuiz,
    );
    result.fold(
      //Error
      (l) {
        emit(QuizState(requestState: RequestState.Error));
        print("error on delete quiz");
      },
      //Success
      (r) {
        emit(QuizState(requestState: RequestState.Success));
        print(r);
        print("success  on delete quiz");
      },
    );
  }

  void addQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required String name,
    required int numberQuestion,
  }) async {
    emit(QuizState(
      requestState: RequestState.Loading,
      buttonState: ButtonState.loading,
    ));
    final result = await baseControllerQuiz!.addQuiz(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: quizType,
      name: name,
      numberQuestion: numberQuestion,
    );
    result.fold(
      //Error
      (l) {
        emit(QuizState(
          requestState: RequestState.Error,
          buttonState: ButtonState.fail,
        ));
        print("error on delete quiz");
      },
      //Success
      (r) {
        emit(QuizState(
          requestState: RequestState.Success,
          buttonState: ButtonState.success,
        ));
        print(r);
      },
    );
  }
}
