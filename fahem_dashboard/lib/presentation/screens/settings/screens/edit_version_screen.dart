import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/version_model.dart';
import 'package:fahem_dashboard/domain/usecases/version/edit_version_usecase.dart';
import 'package:fahem_dashboard/presentation/screens/settings/controllers/version_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';

class EditVersionScreen extends StatefulWidget {
  final VersionModel versionModel;
  final App app;

  const EditVersionScreen({
    super.key,
    required this.versionModel,
    required this.app,
  });

  @override
  State<EditVersionScreen> createState() => _EditVersionScreenState();
}

class _EditVersionScreenState extends State<EditVersionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerVersion = TextEditingController();
  late bool _isForceUpdate;
  late bool _isClearCache;
  late bool _isMaintenanceNow;
  late bool _inReview;

  @override
  void initState() {
    super.initState();
    _textEditingControllerVersion.text = widget.versionModel.version;
    _isForceUpdate = widget.versionModel.isForceUpdate;
    _isClearCache = widget.versionModel.isClearCache;
    _isMaintenanceNow = widget.versionModel.isMaintenanceNow;
    _inReview = widget.versionModel.inReview;
  }

  String _getScreenTitle() {
    switch(widget.app) {
      case App.fahem: return StringsManager.editFahemVersionApp;
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VersionProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: _getScreenTitle()),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Version *
                          CustomTextFormField(
                            controller: _textEditingControllerVersion,
                            keyboardType: TextInputType.number,
                            labelText: '${Methods.getText(StringsManager.versionApp).toTitleCase()} *',
                            prefixIconData: Icons.phone_android,
                            validator: Validator.validateVersion,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Is Force Update *
                          CustomDropdownButtonFormField(
                            currentValue: _isForceUpdate,
                            valuesText: [Methods.getText(StringsManager.yes).toTitleCase(), Methods.getText(StringsManager.no).toTitleCase()],
                            valuesObject: const [true, false],
                            onChanged: (value) => setState(() => _isForceUpdate = value as bool),
                            labelText: '${Methods.getText(StringsManager.forceUpdate).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.gear,
                            validator: Validator.validateEmptyDropdown,
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Is Clear Cache *
                          CustomDropdownButtonFormField(
                            currentValue: _isClearCache,
                            valuesText: [Methods.getText(StringsManager.yes).toTitleCase(), Methods.getText(StringsManager.no).toTitleCase()],
                            valuesObject: const [true, false],
                            onChanged: (value) => setState(() => _isClearCache = value as bool),
                            labelText: '${Methods.getText(StringsManager.deleteCache).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.gear,
                            validator: Validator.validateEmptyDropdown,
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Is Maintenance Now *
                          CustomDropdownButtonFormField(
                            currentValue: _isMaintenanceNow,
                            valuesText: [Methods.getText(StringsManager.yes).toTitleCase(), Methods.getText(StringsManager.no).toTitleCase()],
                            valuesObject: const [true, false],
                            onChanged: (value) => setState(() => _isMaintenanceNow = value as bool),
                            labelText: '${Methods.getText(StringsManager.appUnderMaintenance).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.gear,
                            validator: Validator.validateEmptyDropdown,
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // In Review *
                          CustomDropdownButtonFormField(
                            currentValue: _inReview,
                            valuesText: [Methods.getText(StringsManager.yes).toTitleCase(), Methods.getText(StringsManager.no).toTitleCase()],
                            valuesObject: const [true, false],
                            onChanged: (value) => setState(() => _inReview = value as bool),
                            labelText: '${Methods.getText(StringsManager.appInReview).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.gear,
                            validator: Validator.validateEmptyDropdown,
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate()) {
                                EditVersionParameters editVersionParameters = EditVersionParameters(
                                  app: widget.app,
                                  version: _textEditingControllerVersion.text,
                                  isForceUpdate: _isForceUpdate,
                                  isClearCache: _isClearCache,
                                  isMaintenanceNow: _isMaintenanceNow,
                                  inReview: _inReview,
                                );
                                provider.editVersion(context: context, parameters: editVersionParameters);
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: FontAwesomeIcons.penToSquare,
                            text: Methods.getText(StringsManager.edit).toTitleCase(),
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
    super.dispose();
    _textEditingControllerVersion.dispose();
  }
}