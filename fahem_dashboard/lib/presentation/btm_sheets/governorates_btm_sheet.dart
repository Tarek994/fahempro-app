import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/data_source/static/governorates_data.dart';
import 'package:fahem_dashboard/data/models/static/governorate_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

GovernorateModel? selectedGovernorateInBtmSheet;

class GovernoratesBtmSheet extends StatefulWidget {

  const GovernoratesBtmSheet({super.key});

  @override
  State<GovernoratesBtmSheet> createState() => _GovernoratesBtmSheetState();
}

class _GovernoratesBtmSheetState extends State<GovernoratesBtmSheet> {
  final TextEditingController _textEditingControllerSearch = TextEditingController();
  List<GovernorateModel> governorates = governoratesData;

  @override
  void initState() {
    super.initState();
    selectedGovernorateInBtmSheet = null;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.75,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _textEditingControllerSearch,
            textInputAction: TextInputAction.search,
            borderColor: ColorsManager.grey,
            hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
            prefixIconData: Icons.search,
            onClickClearIcon: () => setState(() => governorates = governoratesData),
            onChanged: (val) {
              setState(() {
                governorates = governoratesData.where((element) => element.governorateNameAr.contains(val) ||
                    element.governorateNameEn.toLowerCase().contains(val.toLowerCase())
                ).toList();
              });
            },
          ),
          const SizedBox(height: SizeManager.s10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    selectedGovernorateInBtmSheet = governorates[index];
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5, vertical: SizeManager.s15),
                    child: Text(
                      MyProviders.appProvider.isEnglish ? governorates[index].governorateNameEn : governorates[index].governorateNameAr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              },
              itemCount: governorates.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingControllerSearch.dispose();
  }
}
