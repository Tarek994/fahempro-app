import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/screens/splash/controllers/start_provider.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late StartProvider startProvider;

  @override
  void initState() {
    debugPrint('initState: StartScreen');
    super.initState();
    startProvider = Provider.of<StartProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await startProvider.goToInitialRoute(context, startProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: SizeManager.s0,
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}