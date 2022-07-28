import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Shared/Components/Network/Local/comments_database.dart';
import 'package:e_commerce/Shared/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowCommentsScreen extends StatefulWidget {
  int productId;
  ShowCommentsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ShowCommentsScreen> createState() => _ShowCommentsScreenState();
}

class _ShowCommentsScreenState extends State<ShowCommentsScreen> {
  TextEditingController CommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Comments",
          style: TextStyle(color: Colors.deepOrange, fontSize: 25),
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
          child: BlocConsumer<BlocCubit, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: cubit.commentsData.length == 0
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "There is no reviews yet.",
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                "Add yours now.",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.deepOrange),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount: cubit.commentsData.length,
                          itemBuilder: (context, index) {
                            return ProductComments(cubit.commentsData[cubit.commentsData.length-index-1] , context);
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
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            String time = ActualTime();
                            String title = CommentController.text.toString();
                            if (title.isNotEmpty) {
                              CommentsDatabase.insertDatabase(
                                  userId: cubit.currentUser.id,
                                  productId: this.widget.productId,
                                  title: title,
                                  time: time);
                              print(title);
                              print(widget.productId);
                              print(cubit.currentUser.name);
                              print(time);
                              CommentController.clear();
                            }
                            SnackbarMessage(context, "Comment added");
                          },
                          child: Icon(
                            FontAwesomeIcons.plusCircle,
                            size: 30.0,
                            color: Colors.deepOrange,
                          )),
                      hintText: "add Comment",
                    )),
              ),
            ],
          );
        },
      )),
    );
  }
}
