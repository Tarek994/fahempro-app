import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/presentation/screens/send_notification/controllers/send_notification_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/required_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/notification_model.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/insert_notification_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';

class SendNotificationScreen extends StatefulWidget {
  final NotificationModel? notificationModel;

  const SendNotificationScreen({
    super.key,
    this.notificationModel,
  });

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  late SendNotificationProvider sendNotificationProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerTitle = TextEditingController();
  final TextEditingController _textEditingControllerBody = TextEditingController();
  NotificationToApp? _notificationToApp;
  NotificationTo? _notificationTo;

  bool _isAllDataValid() {
    if(_notificationToApp == NotificationToApp.fahem && _notificationTo == NotificationTo.one && sendNotificationProvider.selectedUser == null) {
      return false;
    }
    if(_notificationToApp == NotificationToApp.fahemBusiness && _notificationTo == NotificationTo.one && sendNotificationProvider.selectedAccount == null) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    sendNotificationProvider = Provider.of<SendNotificationProvider>(context, listen: false);

    if(widget.notificationModel != null) {
      _textEditingControllerTitle.text = widget.notificationModel!.title;
      _textEditingControllerBody.text = widget.notificationModel!.body;
      _notificationToApp = widget.notificationModel!.notificationToApp;
      _notificationTo = widget.notificationModel!.notificationTo;
      sendNotificationProvider.setSelectedUser(widget.notificationModel!.user);
      sendNotificationProvider.setSelectedAccount(widget.notificationModel!.account);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SendNotificationProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.sendNotification),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Title *
                          CustomTextFormField(
                            controller: _textEditingControllerTitle,
                            labelText: '${Methods.getText(StringsManager.title).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.bell,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Body *
                          CustomTextFormField(
                            controller: _textEditingControllerBody,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.body).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Notification To App *
                          CustomDropdownButtonFormField(
                            currentValue: _notificationToApp,
                            valuesText: List.generate(NotificationToApp.values.length, (index) => NotificationToApp.toText(NotificationToApp.values[index])),
                            valuesObject: NotificationToApp.values,
                            onChanged: (value) {
                              _notificationToApp = value as NotificationToApp;
                              provider.setSelectedUser(null);
                              provider.setSelectedAccount(null);
                              setState(() {});
                            },
                            labelText: '${Methods.getText(StringsManager.chooseApp).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.mobileScreen,
                            suffixIcon: _notificationToApp == null ? const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ) : Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() => _notificationToApp = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: Validator.validateEmptyDropdown,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Notification To *
                          CustomDropdownButtonFormField(
                            currentValue: _notificationTo,
                            valuesText: List.generate(NotificationTo.values.length, (index) => NotificationTo.toText(NotificationTo.values[index])),
                            valuesObject: NotificationTo.values,
                            onChanged: (value) {
                              _notificationTo = value as NotificationTo;
                              provider.setSelectedUser(null);
                              provider.setSelectedAccount(null);
                              setState(() {});
                            },
                            labelText: '${Methods.getText(StringsManager.sendNotificationTo).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.solidUser,
                            suffixIcon: _notificationTo == null ? const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ) : Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() => _notificationTo = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: Validator.validateEmptyDropdown,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // User
                          if(_notificationToApp == NotificationToApp.fahem && _notificationTo == NotificationTo.one) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    await Dialogs.usersBottomSheet(context: context).then((value) {
                                      if(value != null) {
                                        sendNotificationProvider.changeSelectedUser(value);
                                      }
                                    });
                                  },
                                  buttonType: sendNotificationProvider.selectedUser == null ? ButtonType.text : ButtonType.prePersonalImageNetworkPostSpacer,
                                  text: sendNotificationProvider.selectedUser == null
                                      ? Methods.getText(StringsManager.chooseUser).toTitleCase()
                                      : sendNotificationProvider.selectedUser!.fullName,
                                  imageName: sendNotificationProvider.selectedUser?.personalImage,
                                  imageDirectory: ApiConstants.usersDirectory,
                                  defaultImage: ImagesManager.defaultAvatar,
                                  imageSize: SizeManager.s30,
                                  buttonColor: ColorsManager.white,
                                  borderColor: ColorsManager.grey100,
                                  textColor: ColorsManager.black,
                                  width: double.infinity,
                                ),
                                if(sendNotificationProvider.isButtonClicked && sendNotificationProvider.selectedUser == null) const RequiredTextWidget(),
                              ],
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          // Account
                          if(_notificationToApp == NotificationToApp.fahemBusiness && _notificationTo == NotificationTo.one) ...[
                            CustomButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                await Dialogs.accountsBottomSheet(context: context).then((value) {
                                  if(value != null) {
                                    sendNotificationProvider.changeSelectedAccount(value);
                                  }
                                });
                              },
                              buttonType: sendNotificationProvider.selectedAccount == null ? ButtonType.text : ButtonType.prePersonalImageNetworkPostSpacer,
                              text: sendNotificationProvider.selectedAccount == null
                                  ? Methods.getText(StringsManager.chooseAccount).toTitleCase()
                                  : sendNotificationProvider.selectedAccount!.fullName,
                              imageName: sendNotificationProvider.selectedAccount?.personalImage,
                              imageDirectory: ApiConstants.accountsDirectory,
                              defaultImage: ImagesManager.defaultAvatar,
                              imageSize: SizeManager.s30,
                              buttonColor: ColorsManager.white,
                              borderColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            ),
                            if(sendNotificationProvider.isButtonClicked && sendNotificationProvider.selectedAccount == null) const RequiredTextWidget(),
                          ],

                          const SizedBox(height: SizeManager.s20),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              sendNotificationProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && _isAllDataValid()) {
                                Dialogs.showBottomSheetConfirmation(
                                  context: context,
                                  message: Methods.getText(StringsManager.areYouSureToSendTheNotification).toCapitalized(),
                                ).then((value) {
                                  if(value) {
                                    InsertNotificationParameters insertNotificationParameters = InsertNotificationParameters(
                                      userId: sendNotificationProvider.selectedUser?.userId,
                                      accountId: sendNotificationProvider.selectedAccount?.accountId,
                                      notificationToApp: _notificationToApp!,
                                      notificationTo: _notificationTo!,
                                      title: _textEditingControllerTitle.text.trim(),
                                      body: _textEditingControllerBody.text.trim(),
                                      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                    );
                                    sendNotificationProvider.insertNotification(
                                      context: context,
                                      insertNotificationParameters: insertNotificationParameters,
                                    );
                                  }
                                });
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: FontAwesomeIcons.paperPlane,
                            text: Methods.getText(StringsManager.send).toTitleCase(),
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

  @override
  void dispose() {
    super.dispose();
    _textEditingControllerTitle.dispose();
    _textEditingControllerBody.dispose();
  }
}