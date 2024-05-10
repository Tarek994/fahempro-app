import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/screens/home/widgets/main_title.dart';
import 'package:fahem/presentation/screens/services/controllers/instant_lawyers_provider.dart';
import 'package:fahem/presentation/shared/widgets/my_error_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ExtraWidgetInInstantLawyers extends StatefulWidget {

  const ExtraWidgetInInstantLawyers({super.key});

  @override
  State<ExtraWidgetInInstantLawyers> createState() => _ExtraWidgetInInstantLawyersState();
}

class _ExtraWidgetInInstantLawyersState extends State<ExtraWidgetInInstantLawyers> {
  late InstantLawyersProvider instantLawyersProvider;

  @override
  void initState() {
    instantLawyersProvider = Provider.of<InstantLawyersProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      width: double.infinity,
      child: Consumer<InstantLawyersProvider>(
        builder: (context, instantLawyersProvider, _) {
          return ConditionalBuilder(
            condition: instantLawyersProvider.accounts.isNotEmpty,
            builder: (_) {
              return Column(
                children: [
                  SizedBox(
                    height: SizeManager.s300,
                    child: GoogleMap(
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
                      },
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController controller) => instantLawyersProvider.googleMapController = controller,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          instantLawyersProvider.selectedAccount == null ? instantLawyersProvider.currentPosition.latitude : instantLawyersProvider.selectedAccount!.latitude!,
                          instantLawyersProvider.selectedAccount == null ? instantLawyersProvider.currentPosition.longitude : instantLawyersProvider.selectedAccount!.longitude!,
                        ),
                        zoom: 17,
                      ),
                      markers: instantLawyersProvider.markers,
                    ),
                  ),
                  if(instantLawyersProvider.accounts.isNotEmpty) ...[
                    const SizedBox(height: SizeManager.s10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeManager.s16),
                      child: MainTitle(
                        title: StringsManager.instantLawyersAtYourService,
                      ),
                    ),
                  ],
                ],
              );
            },
            fallback: (_) {
              if(instantLawyersProvider.accountsDataState == DataState.loading) {
                return const Padding(
                  padding: EdgeInsets.all(SizeManager.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeManager.s25,
                        height: SizeManager.s25,
                        child: CircularProgressIndicator(strokeWidth: SizeManager.s3),
                      ),
                    ],
                  ),
                );
              }
              if(instantLawyersProvider.accountsDataState == DataState.empty) {
                return const SizedBox();
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(SizeManager.s10),
                    child: Text(
                      Methods.getText(StringsManager.thereAreNoAccounts).toCapitalized(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              }
              if(instantLawyersProvider.accountsDataState == DataState.error) {
                return const SizedBox();
                return MyErrorWidget(onPressed: () => instantLawyersProvider.reFetchAccounts());
              }
              return Container();
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    instantLawyersProvider.setIsScreenDisposed(true);
    instantLawyersProvider.accountsScrollController.dispose();
    try {instantLawyersProvider.googleMapController.dispose();} catch(error) {debugPrint(error.toString());}
    super.dispose();
  }
}