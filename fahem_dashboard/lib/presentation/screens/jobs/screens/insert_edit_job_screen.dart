import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/presentation/screens/jobs/controllers/insert_edit_job_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/job_model.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/edit_job_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/insert_job_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditJobScreen extends StatefulWidget {
  final JobModel? jobModel;

  const InsertEditJobScreen({
    super.key,
    this.jobModel,
  });

  @override
  State<InsertEditJobScreen> createState() => _InsertEditJobScreenState();
}

class _InsertEditJobScreenState extends State<InsertEditJobScreen> {
  late InsertEditJobProvider insertEditJobProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _aboutCompanyController = TextEditingController();
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();
  final TextEditingController _jobLocationController = TextEditingController();
  final TextEditingController _featureController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _reasonOfRejectController = TextEditingController();
  JobStatus? _jobStatus;

  @override
  void initState() {
    super.initState();
    insertEditJobProvider = Provider.of<InsertEditJobProvider>(context, listen: false);

    if(widget.jobModel != null) {
      _jobTitleController.text = widget.jobModel!.jobTitle;
      _companyNameController.text = widget.jobModel!.companyName;
      _aboutCompanyController.text = widget.jobModel!.aboutCompany;
      _minSalaryController.text = widget.jobModel!.minSalary.toString();
      _maxSalaryController.text = widget.jobModel!.maxSalary.toString();
      _jobLocationController.text = widget.jobModel!.jobLocation;
      _detailsController.text = widget.jobModel!.details;
      _reasonOfRejectController.text = widget.jobModel!.reasonOfReject ?? '';
      _jobStatus = widget.jobModel!.jobStatus;
      insertEditJobProvider.setAccount(widget.jobModel!.account);
      insertEditJobProvider.setJobImage(widget.jobModel!.image);
      insertEditJobProvider.setIsAvailable(widget.jobModel!.isAvailable);
      insertEditJobProvider.setFeatures(widget.jobModel!.features);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditJobProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.jobModel == null ? StringsManager.addJob : StringsManager.editJob,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Job Image *
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
                                    image: provider.jobImage,
                                    imageDirectory: ApiConstants.jobsDirectory,
                                    title: StringsManager.jobImage,
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
                                      if(provider.jobImage == null) {
                                        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if(xFile != null) insertEditJobProvider.changeJobImage(xFile);
                                      }
                                      else {
                                        insertEditJobProvider.changeJobImage(null);
                                      }
                                    },
                                    isCircleBorder: true,
                                    iconData: provider.jobImage == null ? Icons.image : Icons.clear,
                                    buttonColor: provider.jobImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                    iconSize: SizeManager.s20,
                                    width: SizeManager.s35,
                                    height: SizeManager.s35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s40),

                          // Account *
                          CustomButton(
                            onPressed: () {
                              Dialogs.accountsBottomSheet(context: context).then((account) {
                                if(account != null) {
                                  insertEditJobProvider.changeAccount(account);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.account == null ? Methods.getText(StringsManager.chooseAccount).toCapitalized() : provider.account!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.account == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.account == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Job Title *
                          CustomTextFormField(
                            controller: _jobTitleController,
                            labelText: '${Methods.getText(StringsManager.jobTitle).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.briefcase,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Company Name *
                          CustomTextFormField(
                            controller: _companyNameController,
                            labelText: '${Methods.getText(StringsManager.companyName).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.building,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // About Company *
                          CustomTextFormField(
                            controller: _aboutCompanyController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.aboutCompany).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Min Salary *
                          CustomTextFormField(
                            controller: _minSalaryController,
                            keyboardType: TextInputType.number,
                            labelText: '${Methods.getText(StringsManager.minimumSalary).toTitleCase()} (${Methods.getText(StringsManager.egyptianPound).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.coins,
                            validator: Validator.validateIntegerNumber,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Max Salary *
                          CustomTextFormField(
                            controller: _maxSalaryController,
                            keyboardType: TextInputType.number,
                            labelText: '${Methods.getText(StringsManager.maximumSalary).toTitleCase()} (${Methods.getText(StringsManager.egyptianPound).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.coins,
                            validator: Validator.validateIntegerNumber,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Job Location *
                          CustomTextFormField(
                            controller: _jobLocationController,
                            labelText: '${Methods.getText(StringsManager.jobLocation).toTitleCase()} *',
                            prefixIconData: Icons.location_on,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Features *
                          Container(
                            padding: const EdgeInsets.all(SizeManager.s10),
                            decoration: BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.circular(SizeManager.s10),
                              border: Border.all(color: ColorsManager.grey300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  controller: _featureController,
                                  labelText: '${Methods.getText(StringsManager.features).toCapitalized()} *',
                                  prefixIconData: Icons.task_alt,
                                  fillColor: ColorsManager.grey100,
                                  suffixIcon: CustomButton(
                                    onPressed: () async {
                                      insertEditJobProvider.addInFeatures(_featureController.text.trim());
                                      _featureController.clear();
                                    },
                                    buttonColor: Colors.transparent,
                                    textColor: ColorsManager.lightPrimaryColor,
                                    buttonType: ButtonType.text,
                                    text: Methods.getText(StringsManager.add).toCapitalized(),
                                  ),
                                  isSupportClearSuffixIcon: false,
                                  validator: (value) {
                                    if(insertEditJobProvider.features.isEmpty) {
                                      return Methods.getText(StringsManager.required).toCapitalized();
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: SizeManager.s10),
                                Wrap(
                                  spacing: SizeManager.s5,
                                  runSpacing: SizeManager.s10,
                                  children: List.generate(insertEditJobProvider.features.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        insertEditJobProvider.removeFromFeatures(insertEditJobProvider.features[index]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(SizeManager.s5),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.lightPrimaryColor,
                                          border: Border.all(color: ColorsManager.lightPrimaryColor),
                                          borderRadius: BorderRadius.circular(SizeManager.s5),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              insertEditJobProvider.features[index],
                                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsManager.white),
                                            ),
                                            const SizedBox(width: SizeManager.s10),
                                            const Icon(Icons.clear, size: SizeManager.s14, color: ColorsManager.white),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Details *
                          CustomTextFormField(
                            controller: _detailsController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.details).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Job Status *
                          CustomDropdownButtonFormField(
                            currentValue: _jobStatus,
                            valuesText: List.generate(JobStatus.values.length, (index) => JobStatus.toText(JobStatus.values[index])),
                            valuesObject: JobStatus.values,
                            onChanged: (value) => setState(() => _jobStatus = value as JobStatus),
                            labelText: '${Methods.getText(StringsManager.jobStatus).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.gear,
                            suffixIcon: _jobStatus == null ? const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ) : Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() => _jobStatus = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Reason Of Reject *
                          if(_jobStatus == JobStatus.rejected) ...[
                            CustomTextFormField(
                              controller: _reasonOfRejectController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 2,
                              borderRadius: SizeManager.s10,
                              labelText: '${Methods.getText(StringsManager.reasonOfReject).toTitleCase()} *',
                              validator: Validator.validateEmpty,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          // Is Available *
                          Material(
                            color: Colors.transparent,
                            child: CheckboxListTile(
                              value: provider.isAvailable,
                              onChanged: (value) => provider.changeIsAvailable(value!),
                              title: Text(
                                Methods.getText(StringsManager.jobIsAvailable).toTitleCase(),
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
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditJobProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.jobModel == null) {
                                  InsertJobParameters insertJobParameters = InsertJobParameters(
                                    accountId: provider.account!.accountId,
                                    image: '',
                                    jobTitle: _jobTitleController.text.trim(),
                                    companyName: _companyNameController.text.trim(),
                                    aboutCompany: _aboutCompanyController.text.trim(),
                                    minSalary: int.parse(_minSalaryController.text.trim()),
                                    maxSalary: int.parse(_maxSalaryController.text.trim()),
                                    jobLocation: _jobLocationController.text.trim(),
                                    features: insertEditJobProvider.features,
                                    details: _detailsController.text.trim(),
                                    jobStatus: _jobStatus!,
                                    reasonOfReject: _jobStatus == JobStatus.rejected ? _reasonOfRejectController.text.trim() : null,
                                    isAvailable: insertEditJobProvider.isAvailable,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditJobProvider.insertJob(context: context, insertJobParameters: insertJobParameters);
                                }
                                else {
                                  EditJobParameters editJobParameters = EditJobParameters(
                                    jobId: widget.jobModel!.jobId,
                                    accountId: provider.account!.accountId,
                                    image: insertEditJobProvider.jobImage is String ? insertEditJobProvider.jobImage : '',
                                    jobTitle: _jobTitleController.text.trim(),
                                    companyName: _companyNameController.text.trim(),
                                    aboutCompany: _aboutCompanyController.text.trim(),
                                    minSalary: int.parse(_minSalaryController.text.trim()),
                                    maxSalary: int.parse(_maxSalaryController.text.trim()),
                                    jobLocation: _jobLocationController.text.trim(),
                                    features: insertEditJobProvider.features,
                                    details: _detailsController.text.trim(),
                                    jobStatus: _jobStatus!,
                                    reasonOfReject: _jobStatus == JobStatus.rejected ? _reasonOfRejectController.text.trim() : null,
                                    isAvailable: insertEditJobProvider.isAvailable,
                                  );
                                  insertEditJobProvider.editJob(context: context, editJobParameters: editJobParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.jobModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.jobModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _jobTitleController.dispose();
    _companyNameController.dispose();
    _aboutCompanyController.dispose();
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    _jobLocationController.dispose();
    _featureController.dispose();
    _detailsController.dispose();
    _reasonOfRejectController.dispose();
    super.dispose();
  }
}