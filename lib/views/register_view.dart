import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
          'Register',
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
                border: OutlineInputBorder(),
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
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                await AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email is already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'This is an invalid email address',
                );
              } on GenericAuthException {
                await showErrorDialog(context, 'Failed to register');
              }
            },
            child: const Text(
              'Register',
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
              ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text(
              'Already registered? Login here!',
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
