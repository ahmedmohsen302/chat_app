import 'package:chat_app/cubits/login_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> logIn({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      // Attempt to sign in with Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // If successful, emit LoginSuccess
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      if (e.code == 'user-not-found') {
        emit(LoginFailure(error: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(error: 'Wrong password provided for that user'));
      } else if (e.code == 'invalid-email') {
        emit(LoginFailure(error: 'The email address is invalid'));
      } else {
        emit(
          LoginFailure(error: 'Firebase Authentication error: ${e.message}'),
        );
      }
    } catch (e) {
      // Handle unknown or non-Firebase exceptions
      emit(LoginFailure(error: 'An unknown error occurred: ${e.toString()}'));
    }
  }
}
