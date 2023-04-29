import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/subject/data/home_repo_imp.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'delete_subject_state.dart';

class DeleteSubjectCubit extends Cubit<DeleteSubjectState> {
  DeleteSubjectCubit(this.repositorySubjectImpl) : super(DeleteSubjectState());
  RepositorySubjectImpl repositorySubjectImpl;
  static DeleteSubjectCubit get(context) => BlocProvider.of(context);

  //delete subject
  void deleteSubject(String docs) async {
    //set state loading
    emit(DeleteSubjectState(
        requestState: RequestState.Loading, message: "Loading"));

    //get the docs to delete
    final result = await repositorySubjectImpl.deleteSubject(docs);

    //error
    result.fold(
      (l) {
        emit(DeleteSubjectState(
            requestState: RequestState.Error, message: "Error"));
      },
      //success
      (r) {
        emit(
          DeleteSubjectState(
            requestState: RequestState.Success,
            message: "Success",
          ),
        );
      },
    );
  }
}
