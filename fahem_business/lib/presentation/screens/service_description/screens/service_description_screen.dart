import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/service_description_model.dart';
import 'package:fahem_business/presentation/screens/service_description/controllers/service_description_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/template_item_screen.dart';

class ServiceDescriptionScreen extends StatefulWidget {
  const ServiceDescriptionScreen({super.key});

  @override
  State<ServiceDescriptionScreen> createState() => _ServiceDescriptionScreenState();
}

class _ServiceDescriptionScreenState extends State<ServiceDescriptionScreen> {
  late ServiceDescriptionProvider serviceDescriptionProvider;
  
  @override
  void initState() {
    super.initState();
    serviceDescriptionProvider = Provider.of<ServiceDescriptionProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async => await serviceDescriptionProvider.fetchData());
  }

  void _onEdit(ServiceDescriptionModel? serviceDescription) {
    if(serviceDescription != null) {
      serviceDescriptionProvider.editServiceDescription(serviceDescription);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceDescriptionProvider>(
      builder: (context, provider, _) {
        return TemplateItemScreen(
          isShowLoading: provider.dataState == DataState.loading,
          reFetchData: () async => await provider.reFetchData(),
          goToEditScreen: null,
          screenTitle: StringsManager.serviceDescription,
          dataState: provider.dataState,
          child: provider.dataState != DataState.done ? const SizedBox() : Text(
            MyProviders.appProvider.isEnglish ? provider.serviceDescriptionModel.textEn : provider.serviceDescriptionModel.textAr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    serviceDescriptionProvider.setIsScreenDisposed(true);
  }
}