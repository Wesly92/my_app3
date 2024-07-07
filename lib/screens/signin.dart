import 'package:flutter/material.dart';
import 'package:my_app/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  void _signInWithGoogle() async {
    final user = await _auth.signInWithGoogle();
    if (user != null) {
      // User signed in
    } else {
      // Error or cancelled
    }
  }

  void _signInWithApple() async {
    final user = await _auth.signInWithApple();
    if (user != null) {
      // User signed in
    } else {
      // Error or cancelled
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: const Text('Sign in with Google'),
            ),
            ElevatedButton(
              onPressed: _signInWithApple,
              child: const Text('Sign in with Apple'),
            ),
          ],
        ),
      ),
    );
  }
}
