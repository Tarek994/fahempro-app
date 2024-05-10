import 'dart:io';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/constants_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/presentation/screens/instant_consultations/controllers/insert_edit_instant_consultation_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_model.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations/edit_instant_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations/insert_instant_consultation_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditInstantConsultationScreen extends StatefulWidget {
  final InstantConsultationModel? instantConsultationModel;

  const InsertEditInstantConsultationScreen({
    super.key,
    this.instantConsultationModel,
  });

  @override
  State<InsertEditInstantConsultationScreen> createState() => _InsertEditInstantConsultationScreenState();
}

class _InsertEditInstantConsultationScreenState extends State<InsertEditInstantConsultationScreen> {
  late InsertEditInstantConsultationProvider insertEditInstantConsultationProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _consultationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditInstantConsultationProvider = Provider.of<InsertEditInstantConsultationProvider>(context, listen: false);

    if(widget.instantConsultationModel != null) {
      _consultationController.text = widget.instantConsultationModel!.consultation;
      insertEditInstantConsultationProvider.setUser(widget.instantConsultationModel!.user);
      insertEditInstantConsultationProvider.setBestAccount(widget.instantConsultationModel!.bestAccount);
      insertEditInstantConsultationProvider.setIsDone(widget.instantConsultationModel!.isDone);
      insertEditInstantConsultationProvider.setImages(widget.instantConsultationModel!.images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditInstantConsultationProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.instantConsultationModel == null ? StringsManager.addInstantConsultation : StringsManager.editInstantConsultation,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // User *
                          CustomButton(
                            onPressed: () {
                              Dialogs.usersBottomSheet(context: context).then((user) {
                                if(user != null) {
                                  insertEditInstantConsultationProvider.changeUser(user);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.user == null ? Methods.getText(StringsManager.chooseUser).toCapitalized() : provider.user!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.user == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.user == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Consultation *
                          CustomTextFormField(
                            controller: _consultationController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.consultation).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // images
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8),
                                  child: Text(
                                    Methods.getText(StringsManager.attachImages).toCapitalized(),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                                  ),
                                ),
                                const SizedBox(height: SizeManager.s20),
                                SizedBox(
                                  height: SizeManager.s100,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) => const SizedBox(width: SizeManager.s10),
                                    itemBuilder: (context, index) {
                                      return index == provider.images.length ? Container(
                                        width: SizeManager.s100,
                                        height: SizeManager.s100,
                                        decoration: BoxDecoration(
                                          color: ColorsManager.grey100,
                                          borderRadius: BorderRadius.circular(SizeManager.s15),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async {
                                              XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                              if(xFile != null) provider.addInImages(xFile.path);
                                            },
                                            borderRadius: BorderRadius.circular(SizeManager.s15),
                                            child: const Icon(Icons.add, size: SizeManager.s30, color: ColorsManager.black),
                                          ),
                                        ),
                                      ) : Container(
                                        clipBehavior: Clip.antiAlias,
                                        width: SizeManager.s100,
                                        height: SizeManager.s100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(SizeManager.s15),
                                        ),
                                        child: Stack(
                                          children: [
                                            provider.images[index].startsWith(ConstantsManager.fahemDashboardImageFromFile) ? Image.file(
                                              File(provider.images[index]),
                                              width: SizeManager.s100,
                                              height: SizeManager.s100,
                                              fit: BoxFit.cover,
                                            ) : ImageWidget(
                                              image: provider.images[index],
                                              imageDirectory: ApiConstants.instantConsultationsDirectory,
                                              width: SizeManager.s100,
                                              height: SizeManager.s100,
                                              isShowFullImageScreen: true,
                                            ),
                                            PositionedDirectional(
                                              top: SizeManager.s0,
                                              start: SizeManager.s0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(SizeManager.s5),
                                                child: CustomButton(
                                                  onPressed: () async {
                                                    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                    if(xFile != null) provider.editInImages(image: xFile.path, index: index);
                                                  },
                                                  buttonType: ButtonType.icon,
                                                  iconData: Icons.edit,
                                                  width: SizeManager.s30,
                                                  height: SizeManager.s30,
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: SizeManager.s0,
                                              end: SizeManager.s0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(SizeManager.s5),
                                                child: CustomButton(
                                                  onPressed: () async => provider.removeFromImages(index),
                                                  buttonType: ButtonType.icon,
                                                  iconData: Icons.delete,
                                                  width: SizeManager.s30,
                                                  height: SizeManager.s30,
                                                  padding: EdgeInsets.zero,
                                                  buttonColor: ColorsManager.red700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: provider.images.length + 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),
                          const SizedBox(height: SizeManager.s20),

                          // Is Done *
                          Material(
                            color: Colors.transparent,
                            child: CheckboxListTile(
                              value: provider.isDone,
                              onChanged: (value) => provider.changeIsDone(value!),
                              title: Text(
                                Methods.getText(StringsManager.closeTheConsultation).toTitleCase(),
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

                          // Best Account *
                          if(provider.isDone) ...[
                            CustomButton(
                              onPressed: () {
                                Dialogs.accountsBottomSheet(context: context).then((account) {
                                  if(account != null) {
                                    insertEditInstantConsultationProvider.changeBestAccount(account);
                                  }
                                });
                              },
                              buttonType: ButtonType.postSpacerText,
                              text: provider.bestAccount == null ? Methods.getText(StringsManager.chooseBestAccount).toCapitalized() : provider.bestAccount!.fullName,
                              width: double.infinity,
                              buttonColor: ColorsManager.white,
                              borderColor: ColorsManager.grey300,
                              textColor: provider.bestAccount == null ? ColorsManager.grey : ColorsManager.black,
                              fontSize: SizeManager.s12,
                              isRequired: provider.isButtonClicked && provider.bestAccount == null,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          const SizedBox(height: SizeManager.s20),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditInstantConsultationProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.instantConsultationModel == null) {
                                  InsertInstantConsultationParameters insertInstantConsultationParameters = InsertInstantConsultationParameters(
                                    userId: provider.user!.userId,
                                    consultation: _consultationController.text.trim(),
                                    isDone: provider.isDone,
                                    bestAccountId: provider.isDone && provider.bestAccount != null ? provider.bestAccount!.accountId : null,
                                    isViewed: false,
                                    images: [],
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditInstantConsultationProvider.insertInstantConsultation(context: context, insertInstantConsultationParameters: insertInstantConsultationParameters);
                                }
                                else {
                                  EditInstantConsultationParameters editInstantConsultationParameters = EditInstantConsultationParameters(
                                    instantConsultationId: widget.instantConsultationModel!.instantConsultationId,
                                    userId: provider.user!.userId,
                                    consultation: _consultationController.text.trim(),
                                    isDone: provider.isDone,
                                    bestAccountId: provider.isDone && provider.bestAccount != null ? provider.bestAccount!.accountId : null,
                                    isViewed: widget.instantConsultationModel!.isViewed,
                                    images: widget.instantConsultationModel!.images,
                                  );
                                  insertEditInstantConsultationProvider.editInstantConsultation(context: context, editInstantConsultationParameters: editInstantConsultationParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.instantConsultationModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.instantConsultationModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _consultationController.dispose();
    super.dispose();
  }
}