import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/shared/widgets/my_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/services/controllers/services_provider.dart';
import 'package:fahem/presentation/screens/services/widgets/service_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ServicesProvider servicesProvider;

  @override
  void initState() {
    super.initState();
    servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    servicesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await servicesProvider.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          isSupportAppBar: false,
          isShowBackground: true,
          scaffoldColor: ColorsManager.white,
          goToInsertScreen: null,
          screenTitle: StringsManager.services,
          searchFilterOrderWidget: null,
          isDataNotEmpty: provider.services.isNotEmpty,
          dataCount: provider.services.length,
          totalResults: null,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => ServiceListItem(
            serviceModel: provider.services[index],
            index: index,
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoServices,
          flexibleSliverAppBar: SliverAppBar(
            pinned: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.transparent,
            leading: const MyBackButton(),
            expandedHeight: SizeManager.s300,
            collapsedHeight: SizeManager.s100,
            flexibleSpace: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  ImagesManager.fahemServices,
                  width: double.infinity,
                  height: SizeManager.s350,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: SizeManager.s350,
                  color: ColorsManager.black.withOpacity(0.5),
                ),
                Container(
                  height: SizeManager.s20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeManager.s20),
                      topRight: Radius.circular(SizeManager.s20),
                    ),
                    image: DecorationImage(
                      image: AssetImage(ImagesManager.backgroundScreen),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          extraWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Methods.getText(StringsManager.fahemServices),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s24, fontWeight: FontWeightManager.black),
                ),
                const SizedBox(height: SizeManager.s5),
                Text(
                  Methods.getText(StringsManager.fahemServicesDescription),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    servicesProvider.setIsScreenDisposed(true);
    servicesProvider.scrollController.dispose();
  }
}