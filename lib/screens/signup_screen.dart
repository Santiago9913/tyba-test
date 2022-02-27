import 'package:firebase_auth/firebase_auth.dart' as Credentials;
import 'package:flutter/material.dart';
import 'package:tyba_challenge/handlers/firebase_handler.dart';
import 'package:tyba_challenge/models/user.dart';
import 'package:tyba_challenge/screens/restaurants_screens.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool enabled = false;
  String error = "";

  late User user;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void checkFields() {
    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
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

  Future<void> createUser() async {
    Credentials.UserCredential credentials = await FirebaseHandler.createUser(
        emailController.text, passwordController.text);

    user = User(
        name: nameController.text,
        email: emailController.text,
        uid: credentials.user!.uid);
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
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 30, top: 100),
                child: TextField(
                  controller: nameController,
                  onChanged: (String val) {
                    checkFields();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
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
              Padding(
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
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed: enabled
                      ? () async {
                          try {
                            await createUser();
                            await FirebaseHandler.addUsertoDB(user);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RestaurantsScreen(user: user),
                              ),
                            );
                          } on Credentials.FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              error = "The password provided is too weak.";
                            } else if (e.code == 'email-already-in-use') {
                              error =
                                  "The account already exists for that email.";
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
                    "Sign Up",
                    style: TextStyle(fontSize: 30),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
