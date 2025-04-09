import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});
  static String id = 'signUp';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                  'Chat app',
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
                      setState(() {});
                      try {
                        await signUp();
                        showSnackBar(context, 'success');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'Weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'Email already in use');
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                      isLoading = false;
                      setState(() {});
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
  }

  Future<void> signUp() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
