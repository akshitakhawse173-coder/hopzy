import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'feature/splash/view/splash_page.dart';
import 'navigation_service.dart';
import 'theme/app_color.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
RouteObserver<ModalRoute<void>>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GlobalLoaderOverlay(
          overlayColor: Colors.black54,
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) => Center(
            child: Image.asset(
              'assets/gif/loader.gif',
              width: 120.w,
              height: 120.h,
            ),
          ),
          child: RefreshConfiguration(
            headerBuilder: () => WaterDropHeader(
              waterDropColor: AppColors.primaryColor,
              refresh: SizedBox(
                width: 24,
                height: 24,
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            footerBuilder: () => const ClassicFooter(),
            child: MaterialApp(
              title: 'My New App',
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              navigatorObservers: [routeObserver],
              theme: ThemeData(
                useMaterial3: false,
                primaryColor: AppColors.primaryColor,
                scaffoldBackgroundColor: AppColors.whiteColor,
              ),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
              home: const SplashPage(),
            ),
          ),
        );
      },
    );
  }
}
