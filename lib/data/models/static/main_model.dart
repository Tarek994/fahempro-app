import 'package:flutter/material.dart';

class MainModel {
  final String textAr;
  final String textEn;
  final String image;
  final String? route;
  final Object? arguments;
  final String messageNotAllowed;
  final Function(BuildContext context)? onTap;
  final bool isLock;

  MainModel({
    required this.textAr,
    required this.textEn,
    required this.image,
    required this.route,
    this.arguments,
    this.messageNotAllowed = '',
    this.onTap,
    this.isLock = false,
  });
}