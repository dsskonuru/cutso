// import 'package:auto_route/auto_route.dart';
// import 'package:cutso/core/error/failures.dart';
// import 'package:cutso/features/home/data/models/item_model.dart';
// import 'package:cutso/features/home/domain/entities/item.dart';
// import 'package:cutso/features/home/presentation/provider/items_provider.dart';
// import 'package:dartz/dartz.dart' as dz;
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';


// class ItemPage extends StatefulWidget {
//   final ItemModel? itemModel;

//   const ItemPage({@PathParam('item') this.itemModel, Key? key})
//       : super(key: key);

//   @override
//   _ItemPageState createState() => _ItemPageState();
// }

// class _ItemPageState extends State<ItemPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 IconButton(
//                   onPressed: () => AutoRouter.of(context).pop(),
//                   icon: Icon(Icons.arrow_back_rounded),
//                 ),
//                 Center(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 100,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         alignment: Alignment.center,
//                         child: Hero(
//                           tag: widget.itemModel!,
//                           child: SvgPicture.asset(
//                               'assets/vectors/${widget.category}.svg',
//                               semanticsLabel:
//                                   categories[widget.category]!["name"]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Divider(),
//             ItemListView(category: widget.category!),
//           ],
//         ),
//       ),
//     );
//   }
// }
