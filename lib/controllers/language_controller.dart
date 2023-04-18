import 'dart:ui';

import 'package:get/get.dart';
import 'package:multi_lang/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/language_model.dart';

class LocalizationController extends GetxController implements GetxService {
  late final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguages();
  }

   Locale _locale = Locale(AppConstants.languages[0].lanhuageCode, AppConstants.languages[0].countryCode);

  int _selectedIndex = 0;

  int get selectedIndex=> _selectedIndex;

  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;

  Locale get local=>_locale;

  loadCurrentLanguages() {
    // only get called during installation or reboot
    _locale = Locale(
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE)??AppConstants.languages[0].lanhuageCode,
        sharedPreferences.getString(AppConstants.COUNTRY_CODE)??AppConstants.languages[0].countryCode);

    for(int index = 0; index<AppConstants.languages.length; index++){
      print("LOOP: ${AppConstants.languages[index].lanhuageCode } ${_locale.languageCode}");
      if(AppConstants.languages[index].lanhuageCode ==_locale.languageCode){
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  setLanguage(Locale locale){
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }
  setSelectIndex(int index){
    _selectedIndex =  index;
    update();
  }

  saveLanguage(Locale locale) async{
    sharedPreferences.setString(AppConstants.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(AppConstants.COUNTRY_CODE, locale.countryCode??"");
  }
}
