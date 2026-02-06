// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:makc/core/constants/icon_constants.dart';
import 'package:makc/core/constants/string_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:share_plus/share_plus.dart';

class DialogUtils {
// Helper method to get language display name
  static String _getLanguageName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'tk':
      case 'tkm':
        return 'Türkmençe';
      case 'ru':
      case 'rus':
        return 'Русский';
      case 'en':
      case 'eng':
        return 'English';
      case 'tr':
      case 'tur':
        return 'Türkçe';
      default:
        return languageCode.toUpperCase();
    }
  }
}
