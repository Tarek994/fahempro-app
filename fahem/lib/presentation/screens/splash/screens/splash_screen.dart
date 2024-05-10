import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/presentation/screens/splash/controllers/splash_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/screens/splash/widgets/splash_loading_widget.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashProvider splashProvider;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.getData(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _controller = VideoPlayerController.asset(VideosManager.splashScreen)..initialize().then((_) {
      setState(() {
        _controller.play();
        _controller.setLooping(true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized(),
      ),
      child: Directionality(
        textDirection: Methods.getDirection(),
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Image.asset(
              //   ImagesManager.splashScreen,
              //   width: double.infinity,
              //   height: double.infinity,
              //   fit: BoxFit.fill,
              // ),
              VideoPlayer(_controller),
              Padding(
                padding: const EdgeInsets.only(bottom: SizeManager.s20),
                child: SizedBox(
                  width: SizeManager.s100,
                  height: SizeManager.s40,
                  child: Selector<SplashProvider, bool>(
                    selector: (context, provider) => provider.isErrorOccurred,
                    builder: (context, isErrorOccurred, child) {
                      return isErrorOccurred ? IconButton(
                        onPressed: () async => await splashProvider.onPressedTryAgain(context),
                        padding: EdgeInsets.zero,
                        color: ColorsManager.red700,
                        iconSize: SizeManager.s30,
                        icon: const Icon(Icons.refresh),
                      ) : const SplashLoadingWidget();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}