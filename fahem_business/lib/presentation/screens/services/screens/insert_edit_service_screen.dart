import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/screens/services/controllers/insert_edit_service_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_business/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/service_model.dart';
import 'package:fahem_business/domain/usecases/services/edit_service_usecase.dart';
import 'package:fahem_business/domain/usecases/services/insert_service_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditServiceScreen extends StatefulWidget {
  final ServiceModel? serviceModel;

  const InsertEditServiceScreen({
    super.key,
    this.serviceModel,
  });

  @override
  State<InsertEditServiceScreen> createState() => _InsertEditServiceScreenState();
}

class _InsertEditServiceScreenState extends State<InsertEditServiceScreen> {
  late InsertEditServiceProvider insertEditServiceProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameArController = TextEditingController();
  final TextEditingController _nameEnController = TextEditingController();
  final TextEditingController _serviceInfoArController = TextEditingController();
  final TextEditingController _serviceInfoEnController = TextEditingController();
  final TextEditingController _customOrderController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    insertEditServiceProvider = Provider.of<InsertEditServiceProvider>(context, listen: false);

    if(widget.serviceModel != null) {
      _nameArController.text = widget.serviceModel!.nameAr;
      _nameEnController.text = widget.serviceModel!.nameEn;
      _serviceInfoArController.text = widget.serviceModel!.serviceInfoAr;
      _serviceInfoEnController.text = widget.serviceModel!.serviceInfoEn;
      _customOrderController.text = widget.serviceModel!.customOrder.toString();
      insertEditServiceProvider.setServiceImage(widget.serviceModel!.serviceImage);
      insertEditServiceProvider.setAdditionalImage(widget.serviceModel!.additionalImage);
      insertEditServiceProvider.setMainCategory(widget.serviceModel!.mainCategory);
      insertEditServiceProvider.setAvailableForAccount(widget.serviceModel!.availableForAccount);
      insertEditServiceProvider.setServiceProviderCanSubscribe(widget.serviceModel!.serviceProviderCanSubscribe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditServiceProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.serviceModel == null ? StringsManager.addService : StringsManager.editService,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Service Image *
                          SizedBox(
                            width: SizeManager.s120,
                            height: SizeManager.s120,
                            child: Stack(
                              children: [
                                Container(
                                  width: SizeManager.s120,
                                  height: SizeManager.s120,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.grey100,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorsManager.white, width: SizeManager.s5),
                                  ),
                                  child: ImageTypeWidget(
                                    image: provider.serviceImage,
                                    imageDirectory: ApiConstants.servicesDirectory,
                                    title: StringsManager.serviceImage,
                                    imageFileBorderRadius: SizeManager.s100,
                                    imageNetworkWidth: SizeManager.s50,
                                    imageNetworkHeight: SizeManager.s50,
                                    imageNetworkBoxShape: BoxShape.circle,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CustomButton(
                                    buttonType: ButtonType.icon,
                                    onPressed: () async {
                                      if(provider.serviceImage == null) {
                                        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if(xFile != null) insertEditServiceProvider.changeServiceImage(xFile);
                                      }
                                      else {
                                        insertEditServiceProvider.changeServiceImage(null);
                                      }
                                    },
                                    isCircleBorder: true,
                                    iconData: provider.serviceImage == null ? Icons.image : Icons.clear,
                                    buttonColor: provider.serviceImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                    iconSize: SizeManager.s20,
                                    width: SizeManager.s35,
                                    height: SizeManager.s35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Additional Image *
                          SizedBox(
                            width: SizeManager.s120,
                            height: SizeManager.s120,
                            child: Stack(
                              children: [
                                Container(
                                  width: SizeManager.s120,
                                  height: SizeManager.s120,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.grey100,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: ColorsManager.white, width: SizeManager.s5),
                                  ),
                                  child: ImageTypeWidget(
                                    image: provider.additionalImage,
                                    imageDirectory: ApiConstants.servicesDirectory,
                                    title: StringsManager.additionalImage,
                                    imageFileBorderRadius: SizeManager.s100,
                                    imageNetworkWidth: SizeManager.s50,
                                    imageNetworkHeight: SizeManager.s50,
                                    imageNetworkBoxShape: BoxShape.circle,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CustomButton(
                                    buttonType: ButtonType.icon,
                                    onPressed: () async {
                                      if(provider.additionalImage == null) {
                                        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if(xFile != null) insertEditServiceProvider.changeAdditionalImage(xFile);
                                      }
                                      else {
                                        insertEditServiceProvider.changeAdditionalImage(null);
                                      }
                                    },
                                    isCircleBorder: true,
                                    iconData: provider.additionalImage == null ? Icons.image : Icons.clear,
                                    buttonColor: provider.additionalImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                    iconSize: SizeManager.s20,
                                    width: SizeManager.s35,
                                    height: SizeManager.s35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Main Category *
                          CustomButton(
                            onPressed: () {
                              Dialogs.mainCategoriesBottomSheet(context: context).then((mainCategory) {
                                if(mainCategory != null) {
                                  provider.changeMainCategory(mainCategory);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.mainCategory == null
                                ? '${Methods.getText(StringsManager.chooseMainCategory).toCapitalized()} *'
                                : (MyProviders.appProvider.isEnglish ? provider.mainCategory!.nameEn : provider.mainCategory!.nameAr),
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.mainCategory == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.mainCategory == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Name Ar *
                          CustomTextFormField(
                            controller: _nameArController,
                            labelText: '${Methods.getText(StringsManager.name).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Service En *
                          CustomTextFormField(
                            controller: _nameEnController,
                            labelText: '${Methods.getText(StringsManager.name).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Service Info Ar *
                          CustomTextFormField(
                            controller: _serviceInfoArController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 10,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.serviceInfo).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Service Info En *
                          CustomTextFormField(
                            controller: _serviceInfoEnController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 10,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.serviceInfo).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // availableForAccount *
                          Material(
                            color: Colors.transparent,
                            child: CheckboxListTile(
                              value: provider.availableForAccount,
                              onChanged: (value) => provider.changeAvailableForAccount(value!),
                              title: Text(
                                Methods.getText(StringsManager.availableForAccount).toTitleCase(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              tileColor: ColorsManager.white,
                              activeColor: ColorsManager.lightPrimaryColor,
                              checkColor: ColorsManager.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(SizeManager.s10),
                                side: const BorderSide(color: ColorsManager.grey300),
                              ),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // serviceProviderCanSubscribe *
                          Material(
                            color: Colors.transparent,
                            child: CheckboxListTile(
                              value: provider.serviceProviderCanSubscribe,
                              onChanged: (value) => provider.changeServiceProviderCanSubscribe(value!),
                              title: Text(
                                Methods.getText(StringsManager.theServiceProviderCanSubscribeToThisServiceHimself).toTitleCase(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              tileColor: ColorsManager.white,
                              activeColor: ColorsManager.lightPrimaryColor,
                              checkColor: ColorsManager.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(SizeManager.s10),
                                side: const BorderSide(color: ColorsManager.grey300),
                              ),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Custom Order *
                          CustomTextFormField(
                            controller: _customOrderController,
                            labelText: '${Methods.getText(StringsManager.customOrder).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditServiceProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.serviceModel == null) {
                                  InsertServiceParameters insertServiceParameters = InsertServiceParameters(
                                    mainCategoryId: provider.mainCategory!.mainCategoryId,
                                    nameAr: _nameArController.text.trim(),
                                    nameEn: _nameEnController.text.trim(),
                                    serviceInfoAr: _serviceInfoArController.text.trim(),
                                    serviceInfoEn: _serviceInfoEnController.text.trim(),
                                    serviceImage: '',
                                    additionalImage: '',
                                    availableForAccount: provider.availableForAccount,
                                    serviceProviderCanSubscribe: provider.serviceProviderCanSubscribe,
                                    customOrder: int.parse(_customOrderController.text.trim()),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditServiceProvider.insertService(context: context, insertServiceParameters: insertServiceParameters);
                                }
                                else {
                                  EditServiceParameters editServiceParameters = EditServiceParameters(
                                    serviceId: widget.serviceModel!.serviceId,
                                    mainCategoryId: provider.mainCategory!.mainCategoryId,
                                    nameAr: _nameArController.text.trim(),
                                    nameEn: _nameEnController.text.trim(),
                                    serviceInfoAr: _serviceInfoArController.text.trim(),
                                    serviceInfoEn: _serviceInfoEnController.text.trim(),
                                    serviceImage: provider.serviceImage is String ? provider.serviceImage : '',
                                    additionalImage: provider.additionalImage is String ? provider.additionalImage : '',
                                    availableForAccount: provider.availableForAccount,
                                    serviceProviderCanSubscribe: provider.serviceProviderCanSubscribe,
                                    customOrder: int.parse(_customOrderController.text.trim()),
                                  );
                                  insertEditServiceProvider.editService(context: context, editServiceParameters: editServiceParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.serviceModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.serviceModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _nameArController.dispose();
    _nameEnController.dispose();
    _serviceInfoArController.dispose();
    _serviceInfoEnController.dispose();
    _customOrderController.dispose();
    super.dispose();
  }
}