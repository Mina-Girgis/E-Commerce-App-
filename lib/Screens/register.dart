import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();

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
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: NameController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Enter valid name";
                          }
                        },
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          label: Text(
                            "Name",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
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
                        validator: (String? value) {
                          if (value!.length == 0) {
                            return "Enter valid Password";
                          } else if (value.length < 7) {
                            return "Enter Stronger Password";
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          label: Text(
                            "Password",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        controller: PhoneNumberController,
                        validator: (String? value) {
                          if (value!.isEmpty ||
                              value.length < 11 ||
                              value[0] != '0') {
                            return "Enter valid Phone number";
                          }
                        },
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          label: Text(
                            "Phone Number",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {
                        // UsersDatabase.deleteAllData();
                        // UsersDatabase.getData(UsersDatabase.database);

                        if (!UsersDatabase.isFoundInDatabase(
                            name: NameController.value.text,
                            mail: EmailController.value.text)) {
                          if (formKey.currentState!.validate()) {
                            String name = NameController.text;
                            String email = EmailController.text;
                            String phone = PhoneNumberController.text;
                            String password = PasswordController.text;
                            print(name);
                            print(email);
                            print(phone);
                            print(password);
                            UsersDatabase.insertDatabase(
                                name: name,
                                email: email,
                                password: password,
                                phoneNumber: phone,
                                address: "");
                            print(" Login Successfully ");
                            // UsersDatabase.getData(UsersDatabase.database);
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text("Alert Dialog Box"),
                                  content: const Text(
                                      "You have raised a Alert Dialog Box"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                        // Navigator.push(context,MaterialPageRoute(builder: (context) => const SecondRoute()),
                      },
                      child: const Text(
                        "Sign Up",
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
                    const Text("Already have an account ? "),
                    FlatButton(
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: const Text(
                          "Sign in",
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
