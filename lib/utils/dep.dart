import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_lang/model/language_model.dart';
import 'package:multi_lang/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/language_controller.dart';

Future<Map<String, Map<String, String>> > init() async{

  final sharedPreference  = await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreference);
  Get.lazyPut(()=>LocalizationController(sharedPreferences: Get.find()));

  Map<String, Map<String, String>> _language = Map();
  for(LanguageModel languageModel in AppConstants.languages){
    String jsonStringValue = await rootBundle.loadString('assets/translations/${languageModel.lanhuageCode}.json');
    print("jsonStringValue: $jsonStringValue");
    Map<String,dynamic> _mappedJson = jsonDecode(jsonStringValue);
    Map<String,String> json = {};

    _mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    _language['${languageModel.lanhuageCode}_${languageModel.countryCode}'] =  json;
  }
  print("_language: $_language");

  return _language;
}