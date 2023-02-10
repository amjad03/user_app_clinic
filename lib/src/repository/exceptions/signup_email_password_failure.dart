

class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occurred"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'week-password' :
        return const SignUpWithEmailAndPasswordFailure('Please Enter a Strong Password');
      case 'invalid-email' :
        return const SignUpWithEmailAndPasswordFailure('Email is not valid');
      case 'email-already-in-use' :
        return const SignUpWithEmailAndPasswordFailure('An account already exists with that email');
      case 'operation-not-allowed' :
        return const SignUpWithEmailAndPasswordFailure('Operation is not allowed, Please contact support');
      case 'user-disabled' :
        return const SignUpWithEmailAndPasswordFailure('This is user is disabled, please contact support for help');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}