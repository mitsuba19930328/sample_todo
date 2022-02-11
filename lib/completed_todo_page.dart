// import 'package:flutter/material.dart';
//
// class CompletedTodoPage extends StatefulWidget {
//   @override
//   _CompletedTodoPageState createState() => _CompletedTodoPageState();
// }
//
// class _CompletedTodoPageState extends State<CompletedTodoPage> {
//   @override
//   final String title = "完了済みTODO";
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (int i=0; i<3; i++)
//                 Container(
//                   child: Card(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         const ListTile(
//                           leading: Icon(Icons.album),
//                           title: Text('The Enchanted Nightingale'),
//                           subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//         ),
//     );
//   }
// }