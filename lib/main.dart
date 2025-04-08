import 'package:chat_app/views/login_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const chatApp());
}

class chatApp extends StatelessWidget {
  const chatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginView.id: (context) => LoginView(),
        SignUpView.id: (context) => SignUpView(),
      },
      initialRoute: LoginView.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
