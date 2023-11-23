import 'package:fam_story_frontend/models/family_schedule_list_model.dart';
import 'package:fam_story_frontend/services/api_service.dart';
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
  final EventList<Event> _markedDateMap = EventList<Event>(events: {});
  late Future<List<FamilyScheduleModel>> scheduleList;

  @override
  void initState() {
    super.initState();
    _updateCalendar(DateTime.now());
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
                        _showAddingScheduleDialog(context);
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
                // 달력
                _calendarContainer(),
                const SizedBox(height: 20),
                // 해당일 일정 표시
                FutureBuilder(
                    future: scheduleList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<FamilyScheduleModel> todaySchedule = snapshot.data!
                            .where((e) => e.scheduleDay == _currentDate.day)
                            .toList();
                        int scheduleNum = todaySchedule.length;
                        if (scheduleNum == 0) {
                          // TODO: 일정 추가 유도 멘트
                          return const Text("");
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: scheduleNum,
                          itemBuilder: (context, idx) {
                            final schedule = todaySchedule[idx];
                            return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  setState(() {
                                    todaySchedule.removeWhere((item) =>
                                        item.scheduleId == schedule.scheduleId);
                                    snapshot.data!.removeWhere((item) =>
                                        item.scheduleId == schedule.scheduleId);
                                  });
                                  Future<bool> flag;
                                  try {
                                    flag = FamilyScheduleApiService
                                        .deleteFamilySchedule(
                                            schedule.scheduleId);
                                    flag.then((value) {
                                      if (value) {
                                        setState(() {
                                          _markedDateMap.remove(
                                              _currentDate,
                                              _markedDateMap
                                                  .getEvents(_currentDate)
                                                  .where((e) =>
                                                      e.id ==
                                                      schedule.scheduleId)
                                                  .first);
                                        });
                                      }
                                    });
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                        leading: Container(
                                          width: 5,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: AppColor.swatchColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        title: Text(
                                          todaySchedule[idx].scheduleName,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Container(
                                        color: AppColor.subColor,
                                        height: 1,
                                      ),
                                    )
                                  ],
                                ));
                          },
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _showAddingScheduleDialog(BuildContext context) {
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
                            Future<int> scheduleId;
                            try {
                              scheduleId =
                                  FamilyScheduleApiService.postFamilySchedule(
                                      textController.text,
                                      3,
                                      _currentDate.year,
                                      _currentDate.month,
                                      _currentDate.day);
                              scheduleId.then((value) {
                                setState(() {
                                  _updateCalendar(_currentDate);
                                });
                              });
                            } catch (e) {
                              print(e.toString());
                            }
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

  Container _calendarContainer() {
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
              });
              // _updateCalendar(date);
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
            markedDateCustomTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            markedDatesMap: _markedDateMap,
            markedDateShowIcon: true,
            markedDateIconMaxShown: 1,
            markedDateIconBuilder: (event) {
              return event.icon;
            },
            showIconBehindDayText: true,
            // daysHaveCircularBorder: true,
            onCalendarChanged: (DateTime date) {
              _updateCalendar(date);
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  _currentDate = date;
                });
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

  // 일정 새로 받아오고 그리기; 달 바뀔 때마다 호출
  void _updateCalendar(DateTime date) {
    setState(() {
      try {
        // TODO: familyId 변경
        scheduleList = FamilyScheduleApiService.getFamilyScheduleList(
            3, date.year, date.month);
        print("updateCalendar");
        scheduleList.then((value) {
          setState(() {
            _drawSchedule(value);
          });
        });
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void _drawSchedule(List<FamilyScheduleModel> list) {
    _markedDateMap.clear();
    print("drawSchedule");
    for (var schedule in list) {
      _markedDateMap.add(
          DateTime(schedule.scheduleYear, schedule.scheduleMonth,
              schedule.scheduleDay),
          Event(
              date: DateTime(schedule.scheduleYear, schedule.scheduleMonth,
                  schedule.scheduleDay),
              title: schedule.scheduleName,
              icon: (_iconWidget(
                schedule.scheduleDay.toString(),
              )),
              id: schedule.scheduleId));
    }
  }

  // icon builder
  static Widget _iconWidget(String day) {
    return Container(
      decoration: BoxDecoration(
        // color: AppColor.swatchColor,
        color: AppColor.subColor,
        borderRadius: BorderRadius.circular(100),
      ),
      // child: Center(
      //   child: Text(
      //     day,
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // ),
    );
  }
}
