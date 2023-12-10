import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/family_member_model.dart';
import '../services/family_member_api_service.dart';
import 'setting_page.dart';
import 'package:fam_story_frontend/models/family_model.dart';
import 'package:fam_story_frontend/models/user_model.dart';

enum Interaction { thumbUp, thumbDown, heart, poke }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  String myState = '';

  void interaction(Interaction data) {
    if (data == Interaction.thumbUp) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('thumb up'),
      ));
    } else if (data == Interaction.thumbDown) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('thumb down'),
      ));
    } else if (data == Interaction.heart) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('heart'),
      ));
    } else if (data == Interaction.poke) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('poke'),
      ));
    }
  }

  void myStateDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 10.0,
          icon: const Icon(Icons.account_box, size: 50),
          iconColor: AppColor.swatchColor,
          title: const Center(
              child: Text(
            'My State',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor,
            ),
          )),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _textEditingController,
              maxLength: 11,
              decoration: InputDecoration(
                  labelText: _textEditingController.text,
                  suffixIcon: IconButton(
                      onPressed: () => _textEditingController.clear(),
                      icon: const Icon(
                        Icons.cancel,
                        size: 20,
                      )),
                  focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColor.objectColor,
                    width: 2,
                  ))),
              inputFormatters: [
                FilteringTextInputFormatter(
                  RegExp('[a-z A-Z |0-9]'),
                  allow: true,
                )
              ],
              onSaved: (value) {
                myState = value!;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final formKeyState = _formKey.currentState!;
                if (formKeyState.validate()) {
                  formKeyState.save();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Ok',
                  style: TextStyle(color: AppColor.swatchColor, fontSize: 18)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back',
                  style: TextStyle(color: AppColor.swatchColor, fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // family 수를 여기에 저장
    int familyMember = 5;

    return SafeArea(
      child: Center(
        child: Column(
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
                      //TODO: 패밀리 이름으로 변경
                      "Living Room",
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
                        icon: const Icon(Icons.alarm_on),
                        color: AppColor.swatchColor,
                        iconSize: 35),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingPage()),
                          );
                        },
                        icon: const Icon(Icons.settings),
                        color: AppColor.swatchColor,
                        iconSize: 35),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
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

                //FamilyMember round
                if (familyMember == 5) ...[
                  Positioned(
                    top: -120,
                    left: 170,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: 'assets/images/mom.png',
                          onTap: () async {
                            //FamilyMemberApi 테스트
                            /*
                            print(await FamilyMemberApiService.putFamilyMember(
                                15, 1, "하잉"));
                            List<FamilyMemberModel> x =
                                await FamilyMemberApiService.getAllFamilyMember(
                                    13);
                            for (var member in x) {
                              print(member.familyMemberId);
                              print(member.talkCount);
                              print(member.pokeCount);
                              print(member.name);
                              print(member.nickname);
                              print(member.role);
                              print(member.introMessage);
                            }

                             */
                          },
                        );
                      },
                      onAccept: (data) {
                        interaction(data);
                      },
                    ),
                  ),
                  Positioned(
                    top: -120,
                    left: 30,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: 'assets/images/dad.png',
                          onTap: () {},
                        );
                      },
                      onAccept: (data) {
                        interaction(data);
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: -40,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: 'assets/images/grandmother.png',
                          onTap: () {},
                        );
                      },
                      onAccept: (data) {
                        interaction(data);
                      },
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: -40,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: 'assets/images/daughter.png',
                          onTap: () {},
                        );
                      },
                      onAccept: (data) {
                        interaction(data);
                      },
                    ),
                  ),
                ] else if (familyMember == 4) ...[
                  Positioned(
                    top: -120,
                    left: 170,
                    child: FamilyMemberButton(
                      buttonSize: 0.36,
                      imageSize: 90,
                      memberImage: 'assets/images/son.png',
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    top: -120,
                    left: 20,
                    child: FamilyMemberButton(
                      buttonSize: 0.36,
                      imageSize: 90,
                      memberImage: 'assets/images/son.png',
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: -40,
                    child: FamilyMemberButton(
                      buttonSize: 0.32,
                      imageSize: 90,
                      memberImage: 'assets/images/son.png',
                      onTap: () {},
                    ),
                  ),
                ] else if (familyMember == 3) ...[
                  Positioned(
                    top: -120,
                    left: 100,
                    child: FamilyMemberButton(
                      buttonSize: 0.36,
                      imageSize: 90,
                      memberImage: 'assets/images/son.png',
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: -40,
                    child: FamilyMemberButton(
                      buttonSize: 0.36,
                      imageSize: 90,
                      memberImage: 'assets/images/son.png',
                      onTap: () {},
                    ),
                  ),
                ] else if (familyMember == 2) ...[
                  Positioned(
                    top: -120,
                    left: -20,
                    child: FamilyMemberButton(
                      buttonSize: 0.4,
                      imageSize: 90,
                      memberImage: 'assets/images/son.png',
                      onTap: () {},
                    ),
                  ),
                ] else
                  ...[],

                //Me round
                Positioned(
                  top: 100,
                  left: 180,
                  child: FamilyMemberButton(
                    buttonSize: 0.4,
                    imageSize: 90,
                    memberImage: 'assets/images/son.png',
                    onTap: () {
                      myStateDialog(context);
                    },
                  ),
                ),

                ///Interaction button
                Positioned(
                  top: 100,
                  left: 230,
                  child: Draggable(
                      feedback: const InteractionButton(
                          interactionImage: 'assets/images/poke.png', size: 68),
                      childWhenDragging: Container(
                        color: AppColor.swatchColor,
                      ),
                      data: Interaction.heart,
                      child: const InteractionButton(
                          interactionImage: 'assets/images/poke.png',
                          size: 68)),
                ),
                Positioned(
                  top: 125,
                  left: 175,
                  child: Draggable(
                      feedback: const InteractionButton(
                          interactionImage: 'assets/images/heart.png',
                          size: 53),
                      childWhenDragging: Container(
                        color: AppColor.swatchColor,
                      ),
                      data: Interaction.heart,
                      child: const InteractionButton(
                          interactionImage: 'assets/images/heart.png',
                          size: 53)),
                ),
                Positioned(
                  top: 170,
                  left: 125,
                  child: Draggable(
                      feedback: const InteractionButton(
                          interactionImage: 'assets/images/thumbdown.png',
                          size: 55),
                      childWhenDragging: Container(
                        color: AppColor.swatchColor,
                      ),
                      data: Interaction.thumbDown,
                      child: const InteractionButton(
                          interactionImage: 'assets/images/thumbdown.png',
                          size: 55)),
                ),
                Positioned(
                  top: 235,
                  left: 115,
                  child: Draggable(
                      feedback: const InteractionButton(
                          interactionImage: 'assets/images/thumbup.png',
                          size: 55),
                      childWhenDragging: Container(
                        color: AppColor.swatchColor,
                      ),
                      data: Interaction.thumbUp,
                      child: const InteractionButton(
                          interactionImage: 'assets/images/thumbup.png',
                          size: 55)),
                ),

                ///SpeechBubble
                Positioned(
                  top: 310,
                  left: 190,
                  child: CustomPaint(
                    painter: SpeechBubble(color: AppColor.textColor),
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: const Text("I'm hungry.."),
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
