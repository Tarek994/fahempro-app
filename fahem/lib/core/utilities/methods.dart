import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/network/firebase_constants.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/services/notification_service.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/domain/usecases/admin_notifications/insert_admin_notification_usecase.dart';
import 'package:fahem/domain/usecases/notifications/insert_notification_usecase.dart';
import 'package:fahem/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/language_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/helper/cache_helper.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;

class Methods {

  static String getText(String text) {
    String language = MyProviders.appProvider.isEnglish ? ConstantsManager.english : ConstantsManager.arabic;
    return languageManager[text]![language]!;
  }

  static String getTextAr(String text) {
    return languageManager[text]![ConstantsManager.arabic]!;
  }

  static String getTextEn(String text) {
    return languageManager[text]![ConstantsManager.english]!;
  }

  static bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text.trim());
  }

  static String formatDate({
    required int milliseconds,
    String? format,
    bool isDateOnly = false,
    bool isTimeAndAOnly = false,
    String? locale,
  }) {
    String myLocale = locale ?? (MyProviders.appProvider.isEnglish ? 'en_US' : 'ar_EG');

    if(format != null) {
      return intl.DateFormat(format, myLocale).format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
    }
    else {
      String date = intl.DateFormat.yMMMMd(myLocale).format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
      String time = intl.DateFormat('h:mm', myLocale).format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
      String a = intl.DateFormat('a', myLocale).format(DateTime.fromMillisecondsSinceEpoch(milliseconds));

      if(isDateOnly) {
        return date;
      }
      else if(isTimeAndAOnly) {
        return '$time $a';
      }
      else {
        return '$date  $time $a';
      }
    }
  }

  static String getWordStatusLabel({required int num, required WordStatusLabel label}) {
    String result = '';
    if(MyProviders.appProvider.isEnglish) {
      if(num == 0) {
        if(label == WordStatusLabel.year) {result = '0 year';}
        if(label == WordStatusLabel.month) {result = 'Not Found';}
        if(label == WordStatusLabel.week) {result = 'Not Found';}
        if(label == WordStatusLabel.day) {result = 'Not Found';}
        if(label == WordStatusLabel.hour) {result = 'Not Found';}
        if(label == WordStatusLabel.minute) {result = 'Not Found';}
        if(label == WordStatusLabel.second) {result = 'Not Found';}
        if(label == WordStatusLabel.like) {result = 'Not Found';}
        if(label == WordStatusLabel.comment) {result = 'Not Found';}
        if(label == WordStatusLabel.lesson) {result = 'Not Found';}
        if(label == WordStatusLabel.student) {result = 'Not Found';}
        if(label == WordStatusLabel.point) {result = '0 Point';}
        if(label == WordStatusLabel.product) {result = 'Not Found';}
        if(label == WordStatusLabel.video) {result = '0 Video';}
        if(label == WordStatusLabel.user) {result = '0 user';}
      }
      else if(num == 1) {
        if(label == WordStatusLabel.year) {result = '$num year';}
        if(label == WordStatusLabel.month) {result = '$num month';}
        if(label == WordStatusLabel.week) {result = '$num week';}
        if(label == WordStatusLabel.day) {result = '$num day';}
        if(label == WordStatusLabel.hour) {result = '$num hour';}
        if(label == WordStatusLabel.minute) {result = '$num minute';}
        if(label == WordStatusLabel.second) {result = '$num second';}
        if(label == WordStatusLabel.like) {result = '$num like';}
        if(label == WordStatusLabel.comment) {result = '$num comment';}
        if(label == WordStatusLabel.lesson) {result = '$num lesson';}
        if(label == WordStatusLabel.student) {result = '$num student';}
        if(label == WordStatusLabel.point) {result = '$num point';}
        if(label == WordStatusLabel.product) {result = '$num product';}
        if(label == WordStatusLabel.video) {result = '$num video';}
        if(label == WordStatusLabel.user) {result = '$num user';}
      }
      else {
        if(label == WordStatusLabel.year) {result = '$num years';}
        if(label == WordStatusLabel.month) {result = '$num months';}
        if(label == WordStatusLabel.week) {result = '$num weeks';}
        if(label == WordStatusLabel.day) {result = '$num days';}
        if(label == WordStatusLabel.hour) {result = '$num hours';}
        if(label == WordStatusLabel.minute) {result = '$num minutes';}
        if(label == WordStatusLabel.second) {result = '$num seconds';}
        if(label == WordStatusLabel.like) {result = '$num likes';}
        if(label == WordStatusLabel.comment) {result = '$num comments';}
        if(label == WordStatusLabel.lesson) {result = '$num lessons';}
        if(label == WordStatusLabel.student) {result = '$num students';}
        if(label == WordStatusLabel.point) {result = '$num points';}
        if(label == WordStatusLabel.product) {result = '$num products';}
        if(label == WordStatusLabel.video) {result = '$num videos';}
        if(label == WordStatusLabel.user) {result = '$num users';}
      }
    }
    else {
      if(num == 0) {
        if(label == WordStatusLabel.year) {result = 'لا يوجد';}
        if(label == WordStatusLabel.month) {result = 'لا يوجد';}
        if(label == WordStatusLabel.week) {result = 'لا يوجد';}
        if(label == WordStatusLabel.day) {result = 'لا يوجد';}
        if(label == WordStatusLabel.hour) {result = 'لا يوجد';}
        if(label == WordStatusLabel.minute) {result = 'لا يوجد';}
        if(label == WordStatusLabel.second) {result = 'لا يوجد';}
        if(label == WordStatusLabel.like) {result = 'لا يوجد';}
        if(label == WordStatusLabel.comment) {result = 'لا يوجد';}
        if(label == WordStatusLabel.lesson) {result = 'لا يوجد';}
        if(label == WordStatusLabel.student) {result = 'لا يوجد';}
        if(label == WordStatusLabel.point) {result = 'لا يوجد نقط';}
        if(label == WordStatusLabel.product) {result = 'لا يوجد';}
        if(label == WordStatusLabel.video) {result = '0 فيديو';}
        if(label == WordStatusLabel.user) {result = '0 مستخدم';}
      }
      else if(num == 1) {
        if(label == WordStatusLabel.year) {result = 'سنة';}
        if(label == WordStatusLabel.month) {result = 'شهر';}
        if(label == WordStatusLabel.week) {result = 'اسبوع';}
        if(label == WordStatusLabel.day) {result = 'يوم';}
        if(label == WordStatusLabel.hour) {result = 'ساعة';}
        if(label == WordStatusLabel.minute) {result = 'دقيقة';}
        if(label == WordStatusLabel.second) {result = 'ثانية';}
        if(label == WordStatusLabel.like) {result = 'اعجاب';}
        if(label == WordStatusLabel.comment) {result = 'تعليق';}
        if(label == WordStatusLabel.lesson) {result = 'حصة واحدة';}
        if(label == WordStatusLabel.student) {result = 'طالب واحد';}
        if(label == WordStatusLabel.point) {result = 'نقطة واحدة';}
        if(label == WordStatusLabel.product) {result = 'منتج واحد';}
        if(label == WordStatusLabel.video) {result = 'فيديو واحد';}
        if(label == WordStatusLabel.user) {result = 'مستخدم واحد';}
      }
      else if(num == 2) {
        if(label == WordStatusLabel.year) {result = 'سنتين';}
        if(label == WordStatusLabel.month) {result = 'شهرين';}
        if(label == WordStatusLabel.week) {result = 'اسبوعين';}
        if(label == WordStatusLabel.day) {result = 'يومين';}
        if(label == WordStatusLabel.hour) {result = 'ساعتين';}
        if(label == WordStatusLabel.minute) {result = 'دقيقتين';}
        if(label == WordStatusLabel.second) {result = 'ثانيتين';}
        if(label == WordStatusLabel.like) {result = 'اعجابين';}
        if(label == WordStatusLabel.comment) {result = 'تعليقين';}
        if(label == WordStatusLabel.lesson) {result = 'حصتين';}
        if(label == WordStatusLabel.student) {result = 'طالبين';}
        if(label == WordStatusLabel.point) {result = 'نقطتين';}
        if(label == WordStatusLabel.product) {result = 'منتجين';}
        if(label == WordStatusLabel.video) {result = 'فيديوهين';}
        if(label == WordStatusLabel.user) {result = 'مستخدمان';}
      }
      else if(num >= 3 && num <= 10) {
        if(label == WordStatusLabel.year) {result = '$num سنين';}
        if(label == WordStatusLabel.month) {result = '$num شهور';}
        if(label == WordStatusLabel.week) {result = '$num اسابيع';}
        if(label == WordStatusLabel.day) {result = '$num ايام';}
        if(label == WordStatusLabel.hour) {result = '$num ساعات';}
        if(label == WordStatusLabel.minute) {result = '$num دقائق';}
        if(label == WordStatusLabel.second) {result = '$num ثوانى';}
        if(label == WordStatusLabel.like) {result = '$num اعجابات';}
        if(label == WordStatusLabel.comment) {result = '$num تعليقات';}
        if(label == WordStatusLabel.lesson) {result = '$num حصص';}
        if(label == WordStatusLabel.student) {result = '$num طلاب';}
        if(label == WordStatusLabel.point) {result = '$num نقط';}
        if(label == WordStatusLabel.product) {result = '$num منتجات';}
        if(label == WordStatusLabel.video) {result = '$num فيديوهات';}
        if(label == WordStatusLabel.user) {result = '$num مستخدمين';}
      }
      else {
        if(label == WordStatusLabel.year) {result = '$num سنة';}
        if(label == WordStatusLabel.month) {result = '$num شهر';}
        if(label == WordStatusLabel.week) {result = '$num اسبوع';}
        if(label == WordStatusLabel.day) {result = '$num يوم';}
        if(label == WordStatusLabel.hour) {result = '$num ساعة';}
        if(label == WordStatusLabel.minute) {result = '$num دقيقة';}
        if(label == WordStatusLabel.second) {result = '$num ثانية';}
        if(label == WordStatusLabel.like) {result = '$num اعجاب';}
        if(label == WordStatusLabel.comment) {result = '$num تعليق';}
        if(label == WordStatusLabel.lesson) {result = '$num حصة';}
        if(label == WordStatusLabel.student) {result = '$num طالب';}
        if(label == WordStatusLabel.point) {result = '$num نقطة';}
        if(label == WordStatusLabel.product) {result = '$num منتج';}
        if(label == WordStatusLabel.video) {result = '$num فيديو';}
        if(label == WordStatusLabel.user) {result = '$num مستخدم';}
      }
    }
    return result;
  }

  static String convertToTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays >= 365) {
      String label = getWordStatusLabel(num: (difference.inDays / 365).floor(), label: WordStatusLabel.year);
      return MyProviders.appProvider.isEnglish ? "$label ago" : "منذ $label";
    }
    if (difference.inDays >= 30) {
      String label = getWordStatusLabel(num: (difference.inDays / 30).floor(), label: WordStatusLabel.month);
      return MyProviders.appProvider.isEnglish ? "$label ago" : "منذ $label";
    }
    if (difference.inDays >= 7) {
      String label = getWordStatusLabel(num: (difference.inDays / 7).floor(), label: WordStatusLabel.week);
      return MyProviders.appProvider.isEnglish ? "$label ago" : "منذ $label";
    }
    if (difference.inDays > 0) {
      String label = getWordStatusLabel(num: difference.inDays, label: WordStatusLabel.day);
      return MyProviders.appProvider.isEnglish ? "$label ago" : "منذ $label";
    }
    if (difference.inHours > 0) {
      String label = getWordStatusLabel(num: difference.inHours, label: WordStatusLabel.hour);
      return MyProviders.appProvider.isEnglish ? "$label ago" : "منذ $label";
    }
    if (difference.inMinutes > 0) {
      String label = getWordStatusLabel(num: difference.inMinutes, label: WordStatusLabel.minute);
      return MyProviders.appProvider.isEnglish ? "$label ago" : "منذ $label";
    }
    return MyProviders.appProvider.isEnglish ? "just now" : "الان";
  }

  static String getRandomId() {
    List<String> characters = [
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
      'a','b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
      'A','B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    ];
    String id = '';
    for(int i=0; i<20; i++) {
      id+= characters[Random().nextInt(characters.length)];
    }
    return id;
  }

  static String getRandomOtp() {
    List<String> numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String id = '';
    for(int i=0; i<6; i++) {
      id+= numbers[Random().nextInt(numbers.length)];
    }
    return id;
  }

  static TextDirection getDirection() {
    return MyProviders.appProvider.isEnglish ? TextDirection.ltr : TextDirection.rtl;
  }

  static TextDirection getDirectionFromText(String text) {
    return isRTL(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  static Future<void> openUrl({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {await launchUrl(uri, mode: LaunchMode.externalApplication);}
      else {throw Methods.getText(StringsManager.cantLaunchUrl).toCapitalized();}
    }
    catch (e) {
      debugPrint(e.toString());
      Methods.showToast(message: e.toString());
    }
  }

  static Future<void> routeTo(BuildContext context, String route, {
    Object? arguments,
    var then,
    bool isPushReplacement = false,
    bool isPushNamedAndRemoveUntil = false,
    bool isMustLogin = false,
  }) async {
    if (isMustLogin && MyProviders.authenticationProvider.currentUser == null) {
      Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.youMustLoginFirst).toCapitalized(),
      ).then((value) async {
        if (value) {
          if (isPushReplacement) {
            await Navigator.pushReplacementNamed(context, Routes.loginWithPhoneScreen, arguments: arguments).then(then ?? (value) {});
          }
          else if (isPushNamedAndRemoveUntil) {
            await Navigator.pushNamedAndRemoveUntil(context, Routes.loginWithPhoneScreen, (route) => false).then(then ?? (value) {});
          }
          else {
            await Navigator.pushNamed(context, Routes.loginWithPhoneScreen, arguments: arguments).then(then ?? (value) {});
          }
        }
      });
    }
    else {
      if (isPushReplacement) {
        await Navigator.pushReplacementNamed(context, route, arguments: arguments).then(then ?? (value) {});
      }
      else if (isPushNamedAndRemoveUntil) {
        await Navigator.pushNamedAndRemoveUntil(context, route, (route) => false).then(then ?? (value) {});
      }
      else {
        await Navigator.pushNamed(context, route, arguments: arguments).then(then ?? (value) {});
      }
    }
  }

  static void onChangeLanguage() {
    MyProviders.appProvider.changeIsEnglish(!MyProviders.appProvider.isEnglish);
    CacheHelper.setData(key: CacheHelper.isEnglishKey, value: MyProviders.appProvider.isEnglish);
  }

  static void onChangeTheme() {
    MyProviders.appProvider.changeIsLight(!MyProviders.appProvider.isLight);
    CacheHelper.setData(key: CacheHelper.isLightKey, value: MyProviders.appProvider.isLight);
  }

  static void showSnackBar({required BuildContext context, Failure? failure, String? message, ShowMessage showMessage = ShowMessage.failure}) {
    SnackBar snackBar = SnackBar(
      backgroundColor: showMessage == ShowMessage.success ? ColorsManager.success : ColorsManager.failure,
      content: Text(
        failure != null ? MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr : message ?? '',
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showToast({Failure? failure, String? message, ShowMessage showMessage = ShowMessage.failure}) {Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: failure != null ? MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr : message ?? '',
      backgroundColor: showMessage == ShowMessage.success ? ColorsManager.success : ColorsManager.failure,
      fontSize: SizeManager.s18,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void playSound(String path) {
    AudioPlayer().play(AssetSource(path));
  }

  static int extractStartTime(DateTime dateTime) => DateTime(dateTime.year, dateTime.month, dateTime.day).millisecondsSinceEpoch;
  static int extractEndTime(DateTime dateTime) => DateTime(dateTime.year, dateTime.month, dateTime.day).add(const Duration(days: 1)).millisecondsSinceEpoch-1000;
  static int extractStartThisMonth(DateTime dateTime) => DateTime(dateTime.year, dateTime.month, 1).millisecondsSinceEpoch;
  static int extractEndThisMonth(DateTime dateTime) => DateTime(dateTime.year, dateTime.month, DateTime(dateTime.year, dateTime.month + 1, 0).day).add(const Duration(days: 1)).millisecondsSinceEpoch-1000;
  static int extractStartLastMonth(DateTime dateTime) => DateTime(dateTime.year, dateTime.month-1, 1).millisecondsSinceEpoch;
  static int extractEndLastMonth(DateTime dateTime) => DateTime(dateTime.year, dateTime.month-1, DateTime(dateTime.year, dateTime.month, 0).day).add(const Duration(days: 1)).millisecondsSinceEpoch-1000;

  static Future<DateTime?> selectDateFromPicker({
    required BuildContext context,
    required String title,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return await DatePicker.showSimpleDatePicker(
      context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.values[1],
      reverse: true,
      backgroundColor: ColorsManager.white,
      textColor: ColorsManager.black,
      titleText: Methods.getText(title).toCapitalized(),
      cancelText: Methods.getText(StringsManager.cancel).toCapitalized(),
      confirmText: Methods.getText(StringsManager.ok).toCapitalized(),
      itemTextStyle: Theme.of(context).textTheme.bodyLarge,
    );
  }

  static Future<TimeOfDay?> selectTimeFromPicker({required BuildContext context, required TimeOfDay initialTime}) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      helpText: Methods.getText(StringsManager.selectTime).toCapitalized(),
      cancelText: Methods.getText(StringsManager.cancel).toCapitalized(),
      confirmText: Methods.getText(StringsManager.ok).toCapitalized(),
    );
  }

  static Widget dividerHeight() {
    return Container(
      height: SizeManager.s40,
      width: SizeManager.s5,
      margin: const EdgeInsetsDirectional.fromSTEB(SizeManager.s0, SizeManager.s0, SizeManager.s10, SizeManager.s0),
      decoration: BoxDecoration(
        color: ColorsManager.lightPrimaryColor,
        borderRadius: BorderRadius.circular(SizeManager.s20),
      ),
    );
  }

  static Widget _shimmerListItem() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.grey300,
      highlightColor: ColorsManager.grey300.withOpacity(0.2),
      direction: MyProviders.appProvider.isEnglish ? ShimmerDirection.ltr : ShimmerDirection.rtl,
      child: Row(
        children: [
          const CircleAvatar(radius: SizeManager.s25),
          const SizedBox(width: SizeManager.s10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: SizeManager.s10,
                  color: ColorsManager.white,
                ),
                const SizedBox(height: SizeManager.s5),
                Container(
                  width: SizeManager.s100,
                  height: SizeManager.s10,
                  color: ColorsManager.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget shimmerSliverList() {
    return SliverList.separated(
      itemBuilder: (context, index) => _shimmerListItem(),
      separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s15),
      itemCount: 20,
    );
  }

  static Widget _shimmerItem({double itemHeight = SizeManager.s100}) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.grey300,
      highlightColor: ColorsManager.grey300.withOpacity(0.2),
      direction: MyProviders.appProvider.isEnglish ? ShimmerDirection.ltr : ShimmerDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(SizeManager.s5),
        width: double.infinity,
        height: itemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeManager.s10),
          color: ColorsManager.grey300,
        ),
      ),
    );
  }

  static Widget shimmerGrid({double itemHeight = SizeManager.s100}) {
    return CustomGrid(
      listLength: 9,
      numberOfItemsInRow: 3,
      isExpandedEmptySpace: true,
      child: (index) => _shimmerItem(itemHeight: itemHeight),
    );
  }

  static Widget btmSheetSwiper() {
    return Center(
      child: Container(
        width: SizeManager.s50,
        height: SizeManager.s5,
        decoration: BoxDecoration(
          color: ColorsManager.grey300,
          borderRadius: BorderRadius.circular(SizeManager.s10),
        ),
      ),
    );
  }

  static Future<Position?> checkPermissionAndGetCurrentPosition(BuildContext context) async {
    Position? position;

    await Geolocator.isLocationServiceEnabled().then((isLocationServiceEnabled) async {
      if(isLocationServiceEnabled) {
        await Geolocator.checkPermission().then((locationPermission) async {
          if(locationPermission == LocationPermission.denied) {
            await Geolocator.requestPermission().then((locationPermission) async {
              if(locationPermission == LocationPermission.denied) {
                Dialogs.showPermissionDialog(
                  context: context,
                  title: StringsManager.permission,
                  message: StringsManager.updateLocationInAppSettings,
                );
              }
              if(locationPermission == LocationPermission.deniedForever) {
                Dialogs.showPermissionDialog(
                  context: context,
                  title: StringsManager.permission,
                  message: StringsManager.updateLocationInAppSettings,
                );
              }
              if(locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always) {
                position = await Geolocator.getCurrentPosition().then((value) => value);
              }
            });
          }
          else if(locationPermission == LocationPermission.deniedForever) {
            Dialogs.showPermissionDialog(
              context: context,
              title: StringsManager.location,
              message: StringsManager.updateLocationInAppSettings,
            );
          }
          else if(locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always) {
            position = await Geolocator.getCurrentPosition().then((value) => value);
          }
        });
      }
      else {
        Dialogs.showPermissionDialog(
          context: context,
          title: StringsManager.location,
          message: StringsManager.turnOnLocationServices,
        );
      }
    });

    return position;
  }

  static Future<String?> uploadImage({required BuildContext context, required String imagePath, required String directory}) async {
    String? result;
    UploadFileParameters uploadFileParameters = UploadFileParameters(
      file: File(imagePath),
      directory: directory,
    );
    Either<Failure, String> response = await DependencyInjection.uploadFileUseCase(uploadFileParameters);
    await response.fold((failure) async {
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (imageName) {
      result = imageName;
    });
    return result;
  }

  static int getAge(String createdAt) {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));

    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;

    if (month2 > month1) {
      age--;
    }
    else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age+1;
  }

  static bool checkAdminPermission(AdminPermissions adminPermissions) {
    return true;
  }

  static String getYoutubeThumbnail(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }

  static Future<void> sendNotificationToAdmin({required String title, required String body}) async {
    InsertAdminNotificationParameters parameters = InsertAdminNotificationParameters(
      title: title,
      body: body,
      isViewed: false,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await DependencyInjection.insertAdminNotificationUseCase.call(parameters).then((response) {
      response.fold((l) {}, (r) {
        NotificationService.pushNotification(
          topic: FirebaseConstants.fahemDashboardTopic,
          title: title,
          body: body,
        );
      });
    });
  }

  static Future<void> sendNotificationToBusiness({required int accountId, required String title, required String body}) async {
    InsertNotificationParameters parameters = InsertNotificationParameters(
      userId: null,
      accountId: accountId,
      notificationToApp: NotificationToApp.fahemBusiness,
      notificationTo: NotificationTo.one,
      title: title,
      body: body,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await DependencyInjection.insertNotificationUseCase.call(parameters).then((response) {
      response.fold((l) {}, (r) {
        NotificationService.pushNotification(
          topic: '${FirebaseConstants.accountPrefix}$accountId',
          title: title,
          body: body,
        );
      });
    });
  }

  static Future<void> sendNotificationToUser({
    required int userId,
    required String title,
    required String body,
    bool fromLocal = false,
  }) async {
    InsertNotificationParameters parameters = InsertNotificationParameters(
      userId: userId,
      accountId: null,
      notificationToApp: NotificationToApp.fahem,
      notificationTo: NotificationTo.one,
      title: title,
      body: body,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await DependencyInjection.insertNotificationUseCase.call(parameters).then((response) {
      response.fold((l) {}, (r) {
        if(fromLocal) {
          NotificationService.createLocalNotification(
            title: title,
            body: body,
          );
        }
        else {
          NotificationService.pushNotification(
            topic: '${FirebaseConstants.userPrefix}$userId',
            title: title,
            body: body,
          );
        }
      });
    });
  }
}