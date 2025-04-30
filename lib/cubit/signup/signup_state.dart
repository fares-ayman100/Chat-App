part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailuer extends SignupState {
  final String errMessage;
  SignupFailuer({required this.errMessage});
}
