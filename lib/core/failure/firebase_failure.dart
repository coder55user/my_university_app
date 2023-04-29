abstract class Failure {
  final String message;

  Failure(this.message);
}

class FireBaseFailure extends Failure {
  FireBaseFailure(super.message);
}
