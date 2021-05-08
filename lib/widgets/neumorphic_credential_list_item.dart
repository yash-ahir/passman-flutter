import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/routes/credential_route.dart';
import 'package:passman/services/database.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:provider/provider.dart';
import 'alert.dart';

class NeumorphicCredentialListItem extends StatelessWidget {
  final Credential credential;

  NeumorphicCredentialListItem(this.credential);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    final titleTextStyle = TextStyle(
      fontSize:
          NeumorphicTheme.currentTheme(context).textTheme.headline6.fontSize,
      color: NeumorphicTheme.defaultTextColor(context),
    );

    final _subtitleTextStyle = TextStyle(
      fontSize:
          NeumorphicTheme.currentTheme(context).textTheme.caption.fontSize,
      color: NeumorphicTheme.defaultTextColor(context),
    );

    return Neumorphic(
      drawSurfaceAboveChild: false,
      margin: const EdgeInsets.all(10.0),
      style: NeumorphicStyle(
        lightSource: NeumorphicTheme.currentTheme(context).lightSource,
        depth: -5,
      ),
      child: Material(
        color: Color(0x000000),
        child: InkWell(
          mouseCursor: SystemMouseCursors.basic,
          onTap: () {
            Navigator.of(context).pushNamed(
              CredentialRoute.routeName,
              arguments: {
                "viewMode": ViewMode.read,
                "credential": credential,
              },
            );
          },
          onLongPress: () {
            FlutterClipboard.copy(credential.account).then(
              (value) => Alert(context).showSnackBar(
                message: "Account copied to clipboard.",
              ),
            );
          },
          splashColor: NeumorphicTheme.currentTheme(context).accentColor,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            title: Text(credential.title, style: titleTextStyle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  credential.account,
                  style: _subtitleTextStyle,
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NeumorphicIconButton(
                  icon: Icon(
                    Icons.copy,
                    color: NeumorphicTheme.accentColor(context),
                  ),
                  tooltip: "Copy password to clipboard",
                  onPressed: () {
                    FlutterClipboard.copy(credential.password).then(
                      (value) => Alert(context).showSnackBar(
                        message: "Password copied to clipboard.",
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                NeumorphicIconButton(
                  icon: Icon(
                    Icons.delete,
                    color: NeumorphicTheme.accentColor(context),
                  ),
                  tooltip: "Delete credential",
                  onPressed: () {
                    Alert(context).showActionDialog(
                      message:
                          "Delete credential? This action cannot be undone!",
                      onConfirm: () {
                        database.deleteCredential(credential);
                        Navigator.of(context).pop();
                        Alert(context).showSnackBar(
                            message: "Credential deleted successfully");
                      },
                      confirmText: "Yes",
                      confirmTooltip: "Permanently delete this credential",
                      confirmIcon: Icons.delete,
                      confirmIconColor: Colors.red,
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      cancelText: "No",
                      cancelTooltip: "Dismiss this message",
                      cancelIcon: Icons.cancel,
                      cancelIconColor:
                          NeumorphicTheme.defaultTextColor(context),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
