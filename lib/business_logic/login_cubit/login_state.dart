part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

// الحالة الابتدائية قبل أي إجراء
class LoginInitial extends LoginState {}

// الحالات الخاصة بعملية تسجيل الدخول (Login)
class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginValidationError extends LoginState {
  final dynamic errors; // لاستقبال أخطاء التحقق القادمة من الـ API (مثل صيغة الإيميل خاطئة)
  LoginValidationError(this.errors);
}

class LoginFailure extends LoginState {
  final String message; // لاستقبال رسالة الخطأ العامة (سواء من السيرفر أو الشبكة)
  LoginFailure(this.message);
}

// الحالات الخاصة بالتحقق من حالة الجلسة (Auth Status) عند فتح التطبيق
class AuthStatusChecked extends LoginState {
  final bool isLoggedIn;
  AuthStatusChecked(this.isLoggedIn);
}

// الحالات الخاصة بتسجيل الخروج (Logout)
class LogoutLoading extends LoginState {}

class LogoutSuccess extends LoginState {}

class LogoutFailure extends LoginState {
  final String message;
  LogoutFailure(this.message);
}