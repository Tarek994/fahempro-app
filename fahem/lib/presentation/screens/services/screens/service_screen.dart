// import 'package:fahem/core/resources/assets_manager.dart';
// import 'package:fahem/core/resources/colors_manager.dart';
// import 'package:fahem/core/resources/fonts_manager.dart';
// import 'package:fahem/core/resources/strings_manager.dart';
// import 'package:fahem/core/resources/values_manager.dart';
// import 'package:fahem/core/utilities/dialogs.dart';
// import 'package:fahem/core/utilities/extensions.dart';
// import 'package:fahem/core/utilities/methods.dart';
// import 'package:fahem/core/utilities/my_providers.dart';
// import 'package:fahem/presentation/screens/services/controllers/service_provider.dart';
// import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
// import 'package:fahem/presentation/shared/widgets/not_found_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
//
// class DebtCollectionScreen extends StatefulWidget {
//
//   const DebtCollectionScreen({super.key});
//
//   @override
//   State<DebtCollectionScreen> createState() => _DebtCollectionScreenState();
// }
//
// class _DebtCollectionScreenState extends State<DebtCollectionScreen> {
//   late ServiceProvider serviceProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
//
//     serviceProvider.setDebtCollection(lawyersProvider.lawyers.where((element) {
//       double distanceKm = Geolocator.distanceBetween(serviceProvider.myCurrentPositionLatitude, serviceProvider.myCurrentPositionLongitude, element.latitude, element.longitude)/1000;
//       return element.isSubscriberToDebtCollectionService && distanceKm <= settingsProvider.settings.distanceKm;
//     }).toList());
//     serviceProvider.initScrollController();
//     serviceProvider.showDataInList(isResetData: true, isRefresh: false, isScrollUp: false);
//
//     serviceProvider.setMakers({
//       Marker(
//         markerId: const MarkerId('1'),
//         position: LatLng(serviceProvider.myCurrentPositionLatitude, serviceProvider.myCurrentPositionLongitude),
//       ),
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: Methods.getDirection(),
//       child: Scaffold(
//         body: SafeArea(
//           child: Consumer<ServiceProvider>(
//             builder: (context, provider, _) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       Center(
//                         child: CustomButton(
//                           // onPressed: () => Dialogs.showBottomSheetGovernorates(context: context).then((value) {
//                           //   if(value != null) {
//                           //     if(value.governoratesMode == GovernoratesMode.currentLocation) {
//                           //       provider.changeDebtCollection(lawyersProvider.lawyers.where((element) {
//                           //         double distanceKm = Geolocator.distanceBetween(provider.myCurrentPositionLatitude, provider.myCurrentPositionLongitude, element.latitude, element.longitude)/1000;
//                           //         return element.isSubscriberToDebtCollectionService
//                           //             && distanceKm <= settingsProvider.settings.distanceKm;
//                           //       }).toList());
//                           //       provider.changeSelectedGovernmentModel(value);
//                           //     }
//                           //     else if(value.governoratesMode == GovernoratesMode.allGovernorates) {
//                           //       provider.changeDebtCollection(lawyersProvider.lawyers.where((element) {
//                           //         return element.isSubscriberToDebtCollectionService;
//                           //       }).toList());
//                           //       provider.changeSelectedGovernmentModel(value);
//                           //     }
//                           //     else {
//                           //       provider.changeDebtCollection(lawyersProvider.lawyers.where((element) {
//                           //         return element.isSubscriberToDebtCollectionService
//                           //             && element.governorate == value.nameAr;
//                           //       }).toList());
//                           //       provider.changeSelectedGovernmentModel(value);
//                           //     }
//                           //   }
//                           // }),
//                           buttonType: ButtonType.preImage,
//                           text: MyProviders.appProvider.isEnglish ? provider.selectedGovernmentModel.governorateNameEn : provider.selectedGovernmentModel.governorateNameAr,
//                           textColor: ColorsManager.lightPrimaryColor,
//                           imageName: IconsManager.animatedMap,
//                           imageColor: ColorsManager.lightPrimaryColor,
//                           imageSize: SizeManager.s25,
//                           width: null,
//                           buttonColor: ColorsManager.white,
//                           borderColor: ColorsManager.lightPrimaryColor,
//                           height: SizeManager.s35,
//                           borderRadius: SizeManager.s10,
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: SizeManager.s10),
//                         // child: PreviousButton(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: SizeManager.s10),
//                   if(provider.debtCollection.isNotEmpty) SizedBox(
//                     height: SizeManager.s300,
//                     child: GoogleMap(
//                       onMapCreated: (GoogleMapController controller) => provider.googleMapController = controller,
//                       mapType: MapType.normal,
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(provider.selectedGovernmentModel.latitude, provider.selectedGovernmentModel.longitude),
//                         zoom: 17,
//                       ),
//                       markers: provider.markers,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: SizeManager.s16, left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           Methods.getText(StringsManager.atYourService).toTitleCase(),
//                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.black),
//                         ),
//                         Text(
//                           '${provider.debtCollection.length} ${Methods.getText(StringsManager.result)}',
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: provider.debtCollection.isEmpty ? const NotFoundWidget(message: StringsManager.thereAreNoResults) : ListView.separated(
//                       controller: provider.scrollController,
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.only(top: SizeManager.s8, left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
//                       itemBuilder: (context, index) {
//                         return Column(
//                           children: [
//                             DebtCollectionItem(lawyerModel: provider.debtCollection[index]),
//                             if(index == provider.numberOfItems-1) Padding(
//                               padding: const EdgeInsets.only(top: SizeManager.s16),
//                               child: Column(
//                                 children: [
//                                   if(provider.hasMoreData) const Center(
//                                     child: SizedBox(
//                                       width: SizeManager.s20,
//                                       height: SizeManager.s20,
//                                       child: CircularProgressIndicator(strokeWidth: SizeManager.s3, color: ColorsManager.lightPrimaryColor),
//                                     ),
//                                   ),
//                                   if(!provider.hasMoreData && provider.debtCollection.length > provider.limit) Text(
//                                     Methods.getText(StringsManager.thereAreNoOtherResults).toCapitalized(),
//                                     textAlign: TextAlign.center,
//                                     style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeightManager.black),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                       separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
//                       itemCount: provider.numberOfItems,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     try {serviceProvider.googleMapController.dispose();} catch(error) {debugPrint(error.toString());}
//     serviceProvider.disposeScrollController();
//     super.dispose();
//   }
// }


import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/service_model.dart';
import 'package:fahem/presentation/screens/services/controllers/service_provider.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/accounts/widgets/account_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class ServiceScreen extends StatefulWidget {

  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  late ServiceProvider serviceProvider;

  @override
  void initState() {
    super.initState();
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await serviceProvider.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          // screenTitle: StringsManager.accounts,
          title: MyProviders.appProvider.isEnglish ? provider.service.nameEn : provider.service.nameAr,
          searchFilterOrderWidget: null,
          scaffoldColor: ColorsManager.white,
          // searchFilterOrderWidget: SearchFilterOrderWidget(
          //   hintText: StringsManager.searchByName,
          //   ordersItems: const [OrderByType.accountsNewestFirst, OrderByType.accountsOldestFirst],
          //   filtersItems: const [FiltersType.gender, FiltersType.isFeatured],
          //   dataState: provider.dataState,
          //   reFetchData: () async => await provider.reFetchData(),
          //   customText: {
          //     FiltersType.dateOfCreated.name: StringsManager.joinDate,
          //   },
          // ),
          isDataNotEmpty: provider.accounts.isNotEmpty,
          dataCount: provider.accounts.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => AccountListItem(
            accountModel: provider.accounts[index],
            index: index,
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.availableSoon,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    serviceProvider.setIsScreenDisposed(true);
    serviceProvider.scrollController.dispose();
  }
}