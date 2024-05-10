import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/data_source/static/countries_data.dart';
import 'package:fahem_business/data/models/static/country_model.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

CountryModel? selectedCountryInBtmSheet;

class CountriesBtmSheet extends StatefulWidget {
  final bool showDialingCode;

  const CountriesBtmSheet({
    super.key,
    required this.showDialingCode,
  });

  @override
  State<CountriesBtmSheet> createState() => _CountriesBtmSheetState();
}

class _CountriesBtmSheetState extends State<CountriesBtmSheet> {
  final TextEditingController _textEditingControllerSearch = TextEditingController();
  List<CountryModel> countries = countriesData;

  @override
  void initState() {
    super.initState();
    selectedCountryInBtmSheet = null;
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
            hintText: Methods.getText(StringsManager.searchWithCountryCode).toCapitalized(),
            prefixIconData: Icons.search,
            onClickClearIcon: () => setState(() => countries = countriesData),
            onChanged: (val) {
              setState(() {
                countries = countriesData.where((element) => element.countryNameAr.contains(val) ||
                    element.countryNameEn.toLowerCase().contains(val.toLowerCase()) ||
                    element.countryCode.toLowerCase().contains(val.toLowerCase()) ||
                    element.dialingCode.contains(val)
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
                    selectedCountryInBtmSheet = countries[index];
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(SizeManager.s5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8),
                          child: Image.asset(countries[index].flag, width: SizeManager.s30, height: SizeManager.s30),
                        ),
                        const SizedBox(width: SizeManager.s20),
                        Expanded(
                          child: Text(
                            MyProviders.appProvider.isEnglish ? countries[index].countryNameEn : countries[index].countryNameAr,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        if(widget.showDialingCode) ...[
                          const SizedBox(width: SizeManager.s20),
                          Text(
                            countries[index].dialingCode,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              itemCount: countries.length,
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
