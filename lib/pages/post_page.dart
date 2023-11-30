import 'package:fam_story_frontend/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fam_story_frontend/style.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        // TODO: post
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
        const Row(
          children: [
            // TODO: ListView.builder로 변경
            PostWidget(
              title: '',
              member: 'member',
              createdDate: '2023-11-06',
              context: '밥 묵고 학교 가라 아들들 ~ 냉장고 안에 넣어뒀단다',
              role: 1,
            ),
            PostWidget(
              title: 'title',
              member: 'member',
              createdDate: '2023-11-09',
              context: '안녕하세요',
              role: 1,
            ),
          ],
        ),
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
