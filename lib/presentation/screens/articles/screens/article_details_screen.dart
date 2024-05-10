import 'package:fahem/presentation/shared/widgets/views_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/article_model.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/date_widget.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/my_back_button.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final ArticleModel articleModel;

  const ArticleDetailsScreen({
    super.key,
    required this.articleModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFullLoading(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(SizeManager.s30), bottomRight: Radius.circular(SizeManager.s30)),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ImageWidget(
                                image: articleModel.image,
                                imageDirectory: ApiConstants.articlesDirectory,
                                width: double.infinity,
                                height: SizeManager.s250,
                                customBorderRadius: const BorderRadiusDirectional.only(bottomEnd: Radius.circular(SizeManager.s20), bottomStart: Radius.circular(SizeManager.s20)),
                                isShowFullImageScreen: true,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(SizeManager.s8),
                                child: MyBackButton(
                                  width: SizeManager.s40,
                                  height: SizeManager.s40,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(SizeManager.s20),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MyProviders.appProvider.isEnglish ? articleModel.titleEn : articleModel.titleAr,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.semiBold),
                                ),
                                const SizedBox(height: SizeManager.s15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DateWidget(createdAt: articleModel.createdAt),
                                    ),
                                    ViewsWidget(
                                      views: articleModel.views,
                                      color: ColorsManager.lightPrimaryColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(SizeManager.s16),
                      width: double.infinity,
                      child: Text(
                        MyProviders.appProvider.isEnglish ? articleModel.articleEn : articleModel.articleAr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s2_5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}