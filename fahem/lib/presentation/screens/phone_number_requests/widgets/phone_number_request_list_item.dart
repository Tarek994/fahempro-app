// import 'package:fahem/core/resources/colors_manager.dart';
// import 'package:fahem/core/resources/values_manager.dart';
// import 'package:fahem/presentation/shared/widgets/account_row_widget.dart';
// import 'package:fahem/presentation/shared/widgets/date_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:fahem/data/models/phone_number_request_model.dart';
//
// class PhoneNumberRequestListItem extends StatelessWidget {
//   final PhoneNumberRequestModel phoneNumberRequestModel;
//
//   const PhoneNumberRequestListItem({
//     super.key,
//     required this.phoneNumberRequestModel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(SizeManager.s10),
//       decoration: BoxDecoration(
//         color: ColorsManager.white,
//         borderRadius: BorderRadius.circular(SizeManager.s10),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: DateWidget(createdAt: phoneNumberRequestModel.createdAt),
//               ),
//             ],
//           ),
//           const SizedBox(height: SizeManager.s10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(child: AccountRowWidget(account: phoneNumberRequestModel.account)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }