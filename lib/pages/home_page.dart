import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroudColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroudColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.alarm_on)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: const SafeArea(child: HomeBody()),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 30,
              color: AppColor.swatchColor,
              child: Center(child: const Text("웅찌의 집")),
            ),
            const SizedBox(
              height: 140,
            ),
            Stack(
              clipBehavior: Clip.none,
              fit: StackFit.passthrough,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  color: AppColor.swatchColor,
                ),
                //FamilyMemberButton
                Positioned(
                    top: -120,
                    left: 170,
                    child: SizedBox(
                      child: FamilyMemberButton(
                          size: 0.28, onTap: () {}, child: const Text("엄마")),
                    )),
                Positioned(
                    top: -120,
                    left: 30,
                    child: SizedBox(
                      child: FamilyMemberButton(
                          size: 0.28, onTap: () {}, child: const Text("아빠")),
                    )),
                Positioned(
                    top: 10,
                    left: -40,
                    child: SizedBox(
                      child: FamilyMemberButton(
                          size: 0.28, onTap: () {}, child: const Text("누나")),
                    )),
                Positioned(
                    top: 150,
                    left: -40,
                    child: SizedBox(
                      child: FamilyMemberButton(
                          size: 0.28, onTap: () {}, child: const Text("동생")),
                    )),
                Positioned(
                    top: 100,
                    left: 180,
                    child: SizedBox(
                      child: FamilyMemberButton(
                          size: 0.4, onTap: () {}, child: const Text("나")),
                    )),
                //InteractionButton
                Positioned(
                    top: 85,
                    left: 235,
                    child: SizedBox(
                      child: InteractionButton(
                          onTap: () {}, child: const Text("나")),
                    )),
                Positioned(
                    top: 98,
                    left: 173,
                    child: SizedBox(
                      child: InteractionButton(
                          onTap: () {}, child: const Text("나")),
                    )),
                Positioned(
                    top: 142,
                    left: 125,
                    child: SizedBox(
                      child: InteractionButton(
                          onTap: () {}, child: const Text("나")),
                    )),
                Positioned(
                    top: 205,
                    left: 115,
                    child: SizedBox(
                      child: InteractionButton(
                          onTap: () {}, child: const Text("나")),
                    )),
                //SpeechBubble
                Positioned(
                  top: 310,
                  left: 210,
                  child: CustomPaint(
                    painter: SpeechBubble(
                        color: AppColor.textColor,
                        alignment: Alignment.topRight),
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: const Text("배고파"),
                    ),
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

class FamilyMemberButton extends StatelessWidget {
  final double size;
  final Widget child;
  final void Function() onTap;

  const FamilyMemberButton({
    super.key,
    required this.size,
    required this.child,
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
          width: screenWidth * size,
          height: screenHeight * size,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class InteractionButton extends StatelessWidget {
  final Widget child;
  final void Function() onTap;

  const InteractionButton({
    super.key,
    required this.child,
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
          width: screenWidth * 0.15,
          height: screenHeight * 0.15,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: AppColor.subColor,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class SpeechBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;

  SpeechBubble({
    required this.color,
    required this.alignment,
  });

  final _radius = 20.0;
  final _x = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
