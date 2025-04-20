import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/cubits/sign_up_cubit/sign_up_states.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpView extends StatelessWidget {
  static String id = 'signUp';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    String? email;

    String? password;

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChatView.id);
        } else if (state is SignUpFailure) {
          isLoading = false;
          showSnackBar(context, state.error);
        } else if (state is SignUpLoading) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 70),
                    Image.asset('assets/images/scholar.png', height: 150),
                    Text(
                      textAlign: TextAlign.center,
                      'Chat App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 54,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      textAlign: TextAlign.start,
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'enter your email',
                      labelText: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'enter your password',
                      labelText: 'Password',
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      text: 'Sign up',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          BlocProvider.of<SignUpCubit>(
                            context,
                          ).signUp(email: email!, password: password!);
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '  Login',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
