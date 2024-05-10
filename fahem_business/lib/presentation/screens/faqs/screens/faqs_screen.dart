import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/faq_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/faqs/controllers/faqs_provider.dart';
import 'package:fahem_business/presentation/screens/faqs/widgets/faq_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  late FaqsProvider faqsProvider;

  @override
  void initState() {
    super.initState();
    faqsProvider = Provider.of<FaqsProvider>(context, listen: false);
    faqsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await faqsProvider.fetchData());
  }

  void _onInsert(FaqModel? faq) {
    if(faq != null) {
      faqsProvider.insertInFaqs(faq);
      if(faqsProvider.paginationModel != null) faqsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(FaqModel? faq) {
    if(faq != null) {
      faqsProvider.editInFaqs(faq);
    }
  }

  void _onDelete(int faqId) {
    faqsProvider.deleteFaq(context: context, faqId: faqId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addFaq) ? () {
            Methods.routeTo(context, Routes.insertEditFaqScreen, arguments: null, then: (faq) => _onInsert(faq));
          } : null,
          screenTitle: StringsManager.faqs,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByQuestion,
            ordersItems: const [OrderByType.faqsNewestFirst, OrderByType.faqsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.faqs.isNotEmpty,
          dataCount: provider.faqs.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => FaqListItem(faqModel: provider.faqs[index], onEdit: (faq) => _onEdit(faq), onDelete: () => _onDelete(provider.faqs[index].faqId)),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoFaqs,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    faqsProvider.setIsScreenDisposed(true);
    faqsProvider.scrollController.dispose();
  }
}