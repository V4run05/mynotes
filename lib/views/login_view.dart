import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Color.fromARGB(255, 122, 192, 250),
            fontFamily: "Poppins",
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          Center(
            child: SizedBox(
              width: 327.5,
              height: 50,
              child: TextField(
                cursorColor: Color.fromARGB(255, 122, 192, 250),
                cursorErrorColor: Color.fromARGB(255, 122, 192, 250),
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Enter you email here',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 122, 192, 250),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 122, 192, 250),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 122, 192, 250),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 122, 192, 250),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 327.5,
            height: 50,
            child: TextField(
              cursorColor: Color.fromARGB(255, 122, 192, 250),
              cursorErrorColor: Color.fromARGB(255, 122, 192, 250),
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Enter your password here',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 122, 192, 250),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 122, 192, 250),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 122, 192, 250),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 122, 192, 250),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().login(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, 'User not found');
              } on WrongPasswordAuthException {
                await showErrorDialog(context, 'Incorrect password');
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication error');
              }
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Color.fromARGB(255, 122, 192, 250),
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: Text(
              'Not registered yet? Register here!',
              style: TextStyle(
                color: Color.fromARGB(255, 122, 192, 250),
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
