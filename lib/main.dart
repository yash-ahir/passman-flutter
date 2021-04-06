import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/routes/home_route.dart';
import 'package:passman/routes/credential_route.dart';
import 'package:passman/routes/settings_route.dart';
import 'package:passman/themes/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = "PassMan";

    return NeumorphicApp(
      theme: NeumorphicThemes.lightTheme,
      darkTheme: NeumorphicThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: title,
      routes: {
        SettingsRoute.routeName: (ctx) => SettingsRoute(),
        CredentialRoute.routeName: (ctx) => CredentialRoute(),
      },
      home: HomeRoute(
        title: title,
      ),
      builder: (context, widget) {
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
    );
  }
}
