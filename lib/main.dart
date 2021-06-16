import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_mindelo/utils/services/storage.service.dart';
import 'package:uni_mindelo/views/home/home.dart';
import 'dart:ui' as ui;
//Views
import './views/auth/login/login.dart';
import 'components/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'pt', supportedLocales: ['pt']);
  await GetStorage.init();

  //Remove Death Red Screen DEBUG
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container();
  };
  runApp(LocalizedApp(delegate, Main()));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        localizationsDelegates: [localizationDelegate],
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primaryColor: PrimaryColor,
          scaffoldBackgroundColor: PrimaryWhiteAssentColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('erro ${snapshot.error.toString()}');
                return Text("erro");
              } else if (snapshot.hasData) {
                if (getData(user_uid) != null) {
                  return Home();
                } else {
                  return Login();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        builder: EasyLoading.init(),
      ),
    );
  }
}
