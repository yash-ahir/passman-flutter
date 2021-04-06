import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/alert.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';
import 'package:passman/widgets/neumorphic_text_field.dart';
import 'package:passman/widgets/neumorphic_password_field.dart';

class SettingsRoute extends StatelessWidget {
  static String routeName = "/settings-route";

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
      body: SingleChildScrollView(),
    );
  }
}
