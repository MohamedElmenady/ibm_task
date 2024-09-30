abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {
  final String scucces;

  SuccessState({required this.scucces});
}

class ErrorState extends LoginState {
  final String error;

  ErrorState({required this.error});
}

class LoginInternetDisconnected extends LoginState {}

class LoginInternetConnected extends LoginState {}
