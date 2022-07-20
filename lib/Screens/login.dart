import 'package:e_commerce/Screens/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Log in",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    label: Text(
                      "Email",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  obscureText: true,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(

                      label: Text(
                    "Password",
                    style: TextStyle(fontSize: 20),
                  ))),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  // Navigator.push(context,MaterialPageRoute(builder: (context) => const SecondRoute()),
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: const Color.fromRGBO(252, 92, 69, 1.0),
                minWidth: 300,
                height: 56,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(500))),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Don't have an account ? "),
              FlatButton(
                  onPressed: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromRGBO(252, 92, 69, 1.0)),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
