import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/models/plain_text_password_data.dart';
import 'package:passman/routes/credential_route.dart';
import 'package:passman/routes/settings_route.dart';
import 'package:passman/services/crypt.dart';
import 'package:passman/widgets/neumorphic_credential_list.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/services/database.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  static String routeName = "/home-route";

  final String title;

  HomeRoute({
    @required this.title,
  });

  Future<List<Credential>> _decryptData(
      BuildContext context, List<Credential> encryptedCredentials) async {
    final crypt = Crypt(
      masterPass: Provider.of<PlainTextPasswordData>(context)
          .getUnhashedMasterPassword(),
    );

    List<Credential> credentials = [];

    for (Credential credential in encryptedCredentials) {
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

      credentials.add(
        Credential(
          id: credential.id,
          title: title,
          titleIv: credential.titleIv,
          account: account,
          accountIv: credential.accountIv,
          password: password,
          passwordIv: credential.passwordIv,
          note: note,
          noteIv: credential.noteIv,
        ),
      );
    }

    return credentials;
  }

  @override
  Widget build(BuildContext context) {
    final appBar = NeumorphicAppBar(
      textStyle: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
      leading: Image.asset("assets/images/logo.png"),
      title: Text(title),
      actionSpacing: 20.0,
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

          return FutureBuilder(
            future: _decryptData(context, credentials),
            builder: (ctx, AsyncSnapshot<List<Credential>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final decryptedPasswords = List<String>.empty(growable: true);

                for (Credential credential in snapshot.data) {
                  decryptedPasswords.add(credential.password);
                }

                Provider.of<PlainTextPasswordData>(context)
                    .setPlainTextPasswords(decryptedPasswords);

                return NeumorphicCredentialList(
                  credentials: snapshot.data,
                );
              }

              return Center(child: CircularProgressIndicator());
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
