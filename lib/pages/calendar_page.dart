// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';


// class CalendarPage extends StatefulWidget {
//   const CalendarPage({super.key});

//   @override
//   State<CalendarPage> createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Row(
//                   children: [
//                     SizedBox(
//                       width: 30,
//                     ),
//                     Text(
//                       "돌아보아요",
//                       style: TextStyle(fontFamily: 'AppleSDGothicNeo', fontWeight: FontWeight.w500, fontSize: 35),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.grey.shade400.withOpacity(0.8)),
//                       width: 120,
//                       height: 50,
//                       child: Center(
//                           child: Text(
//                         "🎨X$consecutive_dates",
//                         style: const TextStyle(fontSize: 25),
//                       )),
//                     ),
//                     const SizedBox(width: 30),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400.withOpacity(0.8)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: SizedBox(
//                       width: 330,
//                       height: 400,
//                       child: CalendarCarousel<Event>(
//                         onDayPressed: (DateTime date, List<Event> events) {
//                           setState(() => _currentDate = date);
//                           // dateChanged = true;
//                         },
//                         weekendTextStyle: const TextStyle(
//                           color: Colors.white,
//                         ),
//                         daysTextStyle: const TextStyle(color: Colors.white),
//                         thisMonthDayBorderColor: Colors.grey,
//                         customDayBuilder: (
//                           /// you can provide your own build function to make custom day containers
//                           bool isSelectable,
//                           int index,
//                           bool isSelectedDay,
//                           bool isToday,
//                           bool isPrevMonthDay,
//                           TextStyle textStyle,
//                           bool isNextMonthDay,
//                           bool isThisMonthDay,
//                           DateTime day,
//                         ) {
//                           return null;
//                         },
//                         showWeekDays: true,
//                         showHeader: true,
//                         weekFormat: false,
//                         height: 400.0,
//                         todayButtonColor: Colors.grey.shade400.withOpacity(0.8),
//                         todayTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                         selectedDateTime: _currentDate,
//                         selectedDayButtonColor: Colors.grey.shade500,
//                         selectedDayTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         // selectedDayBorderColor: Colors.red,
//                         // markedDateCustomTextStyle: const TextStyle(
//                         //     color: Colors.white, fontWeight: FontWeight.bold),
//                         markedDatesMap: _markdeDateMap,
//                         markedDateShowIcon: true,
//                         markedDateIconMaxShown: 1,
//                         markedDateIconBuilder: (event) {
//                           return event.icon;
//                         },
//                         showIconBehindDayText: true,
//                         // daysHaveCircularBorder: true,
//                         onCalendarChanged: (DateTime date) {
//                           setState(() {
//                             _currentDate = date;
//                           });
//                         },
//                         staticSixWeekFormat: true,
//                         headerText: DateFormat('yyy년 MM월').format(_currentDate).toString(),
//                         headerTextStyle: const TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
//                         leftButtonIcon: const Icon(CupertinoIcons.left_chevron),
//                         rightButtonIcon: const Icon(CupertinoIcons.right_chevron),
//                         customWeekDayBuilder: (weekday, weekdayName) {
//                           final koreanDaysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
//                           return Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(
//                               koreanDaysOfWeek[weekday],
//                               style: const TextStyle(
//                                 color: Colors.black,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 // event 표시
//               ],
//             ),
//           ),
//         ),
//       ],
//     );

//   }
// }