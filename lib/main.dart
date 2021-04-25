import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/routes/credential_route.dart';
import 'package:passman/routes/home_route.dart';
import 'package:passman/routes/lock_screen_route.dart';
import 'package:passman/routes/settings_route.dart';
import 'package:passman/services/app_locker.dart';
import 'package:passman/services/credential_database.dart';
import 'package:passman/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(
      EasyDynamicThemeWidget(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _title = "PassMan";

    return Provider(
      create: (_) => AppDatabase(),
      child: NeumorphicApp(
        theme: NeumorphicThemes.lightTheme,
        darkTheme: NeumorphicThemes.darkTheme,
        themeMode: EasyDynamicTheme.of(context).themeMode,
        debugShowCheckedModeBanner: false,
        title: _title,
        routes: {
          SettingsRoute.routeName: (ctx) => SettingsRoute(),
          CredentialRoute.routeName: (ctx) => CredentialRoute(),
        },
        home: AppLocker(
          appRouteBuilder: (_) => HomeRoute(title: _title),
          lockScreenBuilder: (_, unlocker) =>
              LockScreenRoute(title: _title, unlocker: unlocker),
        ),
        builder: (context, widget) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: NeumorphicTheme.baseColor(context),
              statusBarColor: NeumorphicTheme.baseColor(context),
              statusBarBrightness: NeumorphicTheme.isUsingDark(context)
                  ? Brightness.light
                  : Brightness.dark,
              statusBarIconBrightness: NeumorphicTheme.isUsingDark(context)
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarDividerColor:
                  NeumorphicTheme.baseColor(context),
              systemNavigationBarIconBrightness:
                  NeumorphicTheme.isUsingDark(context)
                      ? Brightness.light
                      : Brightness.dark,
            ),
          );

          return ResponsiveWrapper.builder(
            widget,
            minWidth: 450,
            backgroundColor: Color(0x00),
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(450, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
          );
        },
      ),
    );
  }
}
