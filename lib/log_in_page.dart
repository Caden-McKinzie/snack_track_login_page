import 'package:flutter/material.dart';
import 'package:snack_track_login_page/account_services.dart';
import 'package:snack_track_login_page/forgot_password_page.dart';
import 'package:snack_track_login_page/home_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});


  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void stub() {}

  void stubLogIn() {}

  void goToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void goBack() {
    Navigator.pop(context);
  }

  String? validateUsername(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter a username.';
    } else if (AccountServices.usernameIsInvalid(input)) {
      return 'Username must be alpha-numeric.';
    } else if (AccountServices.usernameIsTooShort(input)) {
      return 'Username must be at least 8 characters long.';
    } else {
      return null;
    }
  }

  void goToForgotPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordPage(),
      ),
    );
  }

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter a password.';
    } else if (AccountServices.passwordIsInvalid(input)) {
      return 'Password must be alpha-numeric or contain !, @, #, \$, %,\n^, &, *, (, or ).';
    } else if (AccountServices.passwordIsTooShort(input)) {
      return 'Password must be at least 10 characters.';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 227, 175),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: IconButton(
            onPressed: goBack,
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              weight: 100,
              color: Color.fromARGB(255, 138, 95, 26),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "Log In",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 138, 95, 26),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 120,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "Username",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 138, 95, 26),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .8,
              child: TextFormField(
                controller: _usernameController,
                validator: (value) => validateUsername(value),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "Password",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 138, 95, 26),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .8,
              child: TextFormField(
                controller: _passwordController,
                validator: (value) => validatePassword(value),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 180,
            ),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);

                if (_formKey.currentState!.validate()) {
                  bool canLogIn = await AccountServices()
                      .logInUsernameAndPassword(_usernameController.text, _passwordController.text);

                  if (canLogIn) {
                    goToHomePage();
                  } else {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Username or Password Incorrect'),
                      ),
                    );
                  }
                }
              },
              child: Text(
                "Enter",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            TextButton(
              onPressed: goToForgotPasswordPage,
              child: Text(
                  "I forgot my password."
              ),
            )
          ],
        ),
      ),
    );
  }
}