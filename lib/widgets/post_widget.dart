import 'package:fam_story_frontend/models/post_model.dart';
import 'package:fam_story_frontend/services/post_api_service.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late PostModel post;

  @override
  void initState() {
    super.initState();
    post = widget.post;
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
                Container(
                  width: 155,
                  height: 140,
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Center(
                        child: Text(
                            // overflow: TextOverflow.ellipsis,
                            post.context,
                            style: const TextStyle(
                                color: AppColor.swatchColor, fontSize: 20)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 3, 0),
                  child: Text(
                    '${post.createdYear}-${post.createdMonth}-${post.createdDay} ${post.createdHour}:${post.createdMinute}',
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
