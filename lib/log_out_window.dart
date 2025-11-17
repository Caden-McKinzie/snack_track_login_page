import 'package:flutter/material.dart';

class LogOutWindow extends StatelessWidget {
  const LogOutWindow({super.key});


  void stub() {}

  // TODO: Handle Log out process
  void logOut(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Log Out?',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      content: Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => logOut(context),
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () => goBack(context),
          child: Text('No'),
        ),
      ],
    );

  }


}