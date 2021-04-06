import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';

class Alert {
  final BuildContext context;

  Alert(this.context);

  void showSnackBar({
    @required String message,
  }) {
    final _snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(
          fontFamily: NeumorphicTheme.currentTheme(context)
              .textTheme
              .headline6
              .fontFamily,
          fontSize: NeumorphicTheme.currentTheme(context)
              .textTheme
              .headline6
              .fontSize,
          color: NeumorphicTheme.defaultTextColor(context),
        ),
      ),
      backgroundColor: NeumorphicTheme.currentTheme(context).shadowLightColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  void showActionDialog({
    @required String message,
    @required void Function() onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text(
            message,
            style: TextStyle(
              fontSize: NeumorphicTheme.currentTheme(context)
                  .textTheme
                  .headline6
                  .fontSize,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor:
              NeumorphicTheme.currentTheme(context).shadowLightColor,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicTextButton(
                  innerPadding: 10,
                  outerPadding: 10,
                  text: "Yes",
                  tooltip: "Permanently delete this credential",
                  onPressed: onConfirm,
                  icon: Icons.delete,
                  iconColor: Colors.red,
                ),
                NeumorphicTextButton(
                  innerPadding: 10,
                  outerPadding: 10,
                  text: "No",
                  tooltip: "Dismiss this message",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.cancel,
                  iconColor: NeumorphicTheme.defaultTextColor(context),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
