import 'dart:convert';

import 'package:fam_story_frontend/models/post_model.dart';
import 'package:fam_story_frontend/services/post_api_service.dart';
import 'package:fam_story_frontend/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fam_story_frontend/style.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<List<PostModel>> postList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: id변경
    postList = PostApiService.getPostList(7);
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Post",
                      style: TextStyle(
                          fontFamily: 'AppleSDGothicNeo',
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                          fontSize: 35),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _showAddingPostDialog(context);
                      },
                      icon: const Icon(CupertinoIcons.add_circled_solid),
                      color: AppColor.swatchColor,
                      iconSize: 35,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
        FutureBuilder(
            future: postList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int idx) {
                      return PostWidget(post: snapshot.data![idx]);
                    });
              } else {
                return Text(snapshot.error.toString());
              }
            }),
        PostWidget(
            post: PostModel.fromJson({
          'postId': 200,
          'familyMemberId': 2,
          'title': '',
          'context': 'helloooo',
          'createdYear': 2023,
          'createdMonth': 12,
          'createdDay': 3,
          'createdHour': 14,
          'createdMinute': 58,
          'familyId': 7
        }))
      ],
    );
  }

  Future<dynamic> _showAddingPostDialog(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(20)),
              color: AppColor.objectColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  TextField(
                    maxLines: null,
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(15),
                      //     borderSide:
                      //         const BorderSide(color: AppColor.swatchColor)),
                      isDense: true,
                      hintText: "Leave your message!",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.4)),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // post
                            DateTime postedTime = DateTime.now();
                            // TODO: id변경
                            PostApiService.postPost(
                                1,
                                7,
                                textController.text,
                                postedTime.year,
                                postedTime.month,
                                postedTime.day,
                                postedTime.hour,
                                postedTime.minute);
                            Navigator.of(context).pop();
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColor.swatchColor)),
                          child: const Text(
                            "Attach",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
