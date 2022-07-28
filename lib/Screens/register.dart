import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_database.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://thumbs.dreamstime.com/b/background-seamless-white-goods-category-online-store-gray-linear-icons-categories-65280732.jpg"),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(left:25.0, right: 25.0),
                child: Form(
                  key: formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height-50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                    color: Colors.black,
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
                          height: 10,
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey),
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey ,),
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
                                Navigator.pop(context);
                                // UsersDatabase.getData(UsersDatabase.database);
                              }
                            } else {
                              ShowDialogMessage("Need Help?",
                                  "Your mail or Name is in use", "okay", context);
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(500))),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}
