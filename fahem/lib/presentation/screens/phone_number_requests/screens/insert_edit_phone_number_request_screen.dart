import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/presentation/screens/phone_number_requests/controllers/insert_edit_phone_number_request_provider.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/phone_number_request_model.dart';
import 'package:fahem/domain/usecases/phone_number_requests/edit_phone_number_request_usecase.dart';
import 'package:fahem/domain/usecases/phone_number_requests/insert_phone_number_request_usecase.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';

class InsertEditPhoneNumberRequestScreen extends StatefulWidget {
  final PhoneNumberRequestModel? phoneNumberRequestModel;

  const InsertEditPhoneNumberRequestScreen({
    super.key,
    this.phoneNumberRequestModel,
  });

  @override
  State<InsertEditPhoneNumberRequestScreen> createState() => _InsertEditPhoneNumberRequestScreenState();
}

class _InsertEditPhoneNumberRequestScreenState extends State<InsertEditPhoneNumberRequestScreen> {
  late InsertEditPhoneNumberRequestProvider insertEditPhoneNumberRequestProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    insertEditPhoneNumberRequestProvider = Provider.of<InsertEditPhoneNumberRequestProvider>(context, listen: false);

    if(widget.phoneNumberRequestModel != null) {
      insertEditPhoneNumberRequestProvider.setAccount(widget.phoneNumberRequestModel!.account);
      insertEditPhoneNumberRequestProvider.setUser(widget.phoneNumberRequestModel!.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditPhoneNumberRequestProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.phoneNumberRequestModel == null ? StringsManager.addPhoneNumberRequest : StringsManager.editPhoneNumberRequest,
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
                                  insertEditPhoneNumberRequestProvider.changeAccount(account);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.account == null ? Methods.getText(StringsManager.chooseAccount).toCapitalized() : provider.account!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.account == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.account == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // User *
                          CustomButton(
                            onPressed: () {
                              Dialogs.usersBottomSheet(context: context).then((user) {
                                if(user != null) {
                                  insertEditPhoneNumberRequestProvider.changeUser(user);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.user == null ? Methods.getText(StringsManager.chooseUser).toCapitalized() : provider.user!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.user == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.user == null,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditPhoneNumberRequestProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.phoneNumberRequestModel == null) {
                                  InsertPhoneNumberRequestParameters insertPhoneNumberRequestParameters = InsertPhoneNumberRequestParameters(
                                    accountId: provider.account!.accountId,
                                    userId: provider.user!.userId,
                                    isViewed: false,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditPhoneNumberRequestProvider.insertPhoneNumberRequest(context: context, insertPhoneNumberRequestParameters: insertPhoneNumberRequestParameters);
                                }
                                else {
                                  EditPhoneNumberRequestParameters editPhoneNumberRequestParameters = EditPhoneNumberRequestParameters(
                                    phoneNumberRequestId: widget.phoneNumberRequestModel!.phoneNumberRequestId,
                                    accountId: provider.account!.accountId,
                                    userId: provider.user!.userId,
                                    isViewed: widget.phoneNumberRequestModel!.isViewed,
                                  );
                                  insertEditPhoneNumberRequestProvider.editPhoneNumberRequest(context: context, editPhoneNumberRequestParameters: editPhoneNumberRequestParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.phoneNumberRequestModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.phoneNumberRequestModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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