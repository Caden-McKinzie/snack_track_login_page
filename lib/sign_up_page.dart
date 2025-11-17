import 'package:flutter/material.dart';
import 'package:snack_track_login_page/account_services.dart';
import 'package:snack_track_login_page/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  void stub() {}

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? validateEmail(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter an email.';
    } else if (AccountServices.emailIsInvalid(input)) {
      return 'Please enter a valid email address.';
    }
    return null;
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

  String? verifyPassword(String? input) {

    if (input == null || input.isEmpty || _passwordController.text != input) {
      return 'Password Does Not Match';
    } else {
      return null;
    }
  }

  void goBack(){
    Navigator.pop(context);
  }

  void goToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      )
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 227, 175),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(
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
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 138, 95, 26),
                ),
                textAlign: TextAlign.center,
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
              height: 40,
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
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "Verify Password",
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
                validator: (value) => verifyPassword(value),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);

                if (_formKey.currentState!.validate()) {
                  bool emailTaken = await AccountServices.emailAlreadyTaken(_emailController.text);
                  bool usernameTaken = await AccountServices.usernameAlreadyTaken(_usernameController.text);

                  if (emailTaken) {
                    if (!mounted) return;
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Email is already in use.',
                        ),
                      )
                    );
                  } else if (usernameTaken) {
                    if (!mounted) return;
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Username is already in use.',
                        ),
                      ),
                    );
                  } else {
                    await AccountServices.createUser(_emailController.text, _usernameController.text, _passwordController.text);
                    goToHomePage();
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
          ],
        ),
      ),
    );
  }
}