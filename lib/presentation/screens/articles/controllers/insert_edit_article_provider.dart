import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/article_model.dart';
import 'package:fahem/domain/usecases/articles/edit_article_usecase.dart';
import 'package:fahem/domain/usecases/articles/insert_article_usecase.dart';

class InsertEditArticleProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  dynamic _articleImage;
  dynamic get articleImage => _articleImage;
  setArticleImage(dynamic articleImage) => _articleImage = articleImage;
  changeArticleImage(dynamic articleImage) {_articleImage = articleImage; notifyListeners();}

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;
  setIsAvailable(bool isAvailable) => _isAvailable = isAvailable;
  changeIsAvailable(bool isAvailable) {_isAvailable = isAvailable; notifyListeners();}

  bool isAllDataValid() {
    if(_articleImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.articleImageIsRequired).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Article
  Future<void> insertArticle({required BuildContext context, required InsertArticleParameters insertArticleParameters}) async {
    changeIsLoading(true);
    if(_articleImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _articleImage.path!, directory: ApiConstants.articlesDirectory);
      insertArticleParameters.image = imageName!;
    }
    Either<Failure, ArticleModel> response = await DependencyInjection.insertArticleUseCase.call(insertArticleParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (article) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, article),
      );
    });
  }

  Future<void> editArticle({required BuildContext context, required EditArticleParameters editArticleParameters}) async {
    changeIsLoading(true);
    if(_articleImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _articleImage.path!, directory: ApiConstants.articlesDirectory);
      editArticleParameters.image = imageName!;
    }
    Either<Failure, ArticleModel> response = await DependencyInjection.editArticleUseCase.call(editArticleParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (article) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, article),
      );
    });
  }
  // endregion
}