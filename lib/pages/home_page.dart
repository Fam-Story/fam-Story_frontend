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
        Interaction.thumbUp: 4,
        Interaction.thumbDown: 3,
        Interaction.heart: 2,
        Interaction.poke: 1,
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
  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;

  List<FamilyMemberModel> familyMembers = [
    // Add more members as needed
  ];

  @override
  void initState() {
    super.initState();
    _initData().then((_) {});
    setState(() {
      context.read<IdProvider>().nickname;
    });
  }

  Future<void> _initData() async {
    familyId = context.read<IdProvider>().familyId;
    familyMemberID = context.read<IdProvider>().familyMemberId;
    _allFamilyMember = FamilyMemberApiService.getAllFamilyMember(familyId);
    _allFamilyMember.then((value) {
      setState(() {
        familyMembers = value;
        familyMembers
            .removeWhere((element) => element.familyMemberId == familyMemberID);
        familyMemberNum = familyMembers.length;
        _textEditingController.text = context.read<IdProvider>().introMessage;
      });
    });
  }

  void interaction(Interaction data, int num) {
    FamilyInteractionApiService.postFamilyInteraction(
        familyMemberID, familyMembers[num].familyMemberId, data.title);
    switch (data.title) {
      case 4:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Center(
                child: Text(
                  'You like \"${familyMembers[num].nickname}\"',
                  style: TextStyle(
                      fontFamily: 'AppleSDGothicNeo',
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                      fontSize: 20),
                ),
              ),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Center(
                child: Text(
                  'You unlike \"${familyMembers[num].nickname}\"',
                  style: TextStyle(
                      fontFamily: 'AppleSDGothicNeo',
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                      fontSize: 20),
                ),
              ),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Center(
                child: Text(
                  'You love \"${familyMembers[num].nickname}\"',
                  style: TextStyle(
                      fontFamily: 'AppleSDGothicNeo',
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                      fontSize: 20),
                ),
              ),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
        break;
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Center(
                child: Text(
                  'You poke \"${familyMembers[num].nickname}\"',
                  style: TextStyle(
                      fontFamily: 'AppleSDGothicNeo',
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                      fontSize: 20),
                ),
              ),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('NO'),
          duration: const Duration(seconds: 1),
        ));
        break;
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 50.0,
          backgroundColor: AppColor.backgroudColor,
          title: Center(
            child: Text(
              'Enter My State !',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColor.textColor,
              ),
            ),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: newController,
              maxLength: 12,
              style: TextStyle(
                color: AppColor.swatchColor,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your state!',
                hintStyle: TextStyle(
                  color: AppColor.swatchColor,
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
              ),
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
                    Navigator.pop(context);
                  });
                } catch (e) {
                  print('Error during API call: $e');
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColor.textColor, // 버튼 텍스트 색상 추가
              ),
              child: const Text('OK', style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColor.textColor, // 버튼 텍스트 색상 추가
              ),
              child: const Text('Back', style: TextStyle(fontSize: 18)),
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
    return Scaffold(
      backgroundColor: AppColor.backgroudColor,
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          context.read<IdProvider>().familyName,
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
                          color:
                              Colors.brown[200]!, // Adjust the color as needed
                          width: 5, // Adjust the width as needed
                        ),
                      ),
                    ),

                    //familyId ->
                    // 3번 리스트
                    Visibility(
                      visible: familyMemberNum >= 4,
                      child: Positioned(
                        top: -60,
                        left: 170,
                        child: Column(
                          children: [
                            DragTarget<Interaction>(
                              builder: (context, candidateData, rejectedData) {
                                return FamilyMemberButton(
                                    buttonSize: 110,
                                    imageSize: 50,
                                    memberImage:
                                        getRoleImage(familyMembers[3].role),
                                    onTap: () {
                                      setState(() {
                                        click4 = !click4;
                                      });
                                    },
                                    name: familyMembers[3].nickname);
                              },
                              onAccept: (data) {
                                interaction(data, 3);
                              },
                            ),
                            if (click4 &&
                                familyMembers.isNotEmpty &&
                                familyMemberNum >= 4 &&
                                familyMembers[3].introMessage != null &&
                                familyMembers[3].introMessage.isNotEmpty)
                              CustomPaint(
                                painter:
                                    SpeechBubble(color: AppColor.textColor),
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(30),
                                    child: Text(
                                      familyMembers[3].introMessage,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.objectColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    // 2번 리스트
                    Visibility(
                      visible: familyMemberNum >= 3,
                      child: Positioned(
                        top: 210,
                        left: -35,
                        child: Column(
                          children: [
                            DragTarget<Interaction>(
                              builder: (context, candidateData, rejectedData) {
                                return FamilyMemberButton(
                                    buttonSize: 110,
                                    imageSize: 50,
                                    memberImage:
                                        getRoleImage(familyMembers[2].role),
                                    onTap: () {
                                      setState(() {
                                        click3 = !click3;
                                      });
                                    },
                                    name: familyMembers[2].nickname);
                              },
                              onAccept: (data) {
                                interaction(data, 2);
                              },
                            ),
                            if (click3 &&
                                familyMembers.isNotEmpty &&
                                familyMemberNum >= 3 &&
                                familyMembers[2].introMessage != null &&
                                familyMembers[2].introMessage.isNotEmpty)
                              CustomPaint(
                                painter:
                                    SpeechBubble(color: AppColor.textColor),
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(30),
                                    child: Text(
                                      familyMembers[2].introMessage,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.objectColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    // 1번 리스트
                    Visibility(
                      visible: familyMemberNum >= 2,
                      child: Positioned(
                        top: 60,
                        left: -35,
                        child: Column(
                          children: [
                            DragTarget<Interaction>(
                              builder: (context, candidateData, rejectedData) {
                                return FamilyMemberButton(
                                    buttonSize: 110,
                                    imageSize: 50,
                                    memberImage:
                                        getRoleImage(familyMembers[1].role),
                                    onTap: () {
                                      setState(() {
                                        click2 = !click2;
                                      });
                                    },
                                    name: familyMembers[1].nickname);
                              },
                              onAccept: (data) {
                                interaction(data, 1);
                              },
                            ),
                            if (click2 &&
                                familyMembers.isNotEmpty &&
                                familyMemberNum >= 2 &&
                                familyMembers[1].introMessage != null &&
                                familyMembers[1].introMessage.isNotEmpty)
                              CustomPaint(
                                painter:
                                    SpeechBubble(color: AppColor.textColor),
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(30),
                                    child: Text(
                                      familyMembers[1].introMessage,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.objectColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    // 0번 리스트
                    Visibility(
                      visible: familyMemberNum >= 1,
                      child: Positioned(
                        top: -60,
                        left: 40,
                        child: Column(
                          children: [
                            DragTarget<Interaction>(
                              builder: (context, candidateData, rejectedData) {
                                return FamilyMemberButton(
                                    buttonSize: 110,
                                    imageSize: 50,
                                    memberImage:
                                        getRoleImage(familyMembers[0].role),
                                    onTap: () {
                                      setState(() {
                                        click1 = !click1;
                                      });
                                    },
                                    name: familyMembers[0].nickname);
                              },
                              onAccept: (data) {
                                interaction(data, 0);
                              },
                            ),
                            if (click1 &&
                                familyMembers.isNotEmpty &&
                                familyMemberNum >= 1 &&
                                familyMembers[0].introMessage != null &&
                                familyMembers[0].introMessage.isNotEmpty)
                              CustomPaint(
                                painter:
                                    SpeechBubble(color: AppColor.textColor),
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(30),
                                    child: Text(
                                      familyMembers[0].introMessage,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColor.objectColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),

                    ///나
                    Positioned(
                      top: 180,
                      left: 180,
                      child: Column(
                        children: [
                          FamilyMemberButton(
                              buttonSize: 155,
                              imageSize: 90,
                              memberImage:
                                  getRoleImage(context.read<IdProvider>().role),
                              onTap: () {
                                myStateDialog(context);
                              },
                              name: context.read<IdProvider>().nickname),

                          ///SpeechBubble
                          Visibility(
                              visible:
                                  context.read<IdProvider>().introMessage != '',
                              child: CustomPaint(
                                  painter:
                                      SpeechBubble(color: AppColor.textColor),
                                  child: Center(
                                    child: Container(
                                      margin: const EdgeInsets.all(30),
                                      child: Text(
                                        context.read<IdProvider>().introMessage,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColor.objectColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ))),
                        ],
                      ),
                    ),

                    ///Interaction button
                    Positioned(
                      top: 100,
                      left: 230,
                      child: Draggable(
                          feedback: const InteractionButton(
                              interactionImage: 'assets/images/poke.png',
                              size: 68),
                          childWhenDragging: Container(
                            color: AppColor.swatchColor,
                          ),
                          data: Interaction.poke,
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
                  ],
                ),
              ],
            ),
          ),
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
  final String name;

  const FamilyMemberButton(
      {super.key,
      required this.buttonSize,
      required this.imageSize,
      required this.memberImage,
      required this.onTap,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        splashColor: AppColor.subColor.withOpacity(0.3),
        onTap: onTap,
        child: Ink(
          width: buttonSize,
          height: buttonSize,
          decoration: const BoxDecoration(
            color: AppColor.objectColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                memberImage,
                fit: BoxFit.fill,
                width: imageSize, // 원하는 너비로 조절
                height: imageSize, // 원하는 높이로 조절
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: TextStyle(
                    fontFamily: 'AppleSDGothicNeo',
                    fontWeight: FontWeight.bold,
                    color: AppColor.swatchColor,
                    fontSize: 12),
              ),
            ],
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

  final _radius = 15.0;
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
        ..style = PaintingStyle.fill,
    );
    var path = Path();
    path.moveTo(size.width / 2, 1);
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
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
