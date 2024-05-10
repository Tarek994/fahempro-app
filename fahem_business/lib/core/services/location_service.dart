import 'dart:async';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/presentation/btm_sheets/location_msg_btm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {

  static Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  static Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  static Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream();
  }

  static Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  static Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  static double distanceBetweenTwoPointsInMeters({required LatLng startPoint, required LatLng endPoint}) {
    return Geolocator.distanceBetween(
      startPoint.latitude,
      startPoint.longitude,
      endPoint.latitude,
      endPoint.longitude,
    );
  }

  static double distanceBetweenTwoPointsInKms({required LatLng startPoint, required LatLng endPoint}) {
    return Geolocator.distanceBetween(
      startPoint.latitude,
      startPoint.longitude,
      endPoint.latitude,
      endPoint.longitude,
    ) / 1000;
  }

  static Future<Position?> checkPermissionAndGetCurrentPosition(BuildContext context) async {
    Position? position;

    await isLocationEnabled().then((isLocationEnabled) async {
      if(isLocationEnabled) {
        await checkPermission().then((locationPermission) async {
          if(locationPermission == LocationPermission.denied) {
            await requestPermission().then((locationPermission) async {
              if(locationPermission == LocationPermission.denied) {
              }
              if(locationPermission == LocationPermission.deniedForever) {
                Dialogs.showBottomSheet(
                  context: context,
                  child: const LocationMsgBtmSheet(
                    title: StringsManager.permission,
                    message: StringsManager.updateLocationInAppSettings,
                  ),
                );
              }
              if(locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always) {
                position = await getCurrentPosition().then((value) => value);
              }
            });
          }
          else if(locationPermission == LocationPermission.deniedForever) {
            Dialogs.showBottomSheet(
              context: context,
              child: const LocationMsgBtmSheet(
                title: StringsManager.location,
                message: StringsManager.updateLocationInAppSettings,
              ),
            );
          }
          else if(locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always) {
            position = await Geolocator.getCurrentPosition().then((value) => value);
          }
        });
      }
      else {
        Dialogs.showBottomSheet(
          context: context,
          child: const LocationMsgBtmSheet(
            title: StringsManager.location,
            message: StringsManager.turnOnLocationServices,
          ),
        );
      }
    });

    return position;
  }

  static Future<String> getAddressFromCoordinates(LatLng position) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'ar_en');
    if(placeMarks.isEmpty) return 'unknown';
    Placemark placeMark  = placeMarks[0];
    String address = "${placeMark.street}, ${placeMark.subAdministrativeArea}, ${placeMark.administrativeArea}, ${placeMark.country}";
    // String address = "${placeMark.street}";
    return address;
  }
}