import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Chat",
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
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
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
      ]),
    ));
  }
}

class FamilyMemberButton extends StatelessWidget {
  final double buttonSize;
  final double imageSize;
  final String memberImage;
  final void Function() onTap;

  const FamilyMemberButton({
    super.key,
    required this.buttonSize,
    required this.imageSize,
    required this.memberImage,
    required this.onTap,
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
        onTap: onTap,
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

class InteractionButton extends StatelessWidget {
  final String interactionImage;
  final double size;

  const InteractionButton(
      {super.key, required this.interactionImage, required this.size});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColor.swatchColor.withOpacity(1),
        onTap: () {},
        child: Ink(
          width: size,
          height: size,
          child: Center(
            child: Image.asset(
              interactionImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class SpeechBubble extends CustomPainter {
  final Color color;

  SpeechBubble({
    required this.color,
  });

  final _radius = 20.0;
  final _x = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          0.0 + _x,
          0.0 + _x,
          size.width - _x,
          size.height - _x,
          bottomRight: Radius.circular(_radius),
          bottomLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
          topLeft: Radius.circular(_radius),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
    var path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width / 2 - _x / 1.5, _x);
    path.lineTo(size.width / 2 + _x / 1.5, _x);
    canvas.clipPath(path);
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          -_x,
          0.0,
          size.width,
          size.height,
          topRight: Radius.circular(_radius),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
