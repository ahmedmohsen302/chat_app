import 'package:chat_app/cubits/sign_up_cubit/sign_up_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({required String email, required String password}) async {
    emit(SignUpLoading());
    try {
      // Attempt to sign in with Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // If successful, emit LoginSuccess
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      if (e.code == 'email-already-in-use') {
        emit(
          SignUpFailure(
            error: 'The email is already associated with an account.',
          ),
        );
      } else if (e.code == 'weak-password') {
        emit(SignUpFailure(error: 'The password provided is too weak.'));
      } else if (e.code == 'invalid-email') {
        emit(SignUpFailure(error: 'The email address is invalid.'));
      } else {
        emit(
          SignUpFailure(error: 'Firebase Authentication error: ${e.message}'),
        );
      }
    } catch (e) {
      // Handle unknown or non-Firebase exceptions
      emit(SignUpFailure(error: 'An unknown error occurred: ${e.toString()}'));
    }
  }
}
