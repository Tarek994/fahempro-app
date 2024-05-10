import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/booking_appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/booking_appointments/controllers/booking_appointments_provider.dart';
import 'package:fahem_business/presentation/screens/booking_appointments/widgets/booking_appointment_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

class BookingAppointmentsScreen extends StatefulWidget {
  const BookingAppointmentsScreen({super.key});

  @override
  State<BookingAppointmentsScreen> createState() => _BookingAppointmentsScreenState();
}

class _BookingAppointmentsScreenState extends State<BookingAppointmentsScreen> {
  late BookingAppointmentsProvider bookingAppointmentsProvider;

  @override
  void initState() {
    super.initState();
    bookingAppointmentsProvider = Provider.of<BookingAppointmentsProvider>(context, listen: false);
    bookingAppointmentsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await bookingAppointmentsProvider.fetchData());
  }

  void _onInsert(BookingAppointmentModel? bookingAppointment) {
    if(bookingAppointment != null) {
      bookingAppointmentsProvider.insertInBookingAppointments(bookingAppointment);
      if(bookingAppointmentsProvider.paginationModel != null) bookingAppointmentsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(BookingAppointmentModel? bookingAppointment) {
    if(bookingAppointment != null) {
      bookingAppointmentsProvider.editInBookingAppointments(bookingAppointment);
    }
  }

  void _onDelete(int bookingAppointmentId) {
    bookingAppointmentsProvider.deleteBookingAppointment(context: context, bookingAppointmentId: bookingAppointmentId);
  }

  String _getTitle() {
    if(bookingAppointmentsProvider.bookingAppointmentsArgs == null) {
      return Methods.getText(StringsManager.bookingAppointments).toTitleCase();
    }
    else {
      if(bookingAppointmentsProvider.bookingAppointmentsArgs!.account != null) {
        return bookingAppointmentsProvider.bookingAppointmentsArgs!.account!.fullName;
      }
      else {
        return Methods.getText(StringsManager.bookingAppointments).toTitleCase();
      }
    }
  }

  List<FiltersType> _getFiltersItems() {
    if(bookingAppointmentsProvider.bookingAppointmentsArgs == null) {
      return const [FiltersType.dateOfCreated];
    }
    else {
      if(bookingAppointmentsProvider.bookingAppointmentsArgs!.account != null) {
        return const [FiltersType.dateOfCreated];
      }
      else {
        return const [FiltersType.dateOfCreated];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingAppointmentsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          title: _getTitle(),
          isSearchFilterOrderWidgetInAction: true,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            isSupportSearch: false,
            ordersItems: const [OrderByType.bookingAppointmentsNewestFirst, OrderByType.bookingAppointmentsOldestFirst],
            filtersItems: _getFiltersItems(),
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.bookingAppointments.isNotEmpty,
          dataCount: provider.bookingAppointments.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => BookingAppointmentListItem(
            bookingAppointmentModel: provider.bookingAppointments[index],
            onEdit: (bookingAppointment) => _onEdit(bookingAppointment),
            onDelete: () => _onDelete(provider.bookingAppointments[index].bookingAppointmentId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoBookingAppointments,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    bookingAppointmentsProvider.setIsScreenDisposed(true);
    bookingAppointmentsProvider.scrollController.dispose();
  }
}