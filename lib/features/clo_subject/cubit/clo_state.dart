part of 'clo_cubit.dart';

@immutable
class CloState {
  RequestState? requestState;
  ButtonState? buttonState;
final  bool isBottomSheet;
  List<CloModel>? data;

  CloState({
    this.requestState,
    this.buttonState,
    this.data,
    this.isBottomSheet=false,
  });
}
