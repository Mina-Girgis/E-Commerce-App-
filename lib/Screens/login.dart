import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/usermodel.dart';
import 'package:e_commerce/Screens/homescreen.dart';
import 'package:e_commerce/Screens/register.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_database.dart';
import 'package:e_commerce/Shared/Components/Network/Local/user_fav_database.dart';
import 'package:e_commerce/Shared/Components/components.dart';
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
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://thumbs.dreamstime.com/b/background-seamless-white-goods-category-online-store-gray-linear-icons-categories-65280732.jpg"),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(left : 25.0 , right: 25.0),
                child: Form(
                  key: formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Log in",
                                  style: TextStyle(fontSize: 30),
                                ),
                                SizedBox(
                                  height: 20,
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
                          onPressed: () async {
                            // validData();
                            User user = UsersDatabase.validData(
                                password: PasswordController.text,
                                mail: EmailController.text);
                            if (formKey.currentState!.validate() &&
                                user.id != -1) {
                              cubit.ChangeCurrentUser(user);
                              BlocCubit.currentUserID = int.parse(user.id);
                              print(" Login Successfully ");
                              // Get Some Work From DataBase;
                              await UserFavDatabase.getData(
                                  UserFavDatabase.database, int.parse(user.id));
                              cubit.SetFavProducts();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()));
                            } else {
                              PasswordController.clear();
                              EmailController.clear();
                              ShowDialogMessage(
                                  "Need Help?",
                                  "enter your email and password.",
                                  "okay",
                                  context);
                            }
                            // Navigator.push(context,MaterialPageRoute(builder: (context) => const SecondRoute())),
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          color: Colors.deepOrange,
                          minWidth: 300,
                          height: 56,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(500))),
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
                            )),
                        // SizedBox(height: 50,),
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
