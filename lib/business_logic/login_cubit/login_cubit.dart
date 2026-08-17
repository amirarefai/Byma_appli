import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // شلنا الـ Repo القديم عشان يشتغل الكود فوراً بدون أخطاء
  LoginCubit() : super(LoginInitial());

  // دالة تسجيل الدخول المحدثة (تتعامل مع الإيميل والباسورد)
  Future<void> loginUser(String email, String password) async {
    // التحقق الأولي من الحقول قبل الإرسال
    if (email.isEmpty || !email.contains('@')) {
      emit(LoginValidationError({'email': 'Please enter a valid email address'}));
      return;
    }
    if (password.isEmpty || password.length < 6) {
      emit(LoginValidationError({'password': 'Password must be at least 6 characters'}));
      return;
    }

    emit(LoginLoading());

    try {
      // ⏳ محاكاة للاتصال بالسيرفر لمدة ثانيتين
      await Future.delayed(const Duration(seconds: 2));

      // هنا نضع شرط وهمي للنجاح (مثلاً إذا كان الباسورد صح)
      if (email == "test@byma.com" && password == "123456") {
        emit(LoginSuccess());
      } else {
        // محاكاة لخطأ قادم من السيرفر في حال كانت البيانات غير مطابقة
        emit(LoginFailure('Invalid email or password. Try test@byma.com / 123456'));
      }
    } catch (e) {
      emit(LoginFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  // دالة وهمية لفحص حالة تسجيل الدخول عند فتح التطبيق
  Future<void> checkAuthStatus() async {
    emit(AuthStatusChecked(false)); // نعتبره غير مسجل حالياً
  }

  // دالة تسجيل الخروج تنظف الحالة
  Future<void> logout() async {
    emit(LogoutLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(LogoutSuccess());
  }
}