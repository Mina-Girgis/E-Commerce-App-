import 'package:e_commerce/Screens/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://previews.123rf.com/images/elenavdovina/elenavdovina1701/elenavdovina170100352/70728732-background-seamless-orange-product-categories-online-store-seamless-orange-background-with-white-lin.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "All that you need,\n"
                "    All that you want,\n"
                "           Zoba is here !",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: const Text(
                  "Create an account",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                color: Colors.white,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                color: Colors.white,
                minWidth: 300,
                height: 55,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
