import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:univy_mobile/db/db_helper.dart';
import 'package:univy_mobile/providers/auth_service.dart';
import 'package:univy_mobile/providers/user_provider.dart';
import 'package:univy_mobile/services/processRequest_services.dart';
import 'package:univy_mobile/services/processStages_services.dart';
import 'package:univy_mobile/services/process_service.dart';

import 'package:univy_mobile/ui/pages/loginPage.dart';
import 'package:univy_mobile/ui/pages/task_manager/theme.dart';

void setUpLocator() {

  GetIt.instance.registerLazySingleton(() => ProcessServices());
  GetIt.instance.registerLazySingleton(() => ProcessStageServices());
  GetIt.instance.registerLazySingleton(() => AuthServices());
  GetIt.instance.registerLazySingleton(() => ProcessRequestServices());
  // GetIt.instance.registerLazySingleton(() => ProcessServices());
  // GetIt.instance.registerLazySingleton(() => StageServices());
  // GetIt.instance.registerLazySingleton(() => ProcessStageServices());
}
Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.iniDB();
  await GetStorage.init();
  setUpLocator();
  runApp(MultiProvider( providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ],child: MyApp()));
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "جامعتي",
      //themeMode: ThemeMode.dark,
      // darkTheme: ThemeData(
      //     primaryColor: AppColor.mainColor,
      //     brightness: Brightness.dark,
        // fontFamily: "Lemonada",

      //
      // ),

      theme: Themes.light,
      darkTheme: Themes.dart,
      themeMode: ThemeMode.light,
     //home: HomePage(),
      home: LoginPage(),
    );
  }
}