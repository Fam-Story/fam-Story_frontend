import 'package:fam_story_frontend/pages/alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../di/provider/id_provider.dart';
import '../models/family_member_model.dart';

import '../root_page.dart';
import '../services/family_member_api_service.dart';
import 'setting_page.dart';
import 'package:fam_story_frontend/models/family_model.dart';
import 'package:fam_story_frontend/models/user_model.dart';
import 'package:fam_story_frontend/models/family_interaction_model.dart';
import 'package:fam_story_frontend/services/family_interaction_api_service.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';

enum Interaction {
  thumbUp,
  thumbDown,
  heart,
  poke;

  int get title => const <Interaction, int>{
        Interaction.thumbUp: 1,
        Interaction.thumbDown: 2,
        Interaction.heart: 3,
        Interaction.poke: 4,
      }[this]!;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _textEditingController = TextEditingController();
  String myState = '';
  late Future<List<FamilyMemberModel>> _allFamilyMember;
  int familyId = 0;
  int familyMemberID = 0;
  int familyMemberNum = 0;
  String? message;

  List<FamilyMemberModel> familyMembers = [
    // Add more members as needed
  ];

  @override
  void initState() {
    super.initState();
    _initData();
    setState(() {
      _textEditingController.text = context.read<IdProvider>().introMessage;
    });
  }

  Future<void> _initData() async {
    familyId = context.read<IdProvider>().familyId;
    familyMemberID = context.read<IdProvider>().familyMemberId;

    message = context.read<IdProvider>().introMessage;
    _allFamilyMember = FamilyMemberApiService.getAllFamilyMember(familyId);
    _allFamilyMember.then((value) {
      setState(() {
        familyMembers = value;
        familyMembers
            .removeWhere((element) => element.familyMemberId == familyMemberID);
        familyMemberNum = familyMembers.length;
      });
    });
  }

  Future<void> interaction(Interaction data, int familyMemberIDNum) async {
    await FamilyInteractionApiService.postFamilyInteraction(
        familyMemberID, familyMemberIDNum, data.title);
    switch (data.title) {
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('thumb up'),
        ));
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('thumb down'),
        ));
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('heart'),
        ));
      case 4:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('poke'),
        ));
      default:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('NO'),
        ));
    }
  }

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

  void myStateDialog(BuildContext context) async {
    TextEditingController newController =
        TextEditingController(text: _textEditingController.text);

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
              controller: newController,
              maxLength: 11,
              decoration: const InputDecoration(
                  labelText: 'Enter your state!',
                  focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColor.objectColor,
                    width: 2,
                  ))),
              onSaved: (value) {
                setState(() {
                  newController.text = value!;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await FamilyMemberApiService.putFamilyMember(
                    familyMemberID,
                    context.read<IdProvider>().role,
                    newController.text,
                  ).then((value) {
                    context
                        .read<IdProvider>()
                        .setIntroMessage(newController.text);
                    _formKey.currentState!.save();
                    //TODO: 다른 방안?
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RootPage(),
                      ),
                    );
                  });
                } catch (e) {
                  print('Error during API call: $e');
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
    setState(() {
      _textEditingController = newController;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(familyId);
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AlarmPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.alarm_on),
                        color: AppColor.swatchColor,
                        iconSize: 35),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingPage()),
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
                  decoration: BoxDecoration(
                    color: AppColor.swatchColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.brown[200]!, // Adjust the color as needed
                      width: 5, // Adjust the width as needed
                    ),
                  ),
                ),

                //familyId ->
                // 0번 리스트
                Visibility(
                  visible: familyMemberNum >= 1,
                  child: Positioned(
                    top: -120,
                    left: 30,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: getRoleImage(familyMembers[0].role),
                          onTap: () async {},
                        );
                      },
                      onAccept: (data) {
                        interaction(data, familyMembers[0].familyMemberId);
                      },
                    ),
                  ),
                ),
                // 1번 리스트
                Visibility(
                  visible: familyMemberNum >= 2,
                  child: Positioned(
                    top: 10,
                    left: -40,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: getRoleImage(familyMembers[1].role),
                          onTap: () async {},
                        );
                      },
                      onAccept: (data) async {
                        interaction(data, familyMembers[1].familyMemberId);
                      },
                    ),
                  ),
                ),
                // 2번 리스트
                Visibility(
                  visible: familyMemberNum >= 3,
                  child: Positioned(
                    top: -120,
                    left: 170,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: getRoleImage(familyMembers[2].role),
                          onTap: () async {},
                        );
                      },
                      onAccept: (data) {
                        interaction(data, familyMembers[2].familyMemberId);
                      },
                    ),
                  ),
                ),
                // 3번 리스트
                Visibility(
                  visible: familyMemberNum >= 4,
                  child: Positioned(
                    top: 150,
                    left: -40,
                    child: DragTarget<Interaction>(
                      builder: (context, candidateData, rejectedData) {
                        return FamilyMemberButton(
                          buttonSize: 0.28,
                          imageSize: 50,
                          memberImage: getRoleImage(familyMembers[3].role),
                          onTap: () async {},
                        );
                      },
                      onAccept: (data) {
                        interaction(data, familyMembers[3].familyMemberId);
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 100,
                  left: 180,
                  child: FamilyMemberButton(
                    buttonSize: 0.4,
                    imageSize: 90,
                    memberImage: getRoleImage(context.read<IdProvider>().role),
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
                  child: message != null
                      ? Center(
                          child: CustomPaint(
                            painter: SpeechBubble(color: AppColor.textColor),
                            child: Container(
                              margin: const EdgeInsets.all(30),
                              child: Text(message!),
                            ),
                          ),
                        )
                      : Container(), // message가 null일 때는 빈 Container 반환
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
    path.moveTo(size.width / 1.5, .0);
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
