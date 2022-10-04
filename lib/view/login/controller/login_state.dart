part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

//===============================================================
class GoogleSignInLoading extends LoginState {}

class GoogleSignInSuccess extends LoginState {}

class GoogleSignInFailed extends LoginState {}
//===============================================================
