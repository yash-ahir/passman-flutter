import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/routes/credential_route.dart';
import 'package:passman/routes/settings_route.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/neumorphic_credential_list_item.dart';
// Dummy data
import 'package:passman/dummy_data.dart';

class HomeRoute extends StatelessWidget {
  final String title;

  HomeRoute({
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final NeumorphicAppBar appBar = NeumorphicAppBar(
      textStyle: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
      leading: Image.asset("assets/images/logo.png"),
      title: Text(title),
      actionSpacing: 20,
      actions: [
        NeumorphicIconButton(
          tooltip: "Application settings",
          icon: Icon(
            Icons.settings,
            color: NeumorphicTheme.accentColor(context),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
              SettingsRoute.routeName,
            );
          },
        ),
        NeumorphicIconButton(
          tooltip: "Add new credential",
          icon: Icon(
            Icons.add,
            color: NeumorphicTheme.accentColor(context),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
              CredentialRoute.routeName,
            );
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (ctx, index) {
          return NeumorphicCredentialListItem(
            id: dummyData[index].id,
            title: dummyData[index].title,
            account: dummyData[index].account,
            password: dummyData[index].password,
            note: dummyData[index].note,
          );
        },
      ),
    );
  }
}
