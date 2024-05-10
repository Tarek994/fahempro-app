import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/data/response/social_media_response.dart';
import 'package:fahem/domain/usecases/social_media/get_social_media_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/data/models/social_media_model.dart';

class SocialMediaProvider with ChangeNotifier {

  List<SocialMediaModel> _socialMedia = [];
  List<SocialMediaModel> get socialMedia => _socialMedia;
  setSocialMedia(List<SocialMediaModel> socialMedia) => _socialMedia = socialMedia;
  changeSocialMedia(List<SocialMediaModel> socialMedia) {_socialMedia = socialMedia; notifyListeners();}

  // region Get Social Media
  Future<void> refreshSocialMedia() async {
    GetSocialMediaParameters parameters = GetSocialMediaParameters(
      filtersMap: jsonEncode({'isAvailable': true}),
    );
    Either<Failure, SocialMediaResponse> response = await DependencyInjection.getSocialMediaUseCase.call(parameters);
    response.fold((failure) {}, (socialMediaResponse) {
      changeSocialMedia(socialMediaResponse.socialMedia);
    });
  }
  // endregion
}