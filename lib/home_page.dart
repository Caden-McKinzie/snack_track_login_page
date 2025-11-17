import 'package:flutter/material.dart';
import 'package:snack_track_login_page/log_out_window.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void goBack() {
    showDialog(
        context: context,
        builder: (context) => LogOutWindow()
    );
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
      body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              "Home Page",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 138, 95, 26),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * .75,
            child: Text(
              "The home page would start here.",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 138, 95, 26),
              ),
            ),
          ),
        ],
      ),
    );
  }

}