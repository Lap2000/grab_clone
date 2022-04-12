// Widget buildCalendar(String dob, BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 35.0),
//     child: Column(
//       children: <Widget>[
//         CustomText(
//           text: 'Date of birth',
//           fontsize: 20,
//           color: Colors.black,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CustomText(
//               text:"${dob}".split(' ')[0],
//             ),
//             IconButton(
//               icon: Icon(Icons.calendar_today_rounded),
//               color: Colors.black,
//               onPressed: () => _selectDate(context,true),
//             ),
//           ],
//         ),
//         Divider(thickness: 1,color: Colors.black38,),
//       ],
//     ),
//     //child: Text("Selected Date: $selectedDate"),
//   );
// }
