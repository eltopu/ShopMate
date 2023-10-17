//login exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//generic exception
class GenericExceptionAuthException implements Exception {
  get code => null;
}

class UserNotLoggdInAuthException implements Exception {}

class CouldNotDeleteAccountAuthException implements Exception {
  final String message;

  CouldNotDeleteAccountAuthException(this.message);

  @override
  String toString() => 'CouldNotDeleteAccountAuthException: $message';
}
