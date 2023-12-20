// import 'package:flutter/material.dart';
// import 'package:grocery/presentation/res/colors.dart';
// import 'package:grocery/presentation/res/images.dart';
// import 'package:grocery/presentation/res/style.dart';
// import 'package:grocery/presentation/screens/bottom_navigation_bar.dart/bottom_navigation_bar_screen.dart';
// import 'package:grocery/presentation/widgets/custom_button.dart';

// class SuccessfulCheckOutScreen extends StatelessWidget {
//   final String name;
//   const SuccessfulCheckOutScreen({
//     super.key,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: size.height * 0.3),
//               Stack(
//                 alignment: Alignment.center,
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     bottom: -5,
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: const Center(
//                         child: Icon(
//                           Icons.check,
//                           size: 35,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Image.asset(
//                     AppAssets.star,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               Text(
//                 '$name, your order\nhas been successful 🎉',
//                 textAlign: TextAlign.center,
//                 style: AppStyles.bold.copyWith(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   text: 'Check your order status in ',
//                   style: AppStyles.regular.copyWith(
//                     color: Colors.white,
//                     fontSize: 14,
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 'My Order\n',
//                       style: AppStyles.bold.copyWith(color: Colors.white),
//                     ),
//                     const TextSpan(
//                       text: 'about next steps information.',
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           _bottom(size, context),
//         ],
//       ),
//     );
//   }

//   Widget _bottom(Size size, BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
//         height: size.height * 0.3,
//         width: size.width,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             topRight: Radius.circular(30.0),
//           ),
//           color: Colors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Preparing your order',
//               style: AppStyles.bold.copyWith(
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Your order will be prepared and will come soon',
//               style: AppStyles.medium.copyWith(
//                 fontSize: 15,
//               ),
//             ),
//             const Spacer(),
//             CustomButton(
//               margin: 0,
//               content: 'Track My Order',
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) => const BottomNavigationBarScreen(index: 2),
//                   ),
//                 );
//               },
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
