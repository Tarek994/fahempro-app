// import 'package:fahem/core/resources/colors_manager.dart';
// import 'package:fahem/core/resources/strings_manager.dart';
// import 'package:fahem/core/resources/values_manager.dart';
// import 'package:fahem/core/utilities/methods.dart';
// import 'package:fahem/data/models/booking_appointment_model.dart';
// import 'package:fahem/presentation/shared/widgets/account_row_widget.dart';
// import 'package:fahem/presentation/shared/widgets/date_widget.dart';
// import 'package:flutter/material.dart';
//
// class BookingAppointmentListItem extends StatelessWidget {
//   final BookingAppointmentModel bookingAppointmentModel;
//
//   const BookingAppointmentListItem({
//     super.key,
//     required this.bookingAppointmentModel,
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
//                 child: DateWidget(createdAt: bookingAppointmentModel.createdAt),
//               ),
//             ],
//           ),
//           const SizedBox(height: SizeManager.s10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(child: AccountRowWidget(account: bookingAppointmentModel.account)),
//             ],
//           ),
//           const SizedBox(height: SizeManager.s10),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Icon(Icons.calendar_today, size: SizeManager.s16),
//               const SizedBox(width: SizeManager.s5),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: SizeManager.s2),
//                   child: Text(
//                     '${Methods.getText(StringsManager.bookingTimeAndDate)}: ${Methods.formatDate(milliseconds: int.parse(bookingAppointmentModel.bookingDate))}',
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }