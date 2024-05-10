import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/wallet_history/controllers/insert_edit_wallet_history_provider.dart';
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
import 'package:fahem_dashboard/data/models/wallet_history_model.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/edit_wallet_history_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/insert_wallet_history_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditWalletHistoryScreen extends StatefulWidget {
  final WalletHistoryModel? walletHistoryModel;

  const InsertEditWalletHistoryScreen({
    super.key,
    this.walletHistoryModel,
  });

  @override
  State<InsertEditWalletHistoryScreen> createState() => _InsertEditWalletHistoryScreenState();
}

class _InsertEditWalletHistoryScreenState extends State<InsertEditWalletHistoryScreen> {
  late InsertEditWalletHistoryProvider insertEditWalletHistoryProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _textArController = TextEditingController();
  final TextEditingController _textEnController = TextEditingController();
  UserType? _userType;
  WalletTransactionType? _walletTransactionType;

  @override
  void initState() {
    super.initState();
    insertEditWalletHistoryProvider = Provider.of<InsertEditWalletHistoryProvider>(context, listen: false);

    if(widget.walletHistoryModel != null) {
      _amountController.text = widget.walletHistoryModel!.amount.toString();
      _textArController.text = widget.walletHistoryModel!.textAr;
      _textEnController.text = widget.walletHistoryModel!.textEn;
      _userType = widget.walletHistoryModel!.userType;
      _walletTransactionType = widget.walletHistoryModel!.walletTransactionType;
      insertEditWalletHistoryProvider.setAccount(widget.walletHistoryModel!.account);
      insertEditWalletHistoryProvider.setUser(widget.walletHistoryModel!.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditWalletHistoryProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.walletHistoryModel == null ? StringsManager.addWalletHistory : StringsManager.editWalletHistory,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // userType *
                          CustomDropdownButtonFormField(
                            currentValue: _userType,
                            valuesText: List.generate(UserType.values.length, (index) => UserType.toText(UserType.values[index])),
                            valuesObject: UserType.values,
                            onChanged: (value) {
                              _userType = value as UserType;
                              provider.setAccount(null);
                              provider.setUser(null);
                              setState(() {});
                            },
                            labelText: '${Methods.getText(StringsManager.accountType).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.user,
                            suffixIcon: _userType == null ? const Icon(
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
                                  _userType = null;
                                  provider.setAccount(null);
                                  provider.setUser(null);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Account *
                          if(_userType == UserType.account) ...[
                            CustomButton(
                              onPressed: () {
                                Dialogs.accountsBottomSheet(context: context).then((account) {
                                  if(account != null) {
                                    insertEditWalletHistoryProvider.changeAccount(account);
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
                          ],

                          // User *
                          if(_userType == UserType.user) ...[
                            CustomButton(
                              onPressed: () {
                                Dialogs.usersBottomSheet(context: context).then((user) {
                                  if(user != null) {
                                    insertEditWalletHistoryProvider.changeUser(user);
                                  }
                                });
                              },
                              buttonType: ButtonType.postSpacerText,
                              text: provider.user == null ? Methods.getText(StringsManager.chooseUser).toCapitalized() : provider.user!.fullName,
                              width: double.infinity,
                              buttonColor: ColorsManager.white,
                              borderColor: ColorsManager.grey300,
                              textColor: provider.user == null ? ColorsManager.grey : ColorsManager.black,
                              fontSize: SizeManager.s12,
                              isRequired: provider.isButtonClicked && provider.user == null,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          // Amount *
                          CustomTextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            labelText: '${Methods.getText(StringsManager.amount).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.coins,
                            validator: Validator.validateIntegerNumber,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // WalletTransactionType *
                          CustomDropdownButtonFormField(
                            currentValue: _walletTransactionType,
                            valuesText: List.generate(WalletTransactionType.values.length, (index) => WalletTransactionType.toText(WalletTransactionType.values[index])),
                            valuesObject: WalletTransactionType.values,
                            onChanged: (value) => setState(() => _walletTransactionType = value as WalletTransactionType),
                            labelText: '${Methods.getText(StringsManager.walletTransactionType).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.solidCircleQuestion,
                            suffixIcon: _walletTransactionType == null ? const Icon(
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
                                  setState(() => _walletTransactionType = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // textAr *
                          CustomTextFormField(
                            controller: _textArController,
                            labelText: '${Methods.getText(StringsManager.text).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // textEn *
                          CustomTextFormField(
                            controller: _textEnController,
                            labelText: '${Methods.getText(StringsManager.text).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditWalletHistoryProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid(userType: _userType!)) {
                                if(widget.walletHistoryModel == null) {
                                  InsertWalletHistoryParameters insertWalletHistoryParameters = InsertWalletHistoryParameters(
                                    userType: _userType!,
                                    accountId: _userType == UserType.account ? provider.account!.accountId : null,
                                    userId: _userType == UserType.user ? provider.user!.userId : null,
                                    amount: int.parse(_amountController.text.trim()),
                                    walletTransactionType: _walletTransactionType!,
                                    textAr: _textArController.text.trim(),
                                    textEn: _textEnController.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditWalletHistoryProvider.insertWalletHistory(context: context, insertWalletHistoryParameters: insertWalletHistoryParameters);
                                }
                                else {
                                  EditWalletHistoryParameters editWalletHistoryParameters = EditWalletHistoryParameters(
                                    walletHistoryId: widget.walletHistoryModel!.walletHistoryId,
                                    userType: _userType!,
                                    accountId: _userType == UserType.account ? provider.account!.accountId : null,
                                    userId: _userType == UserType.user ? provider.user!.userId : null,
                                    amount: int.parse(_amountController.text.trim()),
                                    walletTransactionType: _walletTransactionType!,
                                    textAr: _textArController.text.trim(),
                                    textEn: _textEnController.text.trim(),
                                  );
                                  insertEditWalletHistoryProvider.editWalletHistory(context: context, editWalletHistoryParameters: editWalletHistoryParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.walletHistoryModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.walletHistoryModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _amountController.dispose();
    _textArController.dispose();
    _textEnController.dispose();
    super.dispose();
  }
}