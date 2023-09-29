import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
        const SizedBox(
          height: 50,
        ),
        Text("Welcome $username"),
        const SizedBox(
          height: 50,
        ),
        MaterialButton(
          color: Colors.redAccent,
            onPressed: () {
          final Future<SharedPreferences> _prefs =
              SharedPreferences.getInstance();
          _prefs.then((SharedPreferences prefs) {
            prefs.remove("email");
            Navigator.pop(context);
          }
          );
        },
          child: const Text("Logout"))
      ]),
    ));
  }
}
