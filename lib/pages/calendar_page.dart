import 'package:fam_story_frontend/models/family_schedule_list_model.dart';
import 'package:fam_story_frontend/services/family_schedule_api_service.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:fam_story_frontend/models/family_schedule_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  // TODO: familyId 수정
  Future<List<FamilyScheduleModel>> scheduleList =
      FamilyScheduleApiService.getFamilyScheduleList(
          3, DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    super.initState();
  }

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
                      "Calendar",
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
                        showAddingScheduleDialog(context);
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                calendarContainer(),
                const SizedBox(height: 20),
                // event 표시
                FutureBuilder(
                    future: scheduleList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print("waiting");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        print("done");
                      }
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!
                              .map((e) => Text(e.scheduleName))
                              .toList(),
                          // children: [Text('${snapshot.data![0]}')],
                        );
                      } else {
                        return const Text("fail");
                      }
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> showAddingScheduleDialog(BuildContext context) {
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
              borderRadius: BorderRadius.circular(30),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentDate.toString().split(' ')[0],
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColor.swatchColor),
                      ),
                      const Text(
                        'Tell your schedule to family!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: AppColor.swatchColor)),
                        isDense: true,
                        hintText: "Title",
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.4)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // post
                            print(textController.text);
                            FamilyScheduleApiService.postFamilySchedule(
                                textController.text,
                                3,
                                _currentDate.year,
                                _currentDate.month,
                                _currentDate.day);
                            Navigator.of(context).pop();
                          },
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColor.swatchColor)),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColor.swatchColor.withOpacity(0.5))),
                          child: const Text(
                            "Cancel",
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

  Container calendarContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
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
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 330,
          height: 400,
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              setState(() {
                _currentDate = date;
                // scheduleList = ApiService.getFamilyScheduleList(
                //     3, _currentDate.year, _currentDate.month);
              });
            },
            weekendTextStyle: const TextStyle(
              color: AppColor.textColor,
            ),
            daysTextStyle: const TextStyle(color: AppColor.textColor),
            thisMonthDayBorderColor: Colors.grey,
            customDayBuilder: (
              /// you can provide your own build function to make custom day containers
              bool isSelectable,
              int index,
              bool isSelectedDay,
              bool isToday,
              bool isPrevMonthDay,
              TextStyle textStyle,
              bool isNextMonthDay,
              bool isThisMonthDay,
              DateTime day,
            ) {
              return null;
            },
            weekdayTextStyle: const TextStyle(color: AppColor.swatchColor),
            showWeekDays: true,
            showHeader: true,
            weekFormat: false,
            height: 400.0,
            todayButtonColor: AppColor.objectColor,
            todayTextStyle: const TextStyle(
                color: AppColor.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            selectedDateTime: _currentDate,
            selectedDayButtonColor: AppColor.swatchColor.withOpacity(0.6),
            selectedDayTextStyle:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // selectedDayBorderColor: Colors.red,
            // markedDateCustomTextStyle: const TextStyle(
            //     color: Colors.white, fontWeight: FontWeight.bold),
            // markedDatesMap: _markdeDateMap,
            markedDateShowIcon: true,
            markedDateIconMaxShown: 1,
            markedDateIconBuilder: (event) {
              return event.icon;
            },
            showIconBehindDayText: true,
            // daysHaveCircularBorder: true,
            onCalendarChanged: (DateTime date) {
              setState(() {
                _currentDate = date;
                // TODO: familyId 수정
                scheduleList = FamilyScheduleApiService.getFamilyScheduleList(
                    3, _currentDate.year, _currentDate.month);
              });
            },
            staticSixWeekFormat: true,
            headerTextStyle: const TextStyle(
                color: AppColor.swatchColor,
                fontSize: 23,
                fontWeight: FontWeight.bold),
            leftButtonIcon: const Icon(
              CupertinoIcons.left_chevron,
              color: AppColor.swatchColor,
            ),
            rightButtonIcon: const Icon(
              CupertinoIcons.right_chevron,
              color: AppColor.swatchColor,
            ),
          ),
        ),
      ),
    );
  }
}
