import 'package:firebase_auth/firebase_auth.dart' as Credentials;
import 'package:flutter/material.dart';
import 'package:tyba_challenge/handlers/firebase_handler.dart';
import 'package:tyba_challenge/models/user.dart';
import 'package:tyba_challenge/screens/restaurants_screens.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool enabled = false;
  String error = "";
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
    user = await FirebaseHandler.getUserFromDB(credentials.user!.uid);
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
                      ? () async {
                          try {
                            await login();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RestaurantsScreen(user: user),
                              ),
                            );
                          } on Credentials.FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              error = "No user found for that email.";
                            } else if (e.code == 'wrong-password') {
                              error = "Wrong password provided for that user.";
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error),
                                backgroundColor: Colors.red.shade600,
                              ),
                            );
                          }
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
