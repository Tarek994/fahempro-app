import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/withdrawal_requests/controllers/insert_edit_withdrawal_request_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/withdrawal_request_model.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/edit_withdrawal_request_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/insert_withdrawal_request_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditWithdrawalRequestScreen extends StatefulWidget {
  final WithdrawalRequestModel? withdrawalRequestModel;

  const InsertEditWithdrawalRequestScreen({
    super.key,
    this.withdrawalRequestModel,
  });

  @override
  State<InsertEditWithdrawalRequestScreen> createState() => _InsertEditWithdrawalRequestScreenState();
}

class _InsertEditWithdrawalRequestScreenState extends State<InsertEditWithdrawalRequestScreen> {
  late InsertEditWithdrawalRequestProvider insertEditWithdrawalRequestProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonOfRejectController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _paymentTypeValueController = TextEditingController();
  WithdrawalRequestStatus? _withdrawalRequestStatus;
  PaymentType? _paymentType;

  @override
  void initState() {
    super.initState();
    insertEditWithdrawalRequestProvider = Provider.of<InsertEditWithdrawalRequestProvider>(context, listen: false);

    if(widget.withdrawalRequestModel != null) {
      _reasonOfRejectController.text = widget.withdrawalRequestModel!.reasonOfReject ?? '';
      _balanceController.text = widget.withdrawalRequestModel!.balance.toString();
      _paymentTypeValueController.text = widget.withdrawalRequestModel!.paymentTypeValue;
      insertEditWithdrawalRequestProvider.setAccount(widget.withdrawalRequestModel!.account);
      _withdrawalRequestStatus = widget.withdrawalRequestModel!.withdrawalRequestStatus;
      _paymentType = widget.withdrawalRequestModel!.paymentType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditWithdrawalRequestProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.withdrawalRequestModel == null ? StringsManager.addWithdrawalRequest : StringsManager.editWithdrawalRequest,
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
                                  insertEditWithdrawalRequestProvider.changeAccount(account);
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

                          // WithdrawalRequestStatus *
                          CustomDropdownButtonFormField(
                            currentValue: _withdrawalRequestStatus,
                            valuesText: List.generate(WithdrawalRequestStatus.values.length, (index) => WithdrawalRequestStatus.toText(WithdrawalRequestStatus.values[index])),
                            valuesObject: WithdrawalRequestStatus.values,
                            onChanged: (value) => setState(() => _withdrawalRequestStatus = value as WithdrawalRequestStatus),
                            labelText: '${Methods.getText(StringsManager.withdrawalRequestStatus).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.circleQuestion,
                            suffixIcon: _withdrawalRequestStatus == null ? const Icon(
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
                                  setState(() => _withdrawalRequestStatus = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Reason Of Reject *
                          if(_withdrawalRequestStatus == WithdrawalRequestStatus.rejected) ...[
                            CustomTextFormField(
                              controller: _reasonOfRejectController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 2,
                              borderRadius: SizeManager.s10,
                              labelText: '${Methods.getText(StringsManager.reasonOfReject).toTitleCase()} *',
                              validator: Validator.validateEmpty,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          // Balance *
                          CustomTextFormField(
                            controller: _balanceController,
                            keyboardType: TextInputType.number,
                            labelText: '${Methods.getText(StringsManager.balance).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.coins,
                            validator: Validator.validateIntegerNumber,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // PaymentType *
                          CustomDropdownButtonFormField(
                            currentValue: _paymentType,
                            valuesText: List.generate(PaymentType.values.length, (index) => PaymentType.toText(PaymentType.values[index])),
                            valuesObject: PaymentType.values,
                            onChanged: (value) => setState(() => _paymentType = value as PaymentType),
                            labelText: '${Methods.getText(StringsManager.paymentType).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.wallet,
                            suffixIcon: _paymentType == null ? const Icon(
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
                                  setState(() => _paymentType = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // paymentTypeValue *
                          if(_paymentType == PaymentType.wallet) CustomTextFormField(
                            controller: _paymentTypeValueController,
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            labelText: '${Methods.getText(StringsManager.phoneNumber).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.phone,
                            validator: Validator.validatePhoneNumber,
                          ),
                          if(_paymentType == PaymentType.instaPay) CustomTextFormField(
                            controller: _paymentTypeValueController,
                            labelText: '${Methods.getText(StringsManager.instaPay).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditWithdrawalRequestProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.withdrawalRequestModel == null) {
                                  InsertWithdrawalRequestParameters insertWithdrawalRequestParameters = InsertWithdrawalRequestParameters(
                                    accountId: provider.account!.accountId,
                                    withdrawalRequestStatus: _withdrawalRequestStatus!,
                                    reasonOfReject: _reasonOfRejectController.text.trim(),
                                    balance: int.parse(_balanceController.text.trim()),
                                    paymentType: _paymentType!,
                                    paymentTypeValue: _paymentTypeValueController.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditWithdrawalRequestProvider.insertWithdrawalRequest(context: context, insertWithdrawalRequestParameters: insertWithdrawalRequestParameters);
                                }
                                else {
                                  EditWithdrawalRequestParameters editWithdrawalRequestParameters = EditWithdrawalRequestParameters(
                                    withdrawalRequestId: widget.withdrawalRequestModel!.withdrawalRequestId,
                                    accountId: provider.account!.accountId,
                                    withdrawalRequestStatus: _withdrawalRequestStatus!,
                                    reasonOfReject: _reasonOfRejectController.text.trim(),
                                    balance: int.parse(_balanceController.text.trim()),
                                    paymentType: _paymentType!,
                                    paymentTypeValue: _paymentTypeValueController.text.trim(),
                                  );
                                  insertEditWithdrawalRequestProvider.editWithdrawalRequest(context: context, editWithdrawalRequestParameters: editWithdrawalRequestParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.withdrawalRequestModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.withdrawalRequestModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _reasonOfRejectController.dispose();
    _balanceController.dispose();
    _paymentTypeValueController.dispose();
    super.dispose();
  }
}