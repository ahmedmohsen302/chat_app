import 'package:chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          // Attempt to sign in with Firebase
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );

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
              LoginFailure(
                error: 'Firebase Authentication error: ${e.message}',
              ),
            );
          }
        } catch (e) {
          // Handle unknown or non-Firebase exceptions
          emit(
            LoginFailure(error: 'An unknown error occurred: ${e.toString()}'),
          );
        }
      } else if (event is SignUpEvent) {
        emit(SignUpLoading());
        try {
          // Attempt to sign in with Firebase
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );

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
              SignUpFailure(
                error: 'Firebase Authentication error: ${e.message}',
              ),
            );
          }
        } catch (e) {
          // Handle unknown or non-Firebase exceptions
          emit(
            SignUpFailure(error: 'An unknown error occurred: ${e.toString()}'),
          );
        }
      }
    });
  }
}
