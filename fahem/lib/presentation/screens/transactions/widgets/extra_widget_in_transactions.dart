import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/screens/transactions/controllers/transactions_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExtraWidgetInTransactions extends StatefulWidget {

  const ExtraWidgetInTransactions({super.key});

  @override
  State<ExtraWidgetInTransactions> createState() => _ExtraWidgetInTransactionsState();
}

class _ExtraWidgetInTransactionsState extends State<ExtraWidgetInTransactions> {
  late TransactionsProvider transactionsProvider;

  @override
  void initState() {
    super.initState();
    transactionsProvider = Provider.of<TransactionsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeManager.s45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
        children: [
          CustomButton(
            onPressed: () {
              if(transactionsProvider.currentTransactionsPages == TransactionsPages.instantConsultations) return;
              transactionsProvider.setCurrentTransactionsPages(TransactionsPages.instantConsultations);
              transactionsProvider.reFetchInstantConsultations();
            },
            buttonType: ButtonType.text,
            text: Methods.getText(StringsManager.instantConsultations).toCapitalized(),
            buttonColor: transactionsProvider.currentTransactionsPages == TransactionsPages.instantConsultations ? ColorsManager.lightSecondaryColor : ColorsManager.white,
            borderColor: transactionsProvider.currentTransactionsPages == TransactionsPages.instantConsultations ? ColorsManager.lightSecondaryColor : ColorsManager.lightPrimaryColor,
            textColor: transactionsProvider.currentTransactionsPages == TransactionsPages.instantConsultations ? ColorsManager.white : ColorsManager.lightPrimaryColor,
            textFontWeight: FontWeightManager.black,
            height: SizeManager.s35,
          ),
          const SizedBox(width: SizeManager.s10),
          CustomButton(
            onPressed: () {
              if(transactionsProvider.currentTransactionsPages == TransactionsPages.secretConsultations) return;
              transactionsProvider.setCurrentTransactionsPages(TransactionsPages.secretConsultations);
              transactionsProvider.reFetchSecretConsultations();
            },
            buttonType: ButtonType.text,
            text: Methods.getText(StringsManager.secretConsultations).toCapitalized(),
            buttonColor: transactionsProvider.currentTransactionsPages == TransactionsPages.secretConsultations ? ColorsManager.lightSecondaryColor : ColorsManager.white,
            borderColor: transactionsProvider.currentTransactionsPages == TransactionsPages.secretConsultations ? ColorsManager.lightSecondaryColor : ColorsManager.lightPrimaryColor,
            textColor: transactionsProvider.currentTransactionsPages == TransactionsPages.secretConsultations ? ColorsManager.white : ColorsManager.lightPrimaryColor,
            textFontWeight: FontWeightManager.black,
            height: SizeManager.s35,
          ),
          const SizedBox(width: SizeManager.s10),
          CustomButton(
            onPressed: () {
              if(transactionsProvider.currentTransactionsPages == TransactionsPages.phoneNumberRequests) return;
              transactionsProvider.setCurrentTransactionsPages(TransactionsPages.phoneNumberRequests);
              transactionsProvider.reFetchPhoneNumberRequests();
            },
            buttonType: ButtonType.text,
            text: Methods.getText(StringsManager.phoneNumberRequests).toCapitalized(),
            buttonColor: transactionsProvider.currentTransactionsPages == TransactionsPages.phoneNumberRequests ? ColorsManager.lightSecondaryColor : ColorsManager.white,
            borderColor: transactionsProvider.currentTransactionsPages == TransactionsPages.phoneNumberRequests ? ColorsManager.lightSecondaryColor : ColorsManager.lightPrimaryColor,
            textColor: transactionsProvider.currentTransactionsPages == TransactionsPages.phoneNumberRequests ? ColorsManager.white : ColorsManager.lightPrimaryColor,
            textFontWeight: FontWeightManager.black,
            height: SizeManager.s35,
          ),
          const SizedBox(width: SizeManager.s10),
          CustomButton(
            onPressed: () {
              if(transactionsProvider.currentTransactionsPages == TransactionsPages.bookingAppointments) return;
              transactionsProvider.setCurrentTransactionsPages(TransactionsPages.bookingAppointments);
              transactionsProvider.reFetchBookingAppointments();
            },
            buttonType: ButtonType.text,
            text: Methods.getText(StringsManager.bookingAppointments).toCapitalized(),
            buttonColor: transactionsProvider.currentTransactionsPages == TransactionsPages.bookingAppointments ? ColorsManager.lightSecondaryColor : ColorsManager.white,
            borderColor: transactionsProvider.currentTransactionsPages == TransactionsPages.bookingAppointments ? ColorsManager.lightSecondaryColor : ColorsManager.lightPrimaryColor,
            textColor: transactionsProvider.currentTransactionsPages == TransactionsPages.bookingAppointments ? ColorsManager.white : ColorsManager.lightPrimaryColor,
            textFontWeight: FontWeightManager.black,
            height: SizeManager.s35,
          ),
        ],
      ),
    );
  }
}
