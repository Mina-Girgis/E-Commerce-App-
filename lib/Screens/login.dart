import 'package:e_commerce/Screens/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController EmailController    = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
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
                  controller: EmailController,
                  validator: (String?value){
                    bool validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString());
                      if(value!.isEmpty || !validEmail){
                        return "Enter valid Email";
                      }
                  },
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
                  controller: PasswordController,
                  validator: (String? value){
                      if(value!.length == 0){
                          return "Min length is 7";
                      }
                      else if(value.length < 7){
                        return "Enter Stronger Password";
                      }
                      return null;
                  },
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
                    if(formKey.currentState!.validate()){
                      print(" Login Successfully ");
                    }
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
          ),
        )),
      ),
    );
  }
}
