// TODO: 달 바뀔 때마다 일정 받아오기

import 'package:fam_story_frontend/models/family_schedule_list_model.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:fam_story_frontend/models/family_schedule_list_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  // FamilyScheduleListModel scheduleList =

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Column(
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
                      "Calendar",
                      style: TextStyle(
                          fontFamily: 'AppleSDGothicNeo',
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                          fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                          setState(() => _currentDate = date);
                          // dateChanged = true;
                        },
                        weekendTextStyle: const TextStyle(
                          color: AppColor.textColor,
                        ),
                        daysTextStyle:
                            const TextStyle(color: AppColor.textColor),
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
                        weekdayTextStyle:
                            const TextStyle(color: AppColor.swatchColor),
                        showWeekDays: true,
                        showHeader: true,
                        weekFormat: false,
                        height: 400.0,
                        todayButtonColor: AppColor.swatchColor.withOpacity(0.5),
                        todayTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        selectedDateTime: _currentDate,
                        selectedDayButtonColor: AppColor.swatchColor,
                        selectedDayTextStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                ),
                // event 표시
                // FutureBuilder(future: future, builder: builder)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
