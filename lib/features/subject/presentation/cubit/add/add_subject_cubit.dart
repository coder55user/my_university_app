import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/subject/data/home_repo_imp.dart';
import 'package:app_excle/features/subject/data/models/subject_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_state_button/progress_button.dart';

part 'add_subject_state.dart';

class AddSubjectCubit extends Cubit<AddSubjectState> {
  AddSubjectCubit(this.repositorySubjectImpl) : super(AddSubjectState());

  //
  RepositorySubjectImpl repositorySubjectImpl;

  //
  static AddSubjectCubit get(context) => BlocProvider.of(context);

  //add subject
  void addSubject(SubjectModel subjectModel) async {
    //loading
    emit(
      state.copyWith(
        requestState: RequestState.Loading,
        idSubject: "Loading",
        buttonState: ButtonState.loading,
      ),
    );
    //result
    final result = await repositorySubjectImpl.createSubject(subjectModel);

    //error
    result.fold(
      (l) {
        emit(
          state.copyWith(
            requestState: RequestState.Error,
            idSubject: "Error",
            buttonState: ButtonState.fail,
          ),
        );
      },

      //success
      (r) {
        emit(
          state.copyWith(
            requestState: RequestState.Success,
            idSubject: r,
            buttonState: ButtonState.success,
          ),
        );
      },
    );
  }

  //create Another Operation
  void createAnotherOperation({
    required String baseIdSubject,
  }) async {
    //loading
    emit(
      state.copyWith(
        anotherRequestState: RequestState.Loading,
        buttonState: ButtonState.idle,
      ),
    );
    //result
    final result = await repositorySubjectImpl.createAnotherOperation(
      baseIdSubject: baseIdSubject,
    );

    //error
    result.fold(
      (l) {
        emit(
          state.copyWith(
            anotherRequestState: RequestState.Error,
          ),
        );
      },

      //success
      (r) {
        emit(
          state.copyWith(
            anotherRequestState: RequestState.Success,
          ),
        );
      },
    );
  }
}
