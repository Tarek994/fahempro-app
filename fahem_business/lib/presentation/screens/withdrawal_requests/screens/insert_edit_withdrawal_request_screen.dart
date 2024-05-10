import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/screens/withdrawal_requests/controllers/insert_edit_withdrawal_request_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/withdrawal_request_model.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/edit_withdrawal_request_usecase.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/insert_withdrawal_request_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

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
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _paymentTypeValueController = TextEditingController();
  PaymentType? _paymentType;

  @override
  void initState() {
    super.initState();
    insertEditWithdrawalRequestProvider = Provider.of<InsertEditWithdrawalRequestProvider>(context, listen: false);

    if(widget.withdrawalRequestModel != null) {
      _balanceController.text = widget.withdrawalRequestModel!.balance.toString();
      _paymentTypeValueController.text = widget.withdrawalRequestModel!.paymentTypeValue;
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
                              if(_formKey.currentState!.validate() && provider.isAllDataValid(balance: int.parse(_balanceController.text.trim()))) {
                                if(widget.withdrawalRequestModel == null) {
                                  InsertWithdrawalRequestParameters insertWithdrawalRequestParameters = InsertWithdrawalRequestParameters(
                                    accountId: MyProviders.authenticationProvider.currentAccount.accountId,
                                    withdrawalRequestStatus: WithdrawalRequestStatus.pending,
                                    reasonOfReject: null,
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
                                    accountId: widget.withdrawalRequestModel!.accountId,
                                    withdrawalRequestStatus: widget.withdrawalRequestModel!.withdrawalRequestStatus,
                                    reasonOfReject: widget.withdrawalRequestModel!.reasonOfReject,
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
    _balanceController.dispose();
    _paymentTypeValueController.dispose();
    super.dispose();
  }
}