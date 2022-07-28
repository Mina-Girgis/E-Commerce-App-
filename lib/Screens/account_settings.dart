import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_database.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettings extends StatelessWidget {
  AccountSettings({Key? key}) : super(key: key);

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
          appBar: AppBar(
            elevation: 1.0,
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.deepOrange,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
              child: Form(
                key: formKey,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Account Settings",
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        minRadius: 60.0,
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        backgroundColor: Colors.deepOrange,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        NameController.text = value;
                        print(NameController.text);
                      },
                      initialValue: cubit.currentUser.name,
                      // controller: NameController,
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
                      // readOnly: true,
                      onChanged: (value) {
                        EmailController.text = value;
                        print(EmailController.text);
                      },
                      initialValue: cubit.currentUser.mail,
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
                      onChanged: (value) {
                        PasswordController.text = value;
                        print(PasswordController.text);
                      },
                      initialValue: cubit.currentUser.password,
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
                      onChanged: (value) {
                        PhoneNumberController.text = value;
                        print(PhoneNumberController.text);
                      },
                      initialValue: cubit.currentUser.phoneNumber,
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (NameController.text.isEmpty)
                          NameController.text = cubit.currentUser.name;
                        if (EmailController.text.isEmpty)
                          EmailController.text = cubit.currentUser.mail;
                        if (PasswordController.text.isEmpty)
                          PasswordController.text = cubit.currentUser.password;
                        if (PhoneNumberController.text.isEmpty)
                          PhoneNumberController.text =
                              cubit.currentUser.phoneNumber;
                        //*******************************

                        if (NameController.text == cubit.currentUser.name &&
                            EmailController.text == cubit.currentUser.mail &&
                            PasswordController.text ==
                                cubit.currentUser.password &&
                            PhoneNumberController.text ==
                                cubit.currentUser.phoneNumber) {
                          SnackbarMessage(context, "No Data Changed");
                        } else {
                          if (NameController.text != cubit.currentUser.name ||
                              EmailController.text != cubit.currentUser.mail ||
                              PasswordController.text !=
                                  cubit.currentUser.password ||
                              PhoneNumberController.text !=
                                  cubit.currentUser.phoneNumber) {
                            if (PasswordController.text.length >= 7 &&
                                PhoneNumberController.text.toString()[0] ==
                                    '0' &&
                                PhoneNumberController.text.toString()[1] ==
                                    '1' &&
                                PhoneNumberController.text.length == 11) {
                              if (!UsersDatabase.isFoundInDatabase(
                                  name: NameController.text,
                                  mail: EmailController.text)) {
                                UsersDatabase.updateDatabase(
                                    name: NameController.text,
                                    phone: PhoneNumberController.text,
                                    email: EmailController.text,
                                    password: PasswordController.text,
                                    id: int.parse(cubit.currentUser.id));

                                cubit.currentUser.phoneNumber =
                                    PhoneNumberController.text;
                                cubit.currentUser.name = NameController.text;
                                cubit.currentUser.password =
                                    PasswordController.text;
                                cubit.currentUser.mail = EmailController.text;
                                print(cubit.currentUser.mail);
                                SnackbarMessage(context, "Data is updated");
                                UsersDatabase.getData(UsersDatabase.database);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else {
                                print("Data is used by someone else");
                                SnackbarMessage(
                                    context, "Email/Name is in Use");
                              }
                            } else {
                              print("Invalid Data ");
                              SnackbarMessage(context, "Invalid Data");
                            }
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Colors.deepOrange,
                    minWidth: 200,
                    height: 55,
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                  ),
                ]),
              ),
            )),
          ),
        );
      },
    );
  }
}
