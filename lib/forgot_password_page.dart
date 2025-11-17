import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snack_track_login_page/account_services.dart';

class ForgotPasswordPage extends StatefulWidget{
  const ForgotPasswordPage({super.key});


  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();

}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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

  String? validateEmail(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter an email.';
    } else if (AccountServices.emailIsInvalid(input)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  void stub() {}

  void goBack() {
    Navigator.pop(context);
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
              height: 80,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "Forgot Password",
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
                "Email",
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
                controller: _emailController,
                validator: (value) => validateEmail(value),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);

                if (_formKey.currentState!.validate()) {

                  bool usernameAndEmailMatch = await AccountServices()
                      .usernameAndEmailMatch(_usernameController.text, _emailController.text);

                  if (usernameAndEmailMatch) {

                    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);

                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Password reset email sent.'),
                      )
                    );
                  } else {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text("Username and Email don't match."),
                      ),
                    );
                  }

                }

              },
              child: Text(
                "Send Email",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}