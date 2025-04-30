import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/category.dart';

class GroceryItem {
  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id, name;
  final int quantity;
  final Category category;
}

// class GroceryItem extends StatelessWidget {
//   const GroceryItem({
//     super.key,
//     required this.id,
//     required this.name,
//     required this.quantity,
//     required this.category,
//   });

//   final String id, name;
//   final int quantity;
//   final Category category;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       child: SizedBox(
//         child: Row(
//           children: [
//             Container(
//               margin: EdgeInsets.all(10),

//               height: 30, //
//               width: 30,

//               color: category.textColor,
//             ),

//             Text(
//               name,
//               style: TextStyle(
//                 //
//                 fontSize: 20,
//               ),
//             ),

//             const Spacer(),

//             Text('${quantity}'),
//             const SizedBox(width: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
