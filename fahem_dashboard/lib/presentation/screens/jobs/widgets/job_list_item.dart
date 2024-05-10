import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/change_job_status_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/hover.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/views_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/job_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobListItem extends StatefulWidget {
  final JobModel jobModel;
  final Function onEdit;
  final Function onDelete;

  const JobListItem({
    super.key,
    required this.jobModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<JobListItem> createState() => _JobListItemState();
}

class _JobListItemState extends State<JobListItem> {
  bool _isLoading = false;
  JobStatus? _currentJobStatus;

  Future<void> changeJobStatus({required JobStatus jobStatus, required String? reasonOfReject}) async {
    if(_isLoading) return;
    _currentJobStatus = jobStatus;
    setState(() => _isLoading = true);
    ChangeJobStatusParameters parameters = ChangeJobStatusParameters(
      jobId: widget.jobModel.jobId,
      jobStatus: jobStatus,
      reasonOfReject: reasonOfReject,
    );
    await DependencyInjection.changeJobStatusUseCase.call(parameters).then((response) {
      response.fold((failure) {
        setState(() => _isLoading = false);
        Methods.showToast(failure: failure);
      }, (job) {
        widget.jobModel.jobStatus = job.jobStatus;
        widget.jobModel.reasonOfReject = job.reasonOfReject;
        setState(() => _isLoading = false);

        String body = '';
        if (job.jobStatus == JobStatus.active) {body = 'اعلانك نشط الان ويمكن للجميع رؤيته';}
        else if (job.jobStatus == JobStatus.pending) {body = 'اعلانك قيد المراجعة الان';}
        else if (job.jobStatus == JobStatus.rejected) {body = '${"تم رفض اعلانك"} (${job.reasonOfReject ?? ''})';}
        // NotificationService.pushNotification(
        //   topic: job.userId.toString(),
        //   title: 'حالة الاعلان',
        //   body: body,
        //   data: {
        //     'action': FirebaseConstants.jobStatus,
        //   },
        // );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        FocusScope.of(context).unfocus();
        Methods.routeTo(context, Routes.jobDetailsScreen, arguments: widget.jobModel);
      },
      child: Column(
        children: [
          Row(
            children: [
              ImageWidget(
                image: widget.jobModel.image,
                imageDirectory: ApiConstants.jobsDirectory,
                width: SizeManager.s100,
                height: SizeManager.s100,
                borderRadius: SizeManager.s10,
                isShowFullImageScreen: false,
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.jobModel.jobTitle,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.semiBold, height: SizeManager.s1_8),
                          ),
                        ),
                        ViewsWidget(views: widget.jobModel.views),
                        if(Methods.checkAdminPermission(AdminPermissions.editJob) || Methods.checkAdminPermission(AdminPermissions.deleteJob)) ...[
                          const SizedBox(width: SizeManager.s10),
                          CustomPopupMenu(
                            items: [
                              if(Methods.checkAdminPermission(AdminPermissions.editJob)) PopupMenu.edit,
                              if(Methods.checkAdminPermission(AdminPermissions.deleteJob)) PopupMenu.delete,
                            ],
                            onPressedEdit: () => Methods.routeTo(context, Routes.insertEditJobScreen, arguments: widget.jobModel, then: (job) => widget.onEdit(job)),
                            onPressedDelete: () {
                              Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
                                if(value) {
                                  widget.onDelete();
                                }
                              });
                            },
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: SizeManager.s10),
                    Row(
                      children: [
                        Image.asset(IconsManager.profile, color: ColorsManager.lightPrimaryColor, width: SizeManager.s12, height: SizeManager.s12),
                        const SizedBox(width: SizeManager.s5),
                        Expanded(
                          child: Text(
                            widget.jobModel.account.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SizeManager.s10),
                    Row(
                      children: [
                        Image.asset(IconsManager.location, color: ColorsManager.lightPrimaryColor, width: SizeManager.s12, height: SizeManager.s12),
                        const SizedBox(width: SizeManager.s5),
                        Expanded(
                          child: Text(
                            widget.jobModel.jobLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SizeManager.s10),
                    Row(
                      children: [
                        Image.asset(IconsManager.coins, color: ColorsManager.lightPrimaryColor, width: SizeManager.s12, height: SizeManager.s12),
                        const SizedBox(width: SizeManager.s5),
                        Expanded(
                          child: Text(
                            '${widget.jobModel.minSalary} - ${widget.jobModel.maxSalary} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          CustomButton(
            onPressed: () => Methods.routeTo(
              context,
              Routes.employmentApplicationsScreen,
              arguments: EmploymentApplicationsArgs(job: widget.jobModel),
            ),
            buttonType: ButtonType.preIcon,
            text: Methods.getText(StringsManager.employmentApplications).toTitleCase(),
            iconData: FontAwesomeIcons.file,
            width: double.infinity,
            height: SizeManager.s40,
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: widget.jobModel.jobStatus == JobStatus.active ? null : () async {
                    Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureToChangeJobStatus).toCapitalized()).then((value) async {
                      if(value) {
                        await changeJobStatus(jobStatus: JobStatus.active, reasonOfReject: null);
                      }
                    });
                  },
                  buttonType: widget.jobModel.jobStatus == JobStatus.active ? ButtonType.preIcon : ButtonType.text,
                  text: Methods.getText(StringsManager.active).toCapitalized(),
                  iconData: widget.jobModel.jobStatus == JobStatus.active ? Icons.check : null,
                  isLoading: _isLoading && _currentJobStatus == JobStatus.active,
                  width: double.infinity,
                  height: SizeManager.s35,
                  fontSize: SizeManager.s12,
                  borderRadius: SizeManager.s10,
                  buttonColor: widget.jobModel.jobStatus == JobStatus.active ? ColorsManager.green : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: SizeManager.s5),
              Expanded(
                child: CustomButton(
                  onPressed: widget.jobModel.jobStatus == JobStatus.pending ? null : () async {
                    Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureToChangeJobStatus).toCapitalized()).then((value) async {
                      if(value) {
                        await changeJobStatus(jobStatus: JobStatus.pending, reasonOfReject: null);
                      }
                    });
                  },
                  buttonType: widget.jobModel.jobStatus == JobStatus.pending ? ButtonType.preIcon : ButtonType.text,
                  text: Methods.getText(StringsManager.pending).toCapitalized(),
                  iconData: widget.jobModel.jobStatus == JobStatus.pending ? Icons.pending : null,
                  isLoading: _isLoading && _currentJobStatus == JobStatus.pending,
                  width: double.infinity,
                  height: SizeManager.s35,
                  fontSize: SizeManager.s12,
                  borderRadius: SizeManager.s10,
                  buttonColor: widget.jobModel.jobStatus == JobStatus.pending ? ColorsManager.amber : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: SizeManager.s5),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Dialogs.getTextFromController(context: context, title: StringsManager.writeTheReasonForRejection).then((value) async {
                      if(value != null) {
                        await changeJobStatus(jobStatus: JobStatus.rejected, reasonOfReject: value);
                      }
                    });
                  },
                  buttonType: widget.jobModel.jobStatus == JobStatus.rejected ? ButtonType.preIcon : ButtonType.text,
                  text: Methods.getText(StringsManager.rejected).toCapitalized(),
                  iconData: widget.jobModel.jobStatus == JobStatus.rejected ? Icons.clear : null,
                  isLoading: _isLoading && _currentJobStatus == JobStatus.rejected,
                  width: double.infinity,
                  height: SizeManager.s35,
                  fontSize: SizeManager.s12,
                  borderRadius: SizeManager.s10,
                  buttonColor: widget.jobModel.jobStatus == JobStatus.rejected ? ColorsManager.red : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                ),
              ),
            ],
          ),
          if(widget.jobModel.jobStatus == JobStatus.rejected && widget.jobModel.reasonOfReject != null) ...[
            const SizedBox(height: SizeManager.s10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SizeManager.s10),
              decoration: BoxDecoration(
                color: ColorsManager.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(SizeManager.s10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Methods.getText(StringsManager.reasonOfReject).toCapitalized(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  Text(
                    widget.jobModel.reasonOfReject!,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}