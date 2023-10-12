// import 'package:flutter/material.dart';
// import 'package:shopmate/services/cloud/cloud_lists.dart';

// //typedef used to define a callback function
// typedef ListCallback = void Function(CloudList list);

// class ListViewScreen extends StatelessWidget {
//   final Iterable<CloudList> lists;

//   final ListCallback onTap;

//   const ListViewScreen({super.key, required this.lists, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: lists.length,
//       itemBuilder: (context, index) {
//         final list = lists.elementAt(index); //for iterables
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.85,
//             height: MediaQuery.of(context).size.width * 0.3,
//             decoration: ShapeDecoration(
//               color: const Color(0xFFE4E4E4),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//             child: ListTile(
//               onTap: () {
//                 onTap(list);
//               },
//               title: Text(
//                 list.text,
//                 maxLines: 1,
//                 softWrap: true,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
