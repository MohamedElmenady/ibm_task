abstract class HomeState {}

class InitialState extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}

class HomeSerching extends HomeState {}

class HomeRefresh extends HomeState {}

class HomeExpandUnexpand extends HomeState {}

class LoginInternetDisconnected extends HomeState {
  final String error;

  LoginInternetDisconnected({required this.error});
}

class LoginInternetConnected extends HomeState {}
