part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;
  SignUpSuccess(this.message);
}

class SignUpValidationError extends SignUpState {
  final Map<String, dynamic> errors;
  SignUpValidationError(this.errors);
}

class SignUpFailure extends SignUpState {
  final String message;
  SignUpFailure(this.message);
}