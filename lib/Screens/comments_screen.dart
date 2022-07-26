import 'package:e_commerce/Models/comments_model.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';

class ShowCommentsScreen extends StatelessWidget {
  const ShowCommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController CommentController = TextEditingController();
    CommentsInfo comment = CommentsInfo(
        name: "يعقوب قمر الدين دبيازة",
        comment: "the product is gamed gedn i want to buy more.",
        image:
            "https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png",
        time: "12/12/2022");
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Comments",
          style: TextStyle(color: Colors.deepOrange, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ProductComments(comment);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
                controller: CommentController,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  hintText: "add Comment",
                )),
          ),
        ],
      )),
    );
  }
}
