import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:tyba_challenge/screens/login_screen.dart';
import 'package:tyba_challenge/screens/signup_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TybaApp());
}

class TybaApp extends StatelessWidget {
  const TybaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tyba(),
    );
  }
}

class Tyba extends StatefulWidget {
  const Tyba({Key? key}) : super(key: key);

  @override
  _TybaState createState() => _TybaState();
}

class _TybaState extends State<Tyba> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen()),
                    );
                  },
                  child: const Text(
                    "log In",
                    style: TextStyle(fontSize: 30),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
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
    );
  }
}
