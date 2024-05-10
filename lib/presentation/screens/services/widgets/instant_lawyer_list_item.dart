import 'package:animate_do/animate_do.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/services/location_service.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/presentation/screens/services/controllers/instant_lawyers_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:fahem/presentation/shared/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class InstantLawyerListItem extends StatefulWidget {
  final AccountModel accountModel;

  const InstantLawyerListItem({
    super.key,
    required this.accountModel,
  });

  @override
  State<InstantLawyerListItem> createState() => _InstantLawyerListItemState();
}

class _InstantLawyerListItemState extends State<InstantLawyerListItem> {
  late InstantLawyersProvider instantLawyersProvider;

  @override
  void initState() {
    super.initState();
    instantLawyersProvider = Provider.of<InstantLawyersProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    String distance = LocationService.distanceBetweenTwoPointsInKms(
      startPoint: LatLng(instantLawyersProvider.currentPosition.latitude, instantLawyersProvider.currentPosition.longitude),
      endPoint: LatLng(widget.accountModel.latitude!, widget.accountModel.longitude!),
    ).toStringAsFixed(2);

    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        boxShadow: [ColorsManager.boxShadow2],
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(
                    context,
                    Routes.accountDetailsScreen,
                    arguments: widget.accountModel,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: SizeManager.s8),
                  child: ImageWidget(
                    image: widget.accountModel.personalImage,
                    imageDirectory: ApiConstants.accountsDirectory,
                    defaultImage: ImagesManager.defaultAvatar,
                    width: SizeManager.s50,
                    height: SizeManager.s50,
                    boxShape: BoxShape.circle,
                    isShowFullImageScreen: false,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameWidget(
                        fullName: widget.accountModel.fullName,
                        isFeatured: widget.accountModel.isFeatured,
                        isSupportFeatured: true,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeightManager.black,
                          height: SizeManager.s1_8,
                        ),
                      ),
                      if(widget.accountModel.jobTitle != null) ...[
                        const SizedBox(height: SizeManager.s5),
                        Text(
                          widget.accountModel.jobTitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(height: SizeManager.s1_5),
                        ),
                      ],
                      if(widget.accountModel.consultationPrice != null) ...[
                        const SizedBox(height: SizeManager.s5),
                        Text(
                          '${Methods.getText(StringsManager.consultationPrice).toCapitalized()}: ${widget.accountModel.consultationPrice} ${Methods.getText(StringsManager.egp).toUpperCase()}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      const SizedBox(height: SizeManager.s5),
                      Text(
                        MyProviders.appProvider.isEnglish
                            ? '${"A distance away from you"} $distance ${"KM"}'
                            : '${"يبعد عنك مسافة"} $distance ${"كم"}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(height: SizeManager.s1_5),
                      ),
                    ],
                  ),
                ),
              ),
              CallNowButton(accountModel: widget.accountModel),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.accountDetailsScreen,
                      arguments: widget.accountModel,
                    );
                  },
                  buttonType: ButtonType.preImage,
                  text: Methods.getText(StringsManager.viewProfile).toUpperCase(),
                  imageName: IconsManager.profile,
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: ColorsManager.lightSecondaryColor,
                  textColor: ColorsManager.white,
                  imageColor: ColorsManager.white,
                  textFontWeight: FontWeightManager.black,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    instantLawyersProvider.changeSelectedAccount(widget.accountModel);
                    instantLawyersProvider.googleMapController.animateCamera(
                      CameraUpdate.newLatLng(LatLng(widget.accountModel.latitude!, widget.accountModel.longitude!)),
                    );
                    instantLawyersProvider.changeMakers({
                      Marker(
                        markerId: const MarkerId('1'),
                        position: LatLng(widget.accountModel.latitude!, widget.accountModel.longitude!),
                      ),
                    });
                  },
                  buttonType: ButtonType.preImage,
                  text: Methods.getText(StringsManager.showOnMap).toUpperCase(),
                  imageName: IconsManager.location,
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: ColorsManager.lightSecondaryColor,
                  textColor: ColorsManager.white,
                  imageColor: ColorsManager.white,
                  textFontWeight: FontWeightManager.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CallNowButton extends StatelessWidget {
  final AccountModel accountModel;

  const CallNowButton({
    super.key,
    required this.accountModel,
  });

  @override
  Widget build(BuildContext context) {
    return Flash(
      duration: const Duration(seconds: 5),
      infinite: true,
      child: GestureDetector(
        onTap: () async {
          await Vibration.hasVibrator().then((hasVibrator) {
            if(hasVibrator != null && hasVibrator) {
              Vibration.vibrate(duration: 100);
            }
            Dialogs.onPressedCallNow(
              context: context,
              // title: Methods.getText(StringsManager.pleaseEnterYourDataToShowTheLawyerNumber).toCapitalized(),
              account: accountModel,
            );
          });
        },
        child: Container(
          padding: const EdgeInsets.all(SizeManager.s3),
          decoration: BoxDecoration(
            color: ColorsManager.callNowColor1,
            borderRadius: BorderRadius.circular(SizeManager.s5),
          ),
          child: Container(
            padding: const EdgeInsets.all(SizeManager.s3),
            decoration: BoxDecoration(
              color: ColorsManager.callNowColor2,
              borderRadius: BorderRadius.circular(SizeManager.s5),
            ),
            child: Container(
              padding: const EdgeInsets.all(SizeManager.s3),
              decoration: BoxDecoration(
                color: ColorsManager.callNowColor3,
                borderRadius: BorderRadius.circular(SizeManager.s5),
              ),
              child: Row(
                children: [
                  Text(
                    Methods.getText(StringsManager.callNow).toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                  ),
                  const SizedBox(width: SizeManager.s5),
                  const Icon(Icons.phone, color: ColorsManager.white, size: SizeManager.s16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
