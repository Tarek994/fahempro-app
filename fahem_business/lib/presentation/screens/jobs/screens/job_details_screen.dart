import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/presentation/screens/jobs/widgets/advertiser_widget.dart';
import 'package:fahem_business/presentation/screens/jobs/widgets/details_widget.dart';
import 'package:fahem_business/presentation/screens/jobs/widgets/top_in_job_details.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobModel jobModel;

  const JobDetailsScreen({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFullLoading(
      child: SafeArea(
        child: Scaffold(
          body: CustomFullLoading(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: TopInJobDetails(jobModel: jobModel)),
                SliverToBoxAdapter(child: DetailsWidget(jobModel: jobModel)),
                SliverToBoxAdapter(child: AdvertiserWidget(jobModel: jobModel)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}