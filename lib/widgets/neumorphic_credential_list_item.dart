import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/routes/credential_route.dart';
import 'package:passman/services/credential_database.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:provider/provider.dart';
import 'alert.dart';

class NeumorphicCredentialListItem extends StatelessWidget {
  final Credential credential;
  final bool waiting;

  NeumorphicCredentialListItem(this.credential, {this.waiting = false});

  @override
  Widget build(BuildContext context) {
    final _database = Provider.of<AppDatabase>(context);

    final _titleTextStyle = TextStyle(
      fontSize:
          NeumorphicTheme.currentTheme(context).textTheme.headline6.fontSize,
      color: NeumorphicTheme.defaultTextColor(context),
    );

    final _subtitleTextStyle = TextStyle(
      fontSize:
          NeumorphicTheme.currentTheme(context).textTheme.caption.fontSize,
      color: NeumorphicTheme.defaultTextColor(context),
    );

    return InkWell(
      mouseCursor: SystemMouseCursors.basic,
      onTap: () {
        Navigator.of(context).pushNamed(
          CredentialRoute.routeName,
          arguments: {
            "viewMode": true,
            "credential": credential,
          },
        );
      },
      onLongPress: () {
        if (!waiting) {
          FlutterClipboard.copy(credential.account).then(
            (value) => Alert(context).showSnackBar(
              message: "Account copied to clipboard.",
            ),
          );
        }
      },
      splashColor: NeumorphicTheme.currentTheme(context).accentColor,
      child: Neumorphic(
        drawSurfaceAboveChild: false,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        style: NeumorphicStyle(
          lightSource: NeumorphicTheme.currentTheme(context).lightSource,
          depth: -5,
        ),
        child: ListTile(
          title: waiting
              ? Text(
                  "■ ■ ■",
                  style: _titleTextStyle,
                )
              : Text(credential.title, style: _titleTextStyle),
          subtitle: waiting
              ? Text(
                  "● ● ● ● ● ●",
                  style: _subtitleTextStyle,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      credential.account,
                      style: _subtitleTextStyle,
                    )
                  ],
                ),
          trailing: waiting
              ? Text("◣ ◥")
              : Row(
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
                            _database.deleteCredential(credential);
                            Navigator.of(context).pop();
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
    );
  }
}
