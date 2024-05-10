import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/screens/splash/controllers/start_provider.dart';
import 'package:fahem/presentation/screens/splash/widgets/splash_loading_widget.dart';
import 'package:fahem/presentation/shared/widgets/custom/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late StartProvider startProvider;
  late VideoPlayerController _controller;

  @override
  void initState() {
    debugPrint('initState: StartScreen');
    super.initState();
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

    startProvider = Provider.of<StartProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await startProvider.goToInitialRoute(context, startProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Methods.getDirection(),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_controller),
            const Padding(
              padding: EdgeInsets.only(bottom: SizeManager.s20),
              child: SizedBox(
                width: SizeManager.s100,
                height: SizeManager.s40,
                child: SplashLoadingWidget(),
              ),
            ),
          ],
        ),
      ),
    );

    return const Scaffold(
      body: BackgroundWidget(
        isShowBackground: true,
        child: Center(
          child: CircularProgressIndicator(),
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