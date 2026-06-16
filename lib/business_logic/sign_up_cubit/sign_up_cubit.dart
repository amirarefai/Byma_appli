import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> createNewUser({
    required String name,
    required String email,
    required String password,
    required String birthDate,
  }) async {
    
    if (name.isEmpty) {
      emit(SignUpValidationError({'name': 'Name cannot be empty'}));
      return;
    }
    if (!email.contains('@')) {
      emit(SignUpValidationError({'email': 'Invalid email address'}));
      return;
    }
    if (password.length < 6) {
      emit(SignUpValidationError({'password': 'Password must be at least 6 characters'}));
      return;
    }

    emit(SignUpLoading());

    try {
      // محاكاة لطلب السيرفر يستغرق ثانيتين
      await Future.delayed(const Duration(seconds: 2));

      if (email != "taken@byma.com") {
        print('Cubit: SignUpSuccess');
        emit(SignUpSuccess('Account created successfully!'));
      } else {
        print('Cubit: SignUpValidationError');
        emit(SignUpValidationError({'email': 'This email is already registered'}));
      }
      
    } catch (e) {
      print('Cubit: SignUpFailure');
      emit(SignUpFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}