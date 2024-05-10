import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/screens/booking_appointments/controllers/insert_edit_booking_appointment_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/booking_appointment_model.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/edit_booking_appointment_usecase.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/insert_booking_appointment_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';

class InsertEditBookingAppointmentScreen extends StatefulWidget {
  final BookingAppointmentModel? bookingAppointmentModel;

  const InsertEditBookingAppointmentScreen({
    super.key,
    this.bookingAppointmentModel,
  });

  @override
  State<InsertEditBookingAppointmentScreen> createState() => _InsertEditBookingAppointmentScreenState();
}

class _InsertEditBookingAppointmentScreenState extends State<InsertEditBookingAppointmentScreen> {
  late InsertEditBookingAppointmentProvider insertEditBookingAppointmentProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    insertEditBookingAppointmentProvider = Provider.of<InsertEditBookingAppointmentProvider>(context, listen: false);

    if(widget.bookingAppointmentModel != null) {
      DateTime bookingDate = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.bookingAppointmentModel!.bookingDate));
      insertEditBookingAppointmentProvider.setAccount(widget.bookingAppointmentModel!.account);
      insertEditBookingAppointmentProvider.setUser(widget.bookingAppointmentModel!.user);
      insertEditBookingAppointmentProvider.setDate(bookingDate);
      insertEditBookingAppointmentProvider.setTime(TimeOfDay(hour: bookingDate.hour, minute: bookingDate.minute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditBookingAppointmentProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar (
                  title: widget.bookingAppointmentModel == null ? StringsManager.addBookingAppointment : StringsManager.editBookingAppointment,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Account *
                          CustomButton(
                            onPressed: () {
                              Dialogs.accountsBottomSheet(context: context).then((account) {
                                if(account != null) {
                                  insertEditBookingAppointmentProvider.changeAccount(account);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.account == null ? Methods.getText(StringsManager.chooseAccount).toCapitalized() : provider.account!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.account == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.account == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // User *
                          CustomButton(
                            onPressed: () {
                              Dialogs.usersBottomSheet(context: context).then((user) {
                                if(user != null) {
                                  insertEditBookingAppointmentProvider.changeUser(user);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.user == null ? Methods.getText(StringsManager.chooseUser).toCapitalized() : provider.user!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.account == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.account == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // bookingDate
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CustomButton(
                                      buttonType: ButtonType.preIconPostClickableIcon,
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        provider.onPressedDate(context);
                                      },
                                      text: provider.date == null
                                          ? '${Methods.getText(StringsManager.date).toCapitalized()} *'
                                          : Methods.formatDate(milliseconds: provider.date!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                                      iconData: FontAwesomeIcons.calendar,
                                      postClickableIconData: provider.date == null ? null : Icons.clear,
                                      onPressedPostClickableIcon: provider.date == null ? null : () {
                                        FocusScope.of(context).unfocus();
                                        provider.changeDate(null);
                                      },
                                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                      width: double.infinity,
                                      buttonColor: ColorsManager.white,
                                      borderColor: ColorsManager.grey300,
                                      iconColor: ColorsManager.grey,
                                      textColor: provider.date == null ? ColorsManager.grey : ColorsManager.black,
                                      fontSize: SizeManager.s12,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      isRequired: provider.isButtonClicked && provider.date == null,
                                    ),
                                    if(provider.date != null) PositionedDirectional(
                                      start: 36,
                                      top: -5,
                                      child: Text(
                                        '${Methods.getText(StringsManager.date).toCapitalized()} *',
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: SizeManager.s10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        CustomButton(
                                          buttonType: ButtonType.preIconPostClickableIcon,
                                          onPressed: () async {
                                            FocusScope.of(context).unfocus();
                                            provider.onPressedTime(context);
                                          },
                                          text: provider.time == null
                                              ? '${Methods.getText(StringsManager.time).toCapitalized()} *'
                                              : MyProviders.appProvider.isEnglish
                                              ? provider.time!.format(context)
                                              : provider.time!.format(context).contains(RegExp(r'AM'))
                                              ? provider.time!.format(context).replaceFirst(RegExp(r'AM'), 'صباحا')
                                              : provider.time!.format(context).replaceFirst(RegExp(r'PM'), 'مساءا'),
                                          iconData: FontAwesomeIcons.clock,
                                          postClickableIconData: provider.time == null ? null : Icons.clear,
                                          onPressedPostClickableIcon: provider.time == null ? null : () {
                                            FocusScope.of(context).unfocus();
                                            provider.changeTime(null);
                                          },
                                          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                          width: double.infinity,
                                          buttonColor: ColorsManager.white,
                                          borderColor: provider.isButtonClicked && provider.time == null ? ColorsManager.red700 : ColorsManager.grey300,
                                          iconColor: ColorsManager.grey,
                                          textColor: provider.time == null ? ColorsManager.grey : ColorsManager.black,
                                          fontSize: SizeManager.s12,
                                        ),
                                        if(provider.time != null) PositionedDirectional(
                                          start: 36,
                                          top: -5,
                                          child: Text(
                                            '${Methods.getText(StringsManager.time).toCapitalized()} *',
                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if(provider.isButtonClicked && provider.time == null) Padding(
                                      padding: const EdgeInsets.all(SizeManager.s8),
                                      child: Text(
                                        Methods.getText(StringsManager.required).toCapitalized(),
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditBookingAppointmentProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.bookingAppointmentModel == null) {
                                  InsertBookingAppointmentParameters insertBookingAppointmentParameters = InsertBookingAppointmentParameters(
                                    accountId: provider.account!.accountId,
                                    userId: provider.user!.userId,
                                    bookingDate: DateTime(provider.date!.year, provider.date!.month, provider.date!.day, provider.time!.hour, provider.time!.minute).millisecondsSinceEpoch.toString(),
                                    isViewed: false,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditBookingAppointmentProvider.insertBookingAppointment(context: context, insertBookingAppointmentParameters: insertBookingAppointmentParameters);
                                }
                                else {
                                  EditBookingAppointmentParameters editBookingAppointmentParameters = EditBookingAppointmentParameters(
                                    bookingAppointmentId: widget.bookingAppointmentModel!.bookingAppointmentId,
                                    accountId: provider.account!.accountId,
                                    userId: provider.user!.userId,
                                    bookingDate: DateTime(provider.date!.year, provider.date!.month, provider.date!.day, provider.time!.hour, provider.time!.minute).millisecondsSinceEpoch.toString(),
                                    isViewed: widget.bookingAppointmentModel!.isViewed,
                                  );
                                  insertEditBookingAppointmentProvider.editBookingAppointment(context: context, editBookingAppointmentParameters: editBookingAppointmentParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.bookingAppointmentModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.bookingAppointmentModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}