import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/booking_appointment_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/account_row_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';

class BookingAppointmentListItem extends StatelessWidget {
  final BookingAppointmentModel bookingAppointmentModel;
  final Function onEdit;
  final Function onDelete;

  const BookingAppointmentListItem({
    super.key,
    required this.bookingAppointmentModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DateWidget(createdAt: bookingAppointmentModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.editBookingAppointment) || Methods.checkAdminPermission(AdminPermissions.deleteBookingAppointment)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.editBookingAppointment)) PopupMenu.edit,
                    if(Methods.checkAdminPermission(AdminPermissions.deleteBookingAppointment)) PopupMenu.delete,
                  ],
                  onPressedEdit: () => Methods.routeTo(context, Routes.insertEditBookingAppointmentScreen, arguments: bookingAppointmentModel, then: (bookingAppointment) => onEdit(bookingAppointment)),
                  onPressedDelete: () {
                    Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
                      if(value) {
                        onDelete();
                      }
                    });
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: UserRowWidget(user: bookingAppointmentModel.user)),
              const SizedBox(width: SizeManager.s10),
              Expanded(child: AccountRowWidget(account: bookingAppointmentModel.account)),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.calendar_today, size: SizeManager.s16),
              const SizedBox(width: SizeManager.s5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: SizeManager.s2),
                  child: Text(
                    '${Methods.getText(StringsManager.bookingTimeAndDate)}: ${Methods.formatDate(milliseconds: int.parse(bookingAppointmentModel.bookingDate))}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}