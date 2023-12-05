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
  int _reloadKey = 0;

  @override
  void initState() {
    super.initState();
  }

  void updatePostList() {
    setState(() {
      // TODO: id 변경
      postList = PostApiService.getPostList(7);
      _reloadKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: id변경
    postList = PostApiService.getPostList(7);
    return SingleChildScrollView(
      child: Column(
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
              key: ValueKey(_reloadKey),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<PostModel> posts = snapshot.data!;
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int idx) {
                        return GestureDetector(
                          onTap: () {
                            _showPostDialog(context, posts[idx]);
                          },
                          child: PostWidget(post: posts[idx]),
                        );
                      });
                } else {
                  // return Text(snapshot.error.toString());
                  // return const Center(child: CircularProgressIndicator());
                  return Container();
                }
              }),
          // SingleChildScrollView(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       PostWidget(
          //           post: PostModel.fromJson({
          //         'postId': 200,
          //         'familyMemberId': 2,
          //         'title': '',
          //         'context':
          //             'helloooo\nhelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooo\nhelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooo\nhelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooo\nhelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooo\nhelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooohelloooo',
          //         'createdYear': 2023,
          //         'createdMonth': 12,
          //         'createdDay': 3,
          //         'createdHour': 14,
          //         'createdMinute': 58,
          //         'familyId': 7
          //       })),
          //       PostWidget(
          //           post: PostModel.fromJson({
          //         'postId': 200,
          //         'familyMemberId': 2,
          //         'title': '',
          //         'context': 'helloooo\nhellooo',
          //         'createdYear': 2023,
          //         'createdMonth': 12,
          //         'createdDay': 3,
          //         'createdHour': 14,
          //         'createdMinute': 58,
          //         'familyId': 7
          //       }))
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<dynamic> _showPostDialog(BuildContext context, PostModel post) {
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
              // TODO: role별 색상으로 변경
              color: AppColor.objectColor,
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 35, 35, 45),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(post.context,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColor.swatchColor, fontSize: 20)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 200,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showPutPostDialog(context, post.context, post);
                          },
                          icon: const Icon(CupertinoIcons.pen)),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            PostApiService.deletePost(post.postId).then(
                              (value) {
                                updatePostList();
                              },
                            );
                          },
                          icon: const Icon(CupertinoIcons.trash))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showPutPostDialog(
      BuildContext context, String text, PostModel post) {
    TextEditingController textController = TextEditingController(text: text);
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 55),
                  child: TextField(
                    maxLines: null,
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(15),
                      //     borderSide:
                      //         const BorderSide(color: AppColor.swatchColor)),
                      isDense: true,
                      // hintText: "Leave your message!",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.4)),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 110,
                  right: 110,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // post
                        DateTime postedTime = DateTime.now();
                        // TODO: id변경
                        PostApiService.putPost(
                                post.postId,
                                3,
                                textController.text,
                                postedTime.year,
                                postedTime.month,
                                postedTime.day,
                                postedTime.hour,
                                postedTime.minute)
                            .then(
                          (value) {
                            updatePostList();
                          },
                        );
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColor.swatchColor)),
                      child: const Text(
                        "Attach",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        );
      },
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 55),
                  child: TextField(
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
                ),
                Positioned(
                  bottom: 10,
                  right: 110,
                  left: 110,
                  child: ElevatedButton(
                      onPressed: () {
                        // post
                        DateTime postedTime = DateTime.now();
                        // TODO: id변경
                        Future<int> id = PostApiService.postPost(
                            4,
                            7,
                            textController.text,
                            postedTime.year,
                            postedTime.month,
                            postedTime.day,
                            postedTime.hour,
                            postedTime.minute);
                        id.then(
                          (value) {
                            updatePostList();
                          },
                        );
                        Navigator.of(context).pop();
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColor.swatchColor)),
                      child: const Text(
                        "Attach",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
