import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_lang/model/language_model.dart';
import 'package:multi_lang/utils/app_constant.dart';

import '../controllers/language_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Lang? _lang = Lang.English;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GetBuilder<LocalizationController>(
              builder: (localizationController) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) => langCard(
                      languageModel: localizationController.languages[index],
                      localizationController: localizationController,
                      index: index
                  ),
                ),
                Text("msg".tr)
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget langCard(
      {required LanguageModel languageModel,
      required LocalizationController localizationController,
      required int index}) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(
          Locale(
            AppConstants.languages[index].lanhuageCode,
            AppConstants.languages[index].countryCode,
          )
        );
        localizationController.setSelectIndex(index);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Row(
          children:  [
            Text(languageModel.languageName),
            const SizedBox(width: 10,),
            localizationController.selectedIndex==index?
            const Icon(Icons.check_circle,color: Colors.blue,)
                :const SizedBox()
          ],
        ),
      ),
    );
  }
}

enum Lang { English, Hindi }
