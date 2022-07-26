import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Screens/register.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return BlocConsumer<BlocCubit, BlocState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                        validator: (String? value) {
                          bool validEmail = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.toString());
                          if (value!.isEmpty || !validEmail) {
                            return "Enter your Email";
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
                        validator: (String? value) {
                          if (value!.length == 0) {
                            return "Enter your Password";
                          } else if (value.length < 7) {
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
                        // validData();
                        int id = UsersDatabase.validData(
                            password: PasswordController.text,
                            mail: EmailController.text);
                        if (formKey.currentState!.validate() && id != -1) {
                          cubit.ChangeCurrentUserId(id);
                          print(cubit.currentUserId);
                          print(" Login Successfully ");
                        } else {
                          PasswordController.clear();
                          EmailController.clear();
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text(
                                    "Need Help?",
                                  ),
                                  content: const Text(
                                      "enter your email and password."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        child: const Text(
                                          "okay",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                        // Navigator.push(context,MaterialPageRoute(builder: (context) => const SecondRoute()),
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.deepOrange,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.deepOrange),
                        ))
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
