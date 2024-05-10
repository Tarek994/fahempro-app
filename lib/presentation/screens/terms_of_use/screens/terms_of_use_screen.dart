import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/terms_of_use_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/terms_of_use/controllers/terms_of_use_provider.dart';
import 'package:fahem/presentation/shared/widgets/template_item_screen.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  late TermsOfUseProvider termsOfUseProvider;

  @override
  void initState() {
    super.initState();
    termsOfUseProvider = Provider.of<TermsOfUseProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async => await termsOfUseProvider.fetchData());
  }

  void _onEdit(TermsOfUseModel? termsOfUse) {
    if(termsOfUse != null) {
      termsOfUseProvider.editTermsOfUse(termsOfUse);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TermsOfUseProvider>(
      builder: (context, provider, _) {
        return TemplateItemScreen(
          isShowLoading: provider.dataState == DataState.loading,
          reFetchData: () async => await provider.reFetchData(),
          goToEditScreen: null,
          screenTitle: StringsManager.termsOfUse,
          dataState: provider.dataState,
          child: provider.dataState != DataState.done ? const SizedBox() : Text(
            MyProviders.appProvider.isEnglish ? provider.termsOfUseModel.textEn : provider.termsOfUseModel.textAr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    termsOfUseProvider.setIsScreenDisposed(true);
  }
}