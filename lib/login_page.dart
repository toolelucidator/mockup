import 'package:flutter/material.dart';
import 'package:mockup/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late bool emailExist = false;

  void _submit() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
  }

  saveData() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("email", usernameController.text.trim());
    print("Value stored on SP" + usernameController.text.trim());
  }

  readData() async {
    final SharedPreferences prefs = await _prefs;
    final String? email = prefs.getString("email");
    if (email != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LandingPage(
                  username: email,
                )),
      );
      setState(() {
        emailExist = true;
      });
      print("The value stored on memory of SP is : $email");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Login Page",
              style: TextStyle(
                fontSize: 30,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                onFieldSubmitted: (value) {
                  print(value);
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Enter your email',
                  labelText: 'Username',
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                onFieldSubmitted: (value) {
                  print(value);
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _submit();
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    saveData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LandingPage(
                                username: usernameController.text.trim(),
                              )),
                    ).then((res) {
                      usernameController.clear();
                      passwordController.clear();
                    });
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ]),
    );
  }
}
