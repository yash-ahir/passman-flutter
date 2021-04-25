import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/routes/credential_route.dart';
import 'package:passman/routes/settings_route.dart';
import 'package:passman/services/crypt.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/neumorphic_credential_list_item.dart';
import 'package:passman/services/credential_database.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  static String routeName = "/home-route";

  final String title;

  HomeRoute({
    @required this.title,
  });

  Future<Credential> _decryptData(Credential credential) async {
    final crypt = Crypt(masterPass: "Alpha Bravo Charlie Delta");
    final title = await crypt.decrypt(
      cipherText: credential.title,
      iv: credential.titleIv,
    );
    final account = await crypt.decrypt(
      cipherText: credential.account,
      iv: credential.accountIv,
    );
    final password = await crypt.decrypt(
      cipherText: credential.password,
      iv: credential.passwordIv,
    );
    final note = credential.note != null
        ? await crypt.decrypt(
            cipherText: credential.note, iv: credential.noteIv)
        : credential.note;

    return Credential(
      id: credential.id,
      title: title,
      titleIv: credential.titleIv,
      account: account,
      accountIv: credential.accountIv,
      password: password,
      passwordIv: credential.passwordIv,
      note: note,
      noteIv: credential.noteIv,
    );
  }

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
      body: _buildCredentialList(context),
    );
  }

  Widget _buildCredentialList(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return StreamBuilder(
      stream: database.watchAllCredentials(),
      builder: (context, AsyncSnapshot<List<Credential>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final credentials = snapshot.data;
          if (credentials.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "No credentials added. Press the + button on the top-right to get started!",
                  textAlign: TextAlign.center,
                  style:
                      NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: credentials.length,
            itemBuilder: (ctx, index) {
              return FutureBuilder(
                future: _decryptData(credentials[index]),
                builder: (ctx, AsyncSnapshot<Credential> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return NeumorphicCredentialListItem(snapshot.data);
                  }
                  return NeumorphicCredentialListItem(
                    snapshot.data,
                    waiting: true,
                  );
                },
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
