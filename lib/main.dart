import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:multi_lang/controllers/messages.dart';
import 'package:multi_lang/screens/HomePage.dart';
import 'package:multi_lang/utils/app_constant.dart';

import 'controllers/language_controller.dart';
import 'utils/dep.dart' as dep;

main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await dep.init();
  print("languages main: $languages");
  runApp(MyApp(languages: languages,));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocalizationController>(builder: (localizationController) {

      return GetMaterialApp(
        locale:  localizationController?.local,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.languages[0].lanhuageCode,AppConstants.languages[0].countryCode ),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      );

    },);

  }
}


