part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailuer extends AuthState {
  final String errMessage;
  LoginFailuer({required this.errMessage});
}

//______________________

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailuer extends AuthState {
  final String errMessage;
  SignupFailuer({required this.errMessage});
}
