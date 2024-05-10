import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/slider_model.dart';
import 'package:fahem/domain/usecases/sliders/edit_slider_usecase.dart';
import 'package:fahem/domain/usecases/sliders/insert_slider_usecase.dart';
import 'package:fahem/presentation/screens/sliders/controllers/insert_edit_slider_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class InsertEditSliderScreen extends StatefulWidget {
  final SliderModel? sliderModel;

  const InsertEditSliderScreen({
    super.key,
    this.sliderModel,
  });

  @override
  State<InsertEditSliderScreen> createState() => _InsertEditSliderScreenState();
}

class _InsertEditSliderScreenState extends State<InsertEditSliderScreen> {
  late InsertEditSliderProvider insertEditSliderProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _valueController = TextEditingController();
  SliderTarget? _sliderTarget;

  @override
  void initState() {
    super.initState();
    insertEditSliderProvider = Provider.of<InsertEditSliderProvider>(context, listen: false);

    if(widget.sliderModel != null) {
      insertEditSliderProvider.setSliderImage(widget.sliderModel!.image);
      _sliderTarget = widget.sliderModel!.sliderTarget;
      _valueController.text = widget.sliderModel!.value ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditSliderProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.sliderModel == null ? StringsManager.addSlider : StringsManager.editSlider),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Slider Image *
                          SizedBox(
                            width: double.infinity,
                            height: SizeManager.s200,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: SizeManager.s200,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.white,
                                    borderRadius: BorderRadius.circular(SizeManager.s10),
                                    border: Border.all(color: ColorsManager.grey300),
                                  ),
                                  child: ImageTypeWidget(
                                    image: provider.sliderImage,
                                    imageDirectory: ApiConstants.slidersDirectory,
                                    title: StringsManager.sliderImage,
                                    imageFileBorderRadius: SizeManager.s10,
                                    imageNetworkWidth: double.infinity,
                                    imageNetworkHeight: SizeManager.s200,
                                    imageNetworkBorderRadius: SizeManager.s10,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5, vertical: SizeManager.s10),
                                    child: CustomButton(
                                      buttonType: ButtonType.icon,
                                      onPressed: () async {
                                        if(provider.sliderImage == null) {
                                          XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(xFile != null) insertEditSliderProvider.changeSliderImage(xFile);
                                        }
                                        else {
                                          insertEditSliderProvider.changeSliderImage(null);
                                        }
                                      },
                                      isCircleBorder: true,
                                      iconData: provider.sliderImage == null ? Icons.image : Icons.clear,
                                      buttonColor: provider.sliderImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                      iconSize: SizeManager.s20,
                                      width: SizeManager.s35,
                                      height: SizeManager.s35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // SliderTarget *
                          CustomDropdownButtonFormField(
                            currentValue: _sliderTarget,
                            valuesText: List.generate(SliderTarget.values.length, (index) => SliderTarget.toText(SliderTarget.values[index])),
                            valuesObject: SliderTarget.values,
                            onChanged: (value) => setState(() => _sliderTarget = value as SliderTarget),
                            labelText: '${Methods.getText(StringsManager.type).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.venusMars,
                            suffixIcon: _sliderTarget == null ? const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.lightPrimaryColor,
                            ) : Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() => _sliderTarget = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.lightPrimaryColor),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Value
                          // if(_sliderTarget != null && _sliderTarget! == SliderTarget.jobDetails) ...[
                          //   CustomTextFormField(
                          //     controller: _valueController,
                          //     keyboardType: TextInputType.number,
                          //     labelText: '${Methods.getText(StringsManager.jobId).toTitleCase()} *',
                          //     validator: Validator.validateIntegerNumberNotAllowZero,
                          //   ),
                          //   const SizedBox(height: SizeManager.s20),
                          // ],
                          if(_sliderTarget != null && _sliderTarget! == SliderTarget.externalLink) ...[
                            CustomTextFormField(
                              controller: _valueController,
                              keyboardType: TextInputType.url,
                              labelText: '${Methods.getText(StringsManager.link).toTitleCase()} *',
                              prefixIconData: Icons.link,
                              validator: Validator.validateLink,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],
                          if(_sliderTarget != null && _sliderTarget! == SliderTarget.whatsapp) ...[
                            CustomTextFormField(
                              controller: _valueController,
                              keyboardType: TextInputType.phone,
                              // labelText: '${Methods.getText(StringsManager.dialingCodeAndPhoneNumberWithoutSpace).toTitleCase()} *',
                              labelText: '${Methods.getText(StringsManager.phoneNumber).toTitleCase()} *',
                              // hintText: '+201234567890',
                              prefixIconData: FontAwesomeIcons.whatsapp,
                              validator: Validator.validatePhoneNumber,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate() && insertEditSliderProvider.isAllDataValid()) {
                                if(widget.sliderModel == null) {
                                  InsertSliderParameters insertSliderParameters = InsertSliderParameters(
                                    image: '',
                                    sliderTarget: _sliderTarget!,
                                    value: _sliderTarget! == SliderTarget.openImage
                                        ? null
                                        : _valueController.text.trim().isEmpty ? null : _valueController.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditSliderProvider.insertSlider(context: context, insertSliderParameters: insertSliderParameters);
                                }
                                else {
                                  EditSliderParameters editSliderParameters = EditSliderParameters(
                                    sliderId: widget.sliderModel!.sliderId,
                                    image: insertEditSliderProvider.sliderImage is String ? insertEditSliderProvider.sliderImage : '',
                                    sliderTarget: _sliderTarget!,
                                    value: _sliderTarget! == SliderTarget.openImage
                                        ? null
                                        : _valueController.text.trim().isEmpty ? null : _valueController.text.trim(),
                                  );
                                  insertEditSliderProvider.editSlider(context: context, editSliderParameters: editSliderParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: widget.sliderModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.sliderModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }
}