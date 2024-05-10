import 'package:carousel_slider/carousel_slider.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/slider_model.dart';
import 'package:fahem/domain/usecases/jobs/get_job_with_id_usecase.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<SliderModel> sliders;
  final List<String> images;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final String imageDirectory;
  final int currentSliderIndex;
  final double height;
  final double? borderRadius;
  final BorderRadiusGeometry? customBorderRadius;
  final double? horizontalPadding;
  final bool? showIndicator;
  final bool? showNumberOfImages;
  final bool? showZoomIcon;
  final bool isShowIndicatorOut;
  final double viewportFraction;

  const CustomCarouselSlider({
    super.key,
    required this.sliders,
    required this.images,
    required this.onPageChanged,
    required this.imageDirectory,
    required this.currentSliderIndex,
    required this.height,
    this.borderRadius = SizeManager.s0,
    this.customBorderRadius,
    this.horizontalPadding = SizeManager.s0,
    this.showIndicator = false,
    this.showNumberOfImages = false,
    this.showZoomIcon = false,
    this.isShowIndicatorOut = false,
    this.viewportFraction = 1,
  });

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselController _carouselController = CarouselController();
  bool _isLoading = false;

  Future<void> _onClickSlider(SliderModel slider) async {
    _isLoading = true;
    // if (slider.sliderTarget == SliderTarget.jobDetails && slider.value != null) {
    //   await DependencyInjection.getJobWithIdUseCase.call(GetJobWithIdParameters(jobId: int.parse(slider.value!))).then((response) {
    //     response.fold((failure) {
    //       Methods.showToast(failure: failure);
    //     }, (job) {
    //       Methods.routeTo(context, Routes.jobDetailsScreen, arguments: job);
    //     });
    //   });
    // }
    if (slider.sliderTarget == SliderTarget.externalLink && slider.value != null) {
      await Methods.openUrl(url: slider.value!);
    }
    else if (slider.sliderTarget == SliderTarget.whatsapp && slider.value != null) {
      await Methods.openUrl(url: 'https://wa.me/${slider.value}');
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.images.isEmpty) return const SizedBox();
    return SizedBox(
      height: widget.height + (widget.isShowIndicatorOut ? SizeManager.s30 : SizeManager.s0),
      child: Column(
        children: [
          SizedBox(
            height: widget.height,
            child: Stack(
              children: [
                // Slider
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    aspectRatio: 1.0,
                    height: widget.height,
                    initialPage: 0,
                    viewportFraction: widget.viewportFraction,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: widget.images.length > 1,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: widget.onPageChanged,
                  ),
                  items: widget.sliders.map((slider) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding!),
                      child: GestureDetector(
                        onTap: _isLoading ? null : () async => await _onClickSlider(slider),
                        child: ImageWidget(
                          image: slider.image,
                          imageDirectory: widget.imageDirectory,
                          width: double.infinity,
                          height: double.infinity,
                          borderRadius: widget.borderRadius,
                          customBorderRadius: widget.customBorderRadius,
                          fit: BoxFit.fill,
                          isShowFullImageScreen: slider.sliderTarget == SliderTarget.openImage,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Indicator
                if(widget.showIndicator! && !widget.isShowIndicatorOut) Padding(
                  padding: const EdgeInsets.only(bottom: SizeManager.s10),
                  child: _Indicator(
                    images: widget.images,
                    carouselController: _carouselController,
                    currentSliderIndex: widget.currentSliderIndex,
                  ),
                ),

                // Number Of Images
                if(widget.showNumberOfImages! && widget.images.isNotEmpty) Padding(
                  padding: const EdgeInsets.symmetric(vertical: SizeManager.s16, horizontal: SizeManager.s32),
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                      decoration: BoxDecoration(
                        color: ColorsManager.lightPrimaryColor,
                        borderRadius: BorderRadius.circular(SizeManager.s10),
                      ),
                      child: Text(
                        '${widget.currentSliderIndex+1} / ${widget.images.length}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorsManager.white),
                      ),
                    ),
                  ),
                ),

                // Zoom Icon
                if(widget.showZoomIcon!) Padding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: const EdgeInsets.all(SizeManager.s8),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsManager.lightPrimaryColor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            String image = ApiConstants.fileUrl(fileName: '${widget.imageDirectory}/${widget.images[widget.currentSliderIndex]}');
                            Methods.routeTo(context, Routes.showFullImageScreen, arguments: image);
                          },
                          padding: const EdgeInsets.all(SizeManager.s5),
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          icon: const Icon(Icons.zoom_out_map, color: ColorsManager.white, size: SizeManager.s18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Indicator
          if(widget.showIndicator! && widget.isShowIndicatorOut) ...[
            const SizedBox(height: SizeManager.s20),
            _Indicator(
              images: widget.images,
              carouselController: _carouselController,
              currentSliderIndex: widget.currentSliderIndex,
            ),
          ],
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final List<String> images;
  final CarouselController carouselController;
  final int currentSliderIndex;

  const _Indicator({
    required this.images,
    required this.carouselController,
    required this.currentSliderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => carouselController.animateToPage(entry.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: SizeManager.s5),
              width: currentSliderIndex == entry.key ? SizeManager.s40 : SizeManager.s20,
              height: SizeManager.s8,
              decoration: BoxDecoration(
                color: MyProviders.appProvider.isLight
                    ? (currentSliderIndex == entry.key ? ColorsManager.lightSecondaryColor : ColorsManager.grey)
                    : (currentSliderIndex == entry.key ? ColorsManager.white : ColorsManager.grey),
                borderRadius: BorderRadius.circular(SizeManager.s2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
