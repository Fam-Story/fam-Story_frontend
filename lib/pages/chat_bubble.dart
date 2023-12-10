import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../style.dart';

class ChatBubbles extends StatelessWidget {
  //역할, 별명, 메시지, 시간, 본인 확인
  const ChatBubbles(
      this.role, this.nickname, this.message, this.date, this.isMe,
      {Key? key})
      : super(key: key);

  final int role;
  final String nickname;
  final String message;
  final String date;
  final bool isMe;

  String getRoleImage(int role) {
    switch (role) {
      case 1:
        return 'assets/images/grandfather.png';
      case 2:
        return 'assets/images/dad.png';
      case 3:
        return 'assets/images/son.png';
      case 4:
        return 'assets/images/grandmother.png';
      case 5:
        return 'assets/images/mom.png';
      case 6:
        return 'assets/images/daughter.png';
      default:
        return 'assets/images/son.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMe)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 5, 0),
                    child: Text(
                      date,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ChatBubble(
                    clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
                    backGroundColor: AppColor.subColor,
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(top: 20, bottom: 3),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (!isMe)
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
              child: Row(
                children: [
                  ChatBubble(
                    clipper:
                        ChatBubbleClipper8(type: BubbleType.receiverBubble),
                    backGroundColor: AppColor.objectColor,
                    margin: const EdgeInsets.only(top: 20, bottom: 3),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 40, 0, 0),
                    child: Text(
                      date,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
      if (!isMe)
        Positioned(
          top: 0,
          left: 15,
          child: FamilyMemberButton(
            buttonSize: 0.1,
            imageSize: 25,
            memberImage: getRoleImage(role),
          ),
        ),
      if (!isMe)
        Positioned(
          top: 18,
          left: 65,
          child: Text(
            nickname,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
    ]);
  }
}

class FamilyMemberButton extends StatelessWidget {
  final double buttonSize;
  final double imageSize;
  final String memberImage;

  const FamilyMemberButton({
    super.key,
    required this.buttonSize,
    required this.imageSize,
    required this.memberImage,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        splashColor: AppColor.subColor.withOpacity(0.3),
        onTap: null,
        child: Ink(
          width: screenWidth * buttonSize,
          height: screenHeight * buttonSize,
          decoration: const BoxDecoration(
            color: AppColor.objectColor,
          ),
          child: Center(
            child: Image.asset(
              memberImage,
              fit: BoxFit.fill,
              width: imageSize, // 원하는 너비로 조절
              height: imageSize, // 원하는 높이로 조절
            ),
          ),
        ),
      ),
    );
  }
}
