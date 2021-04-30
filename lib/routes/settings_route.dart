import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';
import 'package:passman/widgets/system_theme_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsRoute extends StatefulWidget {
  static String routeName = "/settings-route";

  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  final _defaultInnerPadding = 15.0;
  final _defaultOuterPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    final NeumorphicAppBar appBar = NeumorphicAppBar(
      leading: NeumorphicIconButton(
        icon: Icon(
          Icons.arrow_back,
          color: NeumorphicTheme.accentColor(context),
        ),
        tooltip: "Go back",
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      textStyle: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
      title: Text("Settings"),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SystemThemePicker(),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Miscellaneous information",
              style: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10.0,
            ),
            NeumorphicTextButton(
              text: "Github Repository",
              icon: Icons.source,
              iconColor: NeumorphicTheme.accentColor(context),
              innerPadding: _defaultInnerPadding,
              outerPadding: _defaultOuterPadding,
              onPressed: () async {
                await launch("https://github.com/yash-ahir/passman-flutter");
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Developed by Yash Ahir",
              style: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 10.0,
            ),
            NeumorphicTextButton(
              text: "More about me on my website",
              icon: Icons.person,
              iconColor: NeumorphicTheme.accentColor(context),
              innerPadding: _defaultInnerPadding,
              outerPadding: _defaultOuterPadding,
              onPressed: () async {
                await launch("https://yashahir.tech");
              },
            ),
            NeumorphicTextButton(
              text: "Send me an E-mail",
              icon: Icons.email,
              iconColor: NeumorphicTheme.accentColor(context),
              innerPadding: _defaultInnerPadding,
              outerPadding: _defaultOuterPadding,
              onPressed: () async {
                await launch("mailto:email@yashahir.tech");
              },
            ),
          ],
        ),
      ),
    );
  }
}
