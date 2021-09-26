import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../constants/colors.dart';

showLoader() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 60
    ..radius = 20
    ..backgroundColor = PrimaryWhiteAssentColor
    ..indicatorColor = PrimaryColor
    ..maskColor = PrimaryColor.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  EasyLoading.show(status: translate('LOADER_TITLE'));
}

dismissLoader() {
  EasyLoading.dismiss();
}
