import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountServices {

  static bool usernameIsInvalid(String username) {
    bool output = false;

    if (username.contains('~')) {
      output = true;
    } else if (username.contains('`')) {
      output = true;
    } else if (username.contains('!')) {
      output = true;
    } else if (username.contains('@')) {
      output = true;
    } else if (username.contains('#')) {
      output = true;
    } else if (username.contains('\$')) {
      output = true;
    } else if (username.contains('%')) {
      output = true;
    } else if (username.contains('^')) {
      output = true;
    } else if (username.contains('&')) {
      output = true;
    } else if (username.contains('*')) {
      output = true;
    } else if (username.contains('(')) {
      output = true;
    } else if (username.contains(')')) {
      output = true;
    } else if (username.contains('_')) {
      output = true;
    } else if (username.contains('-')) {
      output = true;
    } else if (username.contains('+')) {
      output = true;
    } else if (username.contains('=')) {
      output = true;
    } else if (username.contains('{')) {
      output = true;
    } else if (username.contains('}')) {
      output = true;
    } else if (username.contains('[')) {
      output = true;
    } else if (username.contains(']')) {
      output = true;
    } else if (username.contains('|')) {
      output = true;
    } else if (username.contains('\\')) {
      output = true;
    } else if (username.contains(':')) {
      output = true;
    } else if (username.contains(';')) {
      output = true;
    } else if (username.contains('"')) {
      output = true;
    } else if (username.contains('\'')) {
      output = true;
    } else if (username.contains('<')) {
      output = true;
    } else if (username.contains('>')) {
      output = true;
    } else if (username.contains(',')) {
      output = true;
    } else if (username.contains('.')) {
      output = true;
    } else if (username.contains('?')) {
      output = true;
    } else if (username.contains('/')) {
      output = true;
    } else if (username.contains(' ')) {
      output = true;
    }

    return output;
  }

  static bool usernameIsTooShort(String? username) {
    bool output = false;

    if (username == null || username.isEmpty) {
      output = true;
    } else if (username.length < 8) {
      output = true;
    }

    return output;
  }
  
  static bool passwordIsInvalid(String password) {
    bool output = false;

    if (password.contains('~')) {
      output = true;
    } else if (password.contains('`')) {
      output = true;
    } else if (password.contains('_')) {
      output = true;
    } else if (password.contains('-')) {
      output = true;
    } else if (password.contains('+')) {
      output = true;
    } else if (password.contains('=')) {
      output = true;
    } else if (password.contains('{')) {
      output = true;
    } else if (password.contains('}')) {
      output = true;
    } else if (password.contains('[')) {
      output = true;
    } else if (password.contains(']')) {
      output = true;
    } else if (password.contains('|')) {
      output = true;
    } else if (password.contains('\\')) {
      output = true;
    } else if (password.contains(':')) {
      output = true;
    } else if (password.contains(';')) {
      output = true;
    } else if (password.contains('"')) {
      output = true;
    } else if (password.contains('\'')) {
      output = true;
    } else if (password.contains('<')) {
      output = true;
    } else if (password.contains('>')) {
      output = true;
    } else if (password.contains(',')) {
      output = true;
    } else if (password.contains('.')) {
      output = true;
    } else if (password.contains('?')) {
      output = true;
    } else if (password.contains('/')) {
      output = true;
    } else if (password.contains(' ')) {
      output = true;
    }

    return output;
  }

  static bool passwordIsTooShort(String? password) {
    bool output = false;

    if (password == null || password.isEmpty) {
      output = true;
    } else if (password.length < 10) {
      output = true;
    }

    return output;
  }

  static bool emailIsInvalid(String? email) {
    bool output = false;

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');

    if (email == null || email.isEmpty) {
      output = true;
    } else if (!emailRegex.hasMatch(email)) {
      output = true;
    }

    return output;
  }

  static Future<void> createUser(String email, String username, String password) async {

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    await FirebaseFirestore.instance.collection('users').doc(username).set({
      'email' : email,
    });
  }

  static Future<bool> usernameAlreadyTaken(String username) async {

    final docRef = FirebaseFirestore.instance.collection('users').doc(username);

    final docSnapshot = await docRef.get();

    bool output = false;

    if (docSnapshot.exists) {
      output = true;
    }

    return output;
  }
  static Future<bool> emailAlreadyTaken(String email) async {

    bool output = false;

    final docSnapshot = await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: email).get();

    output = docSnapshot.docs.isNotEmpty;

    return output;
  }

  void logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> logInUsernameAndPassword(String username, String password) async {
    bool output = false;

    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(username).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()?['email'] as String?;
      if(data != null) {
        String email = data;

        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password
          );
          output = true;
        } on FirebaseAuthException {
          output = false;
        }

      }
    }

    return output;
  }
  Future<bool> usernameAndEmailMatch(String? username, String? email) async {
    bool output = false;

    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(username).get();

    if (!(username == null || username.isEmpty) && !(email == null || email.isEmpty)) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data()?['email'] as String?;
        if (data != null) {
          String usernameEmail = data;
          if (usernameEmail == email) {
            output = true;
          }
        }
      }
    }

    return output;
  }
}