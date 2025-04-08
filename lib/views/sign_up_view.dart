import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static String id = 'signUp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            CustomTextField(hintText: 'enter your email', labelText: 'Email'),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'enter your password',
              labelText: 'Password',
            ),
            SizedBox(height: 30),
            CustomButton(text: 'Sign up'),
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
    );
  }
}
