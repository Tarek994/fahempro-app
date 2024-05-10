import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/privacy_policy_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/screens/privacy_policy/controllers/privacy_policy_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_item_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late PrivacyPolicyProvider privacyPolicyProvider;

  @override
  void initState() {
    super.initState();
    privacyPolicyProvider = Provider.of<PrivacyPolicyProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async => await privacyPolicyProvider.fetchData());
  }

  void _onEdit(PrivacyPolicyModel? privacyPolicy) {
    if(privacyPolicy != null) {
      privacyPolicyProvider.editPrivacyPolicy(privacyPolicy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrivacyPolicyProvider>(
      builder: (context, provider, _) {
        return TemplateItemScreen(
          isShowLoading: provider.dataState == DataState.loading,
          reFetchData: () async => await provider.reFetchData(),
          goToEditScreen: Methods.checkAdminPermission(AdminPermissions.editPrivacyPolicy) ? () {
            Methods.routeTo(context, Routes.editPrivacyPolicyScreen, arguments: provider.privacyPolicyModel, then: (privacyPolicy) => _onEdit(privacyPolicy));
          } : null,
          screenTitle: StringsManager.privacyPolicy,
          dataState: provider.dataState,
          child: provider.dataState != DataState.done ? const SizedBox() : Text(
            MyProviders.appProvider.isEnglish ? provider.privacyPolicyModel.textEn : provider.privacyPolicyModel.textAr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    privacyPolicyProvider.setIsScreenDisposed(true);
  }
}