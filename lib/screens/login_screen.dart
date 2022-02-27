import 'package:firebase_auth/firebase_auth.dart' as Credentials;
import 'package:flutter/material.dart';
import 'package:tyba_challenge/handlers/firebase_handler.dart';
import 'package:tyba_challenge/models/user.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool enabled = false;
  late User user;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkFields() {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      setState(() {
        enabled = true;
      });
    } else {
      if (enabled) {
        setState(() {
          enabled = false;
        });
      }
    }
  }

  Future<void> login() async {
    Credentials.UserCredential credentials = await FirebaseHandler.loginUser(
        emailController.text, passwordController.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: emailController,
                  onChanged: (String val) {
                    checkFields();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextField(
                  controller: passwordController,
                  onChanged: (String val) {
                    checkFields();
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed: enabled
                      ? () {
                          print("Hello");
                        }
                      : null,
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 30),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
