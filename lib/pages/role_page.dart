// String getRoleImage(int role) {
//   switch (role) {
//     case 1:
//       return 'assets/images/grandfather.png';
//     case 2:
//       return 'assets/images/dad.png';
//     case 3:
//       return 'assets/images/son.png';
//     case 4:
//       return 'assets/images/grandmother.png';
//     case 5:
//       return 'assets/images/mom.png';
//     case 6:
//       return 'assets/images/daughter.png';
//     default:
//       return 'assets/images/default.png';
//   }
// }

// Container(
//                     margin = const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
//                     padding = const EdgeInsets.all(16.0),
//                     decoration = BoxDecoration(
//                       color: AppColor.objectColor,
//                       borderRadius: BorderRadius.circular(15.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 20,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child = Column(
//                       children: [
//                         const Text(
//                           "What's your Role?",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.swatchColor,
//                           ),
//                         ),
//                         const SizedBox(height: 16.0),
//                         GridView.builder(
//                           shrinkWrap: true,
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 14.0,
//                             mainAxisSpacing: 14.0,
//                           ),
//                           itemCount: roles.length,
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 // 선택한 역할에 대한 로직 추가
//                                 setState(() {
//                                   selectedRole = roles[index];
//                                 });
//                                 print('Selected role: $selectedRole');
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   image: DecorationImage(
//                                     image: AssetImage(getRoleImage(roles[index])),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     if (selectedRole == roles[index])
//                                       Positioned(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: Colors.grey.withOpacity(0.6),
//                                           ),
//                                           child: const Icon(
//                                             Icons.check,
//                                             color: Colors.white,
//                                             size: 100,
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         if (selectedRole != null)
//                           Container(
//                             padding: const EdgeInsets.all(16.0),
//                             decoration: BoxDecoration(
//                               color: AppColor.objectColor,
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   roleDescriptions[selectedRole!] ?? '',
//                                   style: const TextStyle(
//                                     fontSize: 24,
//                                     color: AppColor.textColor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         const SizedBox(
//                           height: 12.0,
//                         ),
//                         ElevatedButton(
//                           onPressed: selectedRole != null
//                               ? () {
//                                   // 선택된 role이 있는 경우에만 실행할 로직
//                                 }
//                               : null, // selectedRole이 null이면 onPressed를 null로 설정하여 버튼 비활성화
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(35),
//                             ),
//                             backgroundColor: selectedRole != null ? AppColor.textColor : Colors.grey,
//                             minimumSize: const Size(120, 40), // selectedRole에 따라 배경색 조절
//                           ),
//                           child: const Text(
//                             'Create',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )