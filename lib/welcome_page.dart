import 'package:flutter/material.dart';
import 'package:snack_track_login_page/sign_up_page.dart';
import 'package:snack_track_login_page/log_in_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  void stub()
  {}

  void goToSignUpPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SignUpPage(),
    ));
  }

  void goToLogInPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => LogInPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 227, 175),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 7,
          ),
          SizedBox(
            height: 250,
            width: MediaQuery.sizeOf(context).width,
            child: Image(
              image: AssetImage("assets/images/snacktrack_logo 1.png"),
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 240,
          ),
          ElevatedButton(
            onPressed: goToSignUpPage,
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: goToLogInPage,
            child: Text(
              "Log in",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}