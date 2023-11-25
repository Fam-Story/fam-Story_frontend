import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final String title, context, createdDate, member;
  final int role;

  const PostWidget(
      {super.key,
      required this.title,
      required this.context,
      required this.createdDate,
      required this.member,
      required this.role});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  String title = '';
  String text = '';
  String createdDate = '';
  String member = '';
  int role = 0;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    text = widget.context;
    createdDate = widget.createdDate;
    member = widget.member;
    role = widget.role;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: SizedBox(
        height: 180,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onLongPressEnd: (details) {
                    // TODO: delete
                  },
                  child: Container(
                    width: 165,
                    height: 150,
                    decoration: BoxDecoration(
                      // TODO: role별 색상으로 변경
                      color: AppColor.objectColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: ListView(shrinkWrap: true, children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title != ''
                                ? Text(
                                    title,
                                    style: const TextStyle(
                                        color: AppColor.textColor,
                                        fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container(),
                            Text(
                                // overflow: TextOverflow.ellipsis,
                                text,
                                style: const TextStyle(
                                    color: AppColor.swatchColor, fontSize: 20))
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 3, 0),
                  child: Text(
                    createdDate,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
