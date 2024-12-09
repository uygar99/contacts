import 'package:contacts/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes/pages.dart';
import 'app/routes/routes.dart';
import 'app/services/user_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
  }
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return GetMaterialApp(
            title: 'Contacts',
            theme: theme,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.contacts,
            getPages: pages,
            initialBinding: InitialBindings(),
          );
        });
    }
}