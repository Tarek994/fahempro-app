import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/domain/usecases/employment_applications/insert_employment_application_usecase.dart';
import 'package:fahem/presentation/screens/jobs/controllers/job_apply_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobApplyScreen extends StatefulWidget {
  final JobModel jobModel;

  const JobApplyScreen({
    super.key,
    required this.jobModel,
  });

  @override
  State<JobApplyScreen> createState() => _JobApplyScreenState();
}

class _JobApplyScreenState extends State<JobApplyScreen> {
  late JobApplyProvider jobApplyProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerName = TextEditingController();
  final TextEditingController _textEditingControllerPhoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    jobApplyProvider = Provider.of<JobApplyProvider>(context, listen: false);
    _textEditingControllerName.text = MyProviders.authenticationProvider.currentUser!.fullName;
    _textEditingControllerPhoneNumber.text = MyProviders.authenticationProvider.currentUser!.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JobApplyProvider>(
        builder: (context, jobApplyProvider, _) {
          return CustomFullLoading(
            isShowLoading: jobApplyProvider.isLoading,
            waitForDone: jobApplyProvider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.apply2),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ImageWidget(
                              image: widget.jobModel.image,
                              imageDirectory: ApiConstants.jobsDirectory,
                              width: SizeManager.s100,
                              height: SizeManager.s100,
                              boxShape: BoxShape.circle,
                              isShowFullImageScreen: true,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                          Center(
                            child: Text(
                              widget.jobModel.jobTitle,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.black),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s5),
                          Center(
                            child: Text(
                              widget.jobModel.companyName,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                          Center(
                            child: Wrap(
                              spacing: SizeManager.s5,
                              runSpacing: SizeManager.s5,
                              alignment: WrapAlignment.center,
                              children: List.generate(widget.jobModel.features.length, (index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: SizeManager.s1, horizontal: SizeManager.s10),
                                  decoration: BoxDecoration(
                                    color: ColorsManager.white,
                                    borderRadius: BorderRadius.circular(SizeManager.s10),
                                    border: Border.all(color: ColorsManager.lightPrimaryColor),
                                  ),
                                  child: Text(
                                    widget.jobModel.features[index],
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      color: ColorsManager.lightPrimaryColor,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                          const Divider(color: ColorsManager.grey),
                          const SizedBox(height: SizeManager.s10),
                          Text(
                            Methods.getText(StringsManager.personalInformation).toCapitalized(),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.black),
                          ),
                          const SizedBox(height: SizeManager.s10),
                          Text(
                            Methods.getText(StringsManager.name).toCapitalized(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: SizeManager.s5),
                          CustomTextFormField(
                            enabled: false,
                            controller: _textEditingControllerName,
                            fillColor: ColorsManager.grey1,
                            borderColor: ColorsManager.grey1,
                            prefixIcon: const Icon(Icons.person_outlined, color: ColorsManager.grey),
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s10),
                          Text(
                            Methods.getText(StringsManager.phoneNumber).toCapitalized(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: SizeManager.s5),
                          CustomTextFormField(
                            enabled: false,
                            controller: _textEditingControllerPhoneNumber,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            fillColor: ColorsManager.grey1,
                            borderColor: ColorsManager.grey1,
                            prefixIcon: const Icon(Icons.phone, color: ColorsManager.grey),
                            validator: Validator.validatePhoneNumber,
                          ),
                          const SizedBox(height: SizeManager.s10),
                          Text(
                            '${Methods.getText(StringsManager.cv).toUpperCase()} *',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: SizeManager.s5),
                          Selector<JobApplyProvider, FilePickerResult?>(
                            selector: (context, provider) => provider.cvFile,
                            builder: (context, cvFile, child) {
                              return Selector<JobApplyProvider, bool>(
                                selector: (context, provider) => provider.isButtonClicked,
                                builder: (context, isButtonClicked, _) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsetsDirectional.fromSTEB(SizeManager.s0, SizeManager.s0, SizeManager.s10, SizeManager.s0),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.grey1,
                                          borderRadius: BorderRadius.circular(SizeManager.s10),
                                          border: cvFile == null && isButtonClicked ? Border.all(color: ColorsManager.red700) : null,
                                        ),
                                        height: SizeManager.s45,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorsManager.lightSecondaryColor,
                                                  borderRadius: BorderRadius.circular(SizeManager.s10),
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
                                                      if (filePickerResult != null) {jobApplyProvider.changeCvFile(filePickerResult);}
                                                    },
                                                    borderRadius: BorderRadius.circular(SizeManager.s10),
                                                    child: Center(
                                                      child: Text(
                                                        Methods.getText(StringsManager.attachAFile).toTitleCase(),
                                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  cvFile == null ? ConstantsManager.empty : cvFile.files.single.name,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      cvFile == null && isButtonClicked ? Column(
                                        children: [
                                          const SizedBox(height: SizeManager.s8),
                                          Text(
                                            Methods.getText(StringsManager.required).toCapitalized(),
                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.red700),
                                          ),
                                        ],
                                      ) : Container(),
                                    ],
                                  );
                                },
                              );
                            },
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(SizeManager.s16),
            child: CustomButton(
              buttonType: ButtonType.text,
              onPressed: () {
                FocusScope.of(context).unfocus();
                jobApplyProvider.changeIsButtonClicked(true);
                if(_formKey.currentState!.validate() && jobApplyProvider.isAllDataValid(context)) {
                  FocusScope.of(context).unfocus();
                  InsertEmploymentApplicationParameters parameters = InsertEmploymentApplicationParameters(
                    accountId: widget.jobModel.accountId,
                    userId: MyProviders.authenticationProvider.currentUser!.userId,
                    jobId: widget.jobModel.jobId,
                    cv: jobApplyProvider.cvFile!.files.single.name,
                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  );
                  jobApplyProvider.insertEmploymentApplication(
                    context: context,
                    insertEmploymentApplicationParameters: parameters,
                    // jobTitle: widget.jobModel.jobTitle
                  );
                }
              },
              text: Methods.getText(StringsManager.sendInformation).toTitleCase(),
              width: double.infinity,
              buttonColor: ColorsManager.lightSecondaryColor,
              textFontWeight: FontWeightManager.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerName.dispose();
    _textEditingControllerPhoneNumber.dispose();
    super.dispose();
  }
}