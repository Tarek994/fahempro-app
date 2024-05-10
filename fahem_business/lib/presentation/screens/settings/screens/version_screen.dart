import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/version_model.dart';
import 'package:fahem_business/presentation/screens/settings/controllers/version_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/shared/widgets/template_item_screen.dart';

class VersionScreen extends StatefulWidget {
  final App app;

  const VersionScreen({
    super.key,
    required this.app,
  });

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  late VersionProvider versionProvider;

  @override
  void initState() {
    super.initState();
    versionProvider = Provider.of<VersionProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async => await versionProvider.fetchData(app: widget.app));
  }

  void _onEdit(VersionModel? version) {
    if(version != null) {
      versionProvider.editVersionModel(version);
    }
  }

  String _getScreenTitle() {
    switch(widget.app) {
      case App.fahem: return StringsManager.fahemVersionApp;
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VersionProvider>(
      builder: (context, provider, _) {
        return TemplateItemScreen(
          isShowLoading: provider.dataState == DataState.loading,
          reFetchData: () async => await provider.reFetchData(app: widget.app),
          goToEditScreen: Methods.checkAdminPermission(AdminPermissions.editVersion) ? () {
            Methods.routeTo(context, Routes.editVersionScreen, arguments: [provider.versionModel, widget.app], then: (version) => _onEdit(version));
          } : null,
          screenTitle: _getScreenTitle(),
          dataState: provider.dataState,
          child: provider.dataState != DataState.done ? const SizedBox() : Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .5 - 70,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(SizeManager.s15),
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(SizeManager.s15),
                      boxShadow: [ColorsManager.boxShadow2],
                    ),
                    child: Text(
                      '${Methods.getText(StringsManager.appVersion).toTitleCase()}\n\n${provider.versionModel.version}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    versionProvider.setIsScreenDisposed(true);
  }
}