import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:clipboard/clipboard.dart';
import 'alert.dart';

class NeumorphicCredentialListItem extends StatelessWidget {
  final String id;
  final String title;
  final String account;
  final String password;
  final String note;

  NeumorphicCredentialListItem({
    @required this.id,
    @required this.title,
    @required this.account,
    @required this.password,
    @required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onLongPress: () {
        FlutterClipboard.copy(account).then(
          (value) => Alert(context).showSnackBar(
            message: "Account copied to clipboard.",
          ),
        );
      },
      splashColor: NeumorphicTheme.currentTheme(context).accentColor,
      child: Neumorphic(
        drawSurfaceAboveChild: false,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        style: NeumorphicStyle(
          lightSource: NeumorphicTheme.currentTheme(context).lightSource,
          depth: -5,
        ),
        child: ListTile(
          title: Text(
            this.title,
            style: TextStyle(
              fontSize: NeumorphicTheme.currentTheme(context)
                  .textTheme
                  .headline6
                  .fontSize,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.account,
                style: TextStyle(
                  fontSize: NeumorphicTheme.currentTheme(context)
                      .textTheme
                      .caption
                      .fontSize,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
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
                  FlutterClipboard.copy(password).then(
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
                    message: "Delete credential? This action cannot be undone!",
                    onConfirm: () {},
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
                    cancelIconColor: NeumorphicTheme.defaultTextColor(context),
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
