import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/about_app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/about_app/controllers/about_app_provider.dart';
import 'package:fahem/presentation/shared/widgets/template_item_screen.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  late AboutAppProvider aboutAppProvider;
  
  @override
  void initState() {
    super.initState();
    aboutAppProvider = Provider.of<AboutAppProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async => await aboutAppProvider.fetchData());
  }

  void _onEdit(AboutAppModel? aboutApp) {
    if(aboutApp != null) {
      aboutAppProvider.editAboutApp(aboutApp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AboutAppProvider>(
      builder: (context, provider, _) {
        return TemplateItemScreen(
          isShowLoading: provider.dataState == DataState.loading,
          reFetchData: () async => await provider.reFetchData(),
          goToEditScreen: null,
          screenTitle: StringsManager.aboutApp,
          dataState: provider.dataState,
          child: provider.dataState != DataState.done ? const SizedBox() : Text(
            MyProviders.appProvider.isEnglish ? provider.aboutAppModel.textEn : provider.aboutAppModel.textAr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    aboutAppProvider.setIsScreenDisposed(true);
  }
}