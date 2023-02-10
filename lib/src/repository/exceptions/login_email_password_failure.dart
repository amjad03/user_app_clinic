

class LoginWithEmailAndPasswordFailure {
  final String message;

  const LoginWithEmailAndPasswordFailure([this.message = "Either email or password is incorrect"]);

  factory LoginWithEmailAndPasswordFailure.fromCode(String code){
    switch(code){
      case 'week-password' :
        return const LoginWithEmailAndPasswordFailure('Please Enter a Strong Password');
      case 'invalid-email' :
        return const LoginWithEmailAndPasswordFailure('Email is not valid');
      case 'email-already-in-use' :
        return const LoginWithEmailAndPasswordFailure('An account already exists with that email');
      case 'operation-not-allowed' :
        return const LoginWithEmailAndPasswordFailure('Operation is not allowed, Please contact support');
      case 'user-disabled' :
        return const LoginWithEmailAndPasswordFailure('This is user is disabled, please contact support for help');
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}