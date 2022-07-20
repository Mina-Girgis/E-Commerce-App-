import 'package:e_commerce/Screens/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
            const Text(
              "All that you need,\n"
              "    All that you want,\n"
              "           Zoba is here !",
              style: TextStyle( fontSize: 30),
            ),
            const SizedBox(height: 20,),
            MaterialButton(
              onPressed: () {
               // Navigator.push(context,MaterialPageRoute(builder: (context) => const RegisterScreen()));
              },
              child: const Text(
                "Create an account",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: const Color.fromRGBO(252, 92, 69, 1.0),
              minWidth: 300,
              height: 55,
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            const SizedBox(
              height: 30,

            ),
            MaterialButton(
              onPressed: () {
                 // Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text(
                "Sign in",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: const Color.fromRGBO(252, 92, 69, 1.0),
              minWidth: 300,
              height: 55,
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
        ],
      ),
          )
      ),
    );
  }
}
