import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/system_theme_picker.dart';

// FOR DEVELOPMENT
import 'package:provider/provider.dart';
import 'package:passman/services/database.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';

class SettingsRoute extends StatefulWidget {
  static String routeName = "/settings-route";

  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
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
      actions: [
        // FOR DEVELOPMENT
        NeumorphicIconButton(
          icon: Icon(
            Icons.developer_mode,
            color: NeumorphicTheme.accentColor(context),
          ),
          tooltip: "View table",
          onPressed: () {
            final database = Provider.of<AppDatabase>(context, listen: false);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => MoorDbViewer(database)));
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          SingleChildScrollView(
            child: SystemThemePicker(),
          ),
        ],
      ),
    );
  }
}
