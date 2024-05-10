import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/instant_consultation_model.dart';
import 'package:fahem/presentation/screens/transactions/widgets/secret_consultation_list_item.dart';
import 'package:fahem/presentation/screens/transactions/controllers/transactions_provider.dart';
import 'package:fahem/presentation/screens/transactions/widgets/booking_appointment_list_item.dart';
import 'package:fahem/presentation/screens/transactions/widgets/extra_widget_in_transactions.dart';
import 'package:fahem/presentation/screens/transactions/widgets/instant_consultation_list_item.dart';
import 'package:fahem/presentation/screens/transactions/widgets/phone_number_request_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatefulWidget {
  
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late TransactionsProvider transactionsProvider;

  @override
  void initState() {
    super.initState();
    transactionsProvider = Provider.of<TransactionsProvider>(context, listen: false);
    transactionsProvider.resetInstantConsultationsVariablesToDefault();
    transactionsProvider.resetSecretConsultationsVariablesToDefault();
    transactionsProvider.resetPhoneNumberRequestsVariablesToDefault();
    transactionsProvider.resetBookingAppointmentsVariablesToDefault();
    transactionsProvider.instantConsultationsAddListenerScrollController();
    transactionsProvider.secretConsultationsAddListenerScrollController();
    transactionsProvider.phoneNumberRequestsAddListenerScrollController();
    transactionsProvider.bookingAppointmentsAddListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        transactionsProvider.fetchInstantConsultations(),
        transactionsProvider.fetchSecretConsultations(),
        transactionsProvider.fetchPhoneNumberRequests(),
        transactionsProvider.fetchBookingAppointments(),
      ]);
    });
  }

  void _onEdit(InstantConsultationModel? instantConsultation) {
    if(instantConsultation != null) {
      transactionsProvider.editInInstantConsultations(instantConsultation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsProvider>(
      builder: (context, provider, _) {
        if(provider.currentTransactionsPages == TransactionsPages.instantConsultations) {
          return TemplateListScreen(
            reFetchData: () async {
              await Future.wait([
                provider.reFetchInstantConsultations(),
              ]);
            },
            scrollController: provider.instantConsultationsScrollController,
            goToInsertScreen: null,
            appBarColor: ColorsManager.white,
            isSupportAppBar: false,
            searchFilterOrderWidget: null,
            isDataNotEmpty: provider.instantConsultations.isNotEmpty,
            dataCount: provider.instantConsultations.length,
            totalResults: provider.instantConsultationsPaginationModel == null ? 0 : provider.instantConsultationsPaginationModel!.total,
            supportedViewStyle: const [ViewStyle.list],
            currentViewStyle: provider.instantConsultationsViewStyle,
            changeViewStyleToList: () => provider.changeInstantConsultationsViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changeInstantConsultationsViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => InstantConsultationListItem(
              instantConsultationModel: provider.instantConsultations[index],
              onEdit: (instantConsultation) => _onEdit(instantConsultation),
            ),
            gridItemBuilder: null,
            dataState: provider.instantConsultationsDataState,
            hasMore: provider.instantConsultationsHasMore,
            noDataMsgInScreen: StringsManager.thereAreNoTransactions,
            extraWidget: const ExtraWidgetInTransactions(),
          );
        }
        if(provider.currentTransactionsPages == TransactionsPages.secretConsultations) {
          return TemplateListScreen(
            reFetchData: () async {
              await Future.wait([
                provider.reFetchSecretConsultations(),
              ]);
            },
            scrollController: provider.secretConsultationsScrollController,
            goToInsertScreen: null,
            appBarColor: ColorsManager.white,
            isSupportAppBar: false,
            searchFilterOrderWidget: null,
            isDataNotEmpty: provider.secretConsultations.isNotEmpty,
            dataCount: provider.secretConsultations.length,
            totalResults: provider.secretConsultationsPaginationModel == null ? 0 : provider.secretConsultationsPaginationModel!.total,
            supportedViewStyle: const [ViewStyle.list],
            currentViewStyle: provider.secretConsultationsViewStyle,
            changeViewStyleToList: () => provider.changeSecretConsultationsViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changeSecretConsultationsViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => SecretConsultationListItem(secretConsultationModel: provider.secretConsultations[index]),
            gridItemBuilder: null,
            dataState: provider.secretConsultationsDataState,
            hasMore: provider.secretConsultationsHasMore,
            noDataMsgInScreen: StringsManager.thereAreNoTransactions,
            extraWidget: const ExtraWidgetInTransactions(),
          );
        }
        if(provider.currentTransactionsPages == TransactionsPages.phoneNumberRequests) {
          return TemplateListScreen(
            reFetchData: () async {
              await Future.wait([
                provider.reFetchPhoneNumberRequests(),
              ]);
            },
            scrollController: provider.phoneNumberRequestsScrollController,
            goToInsertScreen: null,
            appBarColor: ColorsManager.white,
            isSupportAppBar: false,
            searchFilterOrderWidget: null,
            isDataNotEmpty: provider.phoneNumberRequests.isNotEmpty,
            dataCount: provider.phoneNumberRequests.length,
            totalResults: provider.phoneNumberRequestsPaginationModel == null ? 0 : provider.phoneNumberRequestsPaginationModel!.total,
            supportedViewStyle: const [ViewStyle.list],
            currentViewStyle: provider.phoneNumberRequestsViewStyle,
            changeViewStyleToList: () => provider.changePhoneNumberRequestsViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changePhoneNumberRequestsViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => PhoneNumberRequestListItem(phoneNumberRequestModel: provider.phoneNumberRequests[index]),
            gridItemBuilder: null,
            dataState: provider.phoneNumberRequestsDataState,
            hasMore: provider.phoneNumberRequestsHasMore,
            noDataMsgInScreen: StringsManager.thereAreNoTransactions,
            extraWidget: const ExtraWidgetInTransactions(),
          );
        }
        if(provider.currentTransactionsPages == TransactionsPages.bookingAppointments) {
          return TemplateListScreen(
            reFetchData: () async {
              await Future.wait([
                provider.reFetchBookingAppointments(),
              ]);
            },
            scrollController: provider.bookingAppointmentsScrollController,
            goToInsertScreen: null,
            appBarColor: ColorsManager.white,
            isSupportAppBar: false,
            searchFilterOrderWidget: null,
            isDataNotEmpty: provider.bookingAppointments.isNotEmpty,
            dataCount: provider.bookingAppointments.length,
            totalResults: provider.bookingAppointmentsPaginationModel == null ? 0 : provider.bookingAppointmentsPaginationModel!.total,
            supportedViewStyle: const [ViewStyle.list],
            currentViewStyle: provider.bookingAppointmentsViewStyle,
            changeViewStyleToList: () => provider.changeBookingAppointmentsViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changeBookingAppointmentsViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => BookingAppointmentListItem(bookingAppointmentModel: provider.bookingAppointments[index]),
            gridItemBuilder: null,
            dataState: provider.bookingAppointmentsDataState,
            hasMore: provider.bookingAppointmentsHasMore,
            noDataMsgInScreen: StringsManager.thereAreNoTransactions,
            extraWidget: const ExtraWidgetInTransactions(),
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    transactionsProvider.setIsScreenDisposed(true);
    transactionsProvider.setCurrentTransactionsPages(TransactionsPages.instantConsultations);
    // transactionsProvider.instantConsultationsScrollController.dispose();
    // transactionsProvider.secretConsultationsScrollController.dispose();
    // transactionsProvider.phoneNumberRequestsScrollController.dispose();
    // transactionsProvider.bookingAppointmentsScrollController.dispose();
  }
}