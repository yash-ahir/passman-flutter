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

  void showActionDialog(
      {@required String message,
      @required void Function() onConfirm,
      @required String confirmText,
      @required String confirmTooltip,
      @required IconData confirmIcon,
      Color confirmIconColor = Colors.green,
      @required void Function() onCancel,
      @required String cancelText,
      @required String cancelTooltip,
      @required IconData cancelIcon,
      Color cancelIconColor = Colors.red}) {
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
                  text: confirmText,
                  tooltip: confirmTooltip,
                  onPressed: onConfirm,
                  icon: confirmIcon,
                  iconColor: confirmIconColor,
                ),
                NeumorphicTextButton(
                  innerPadding: 10,
                  outerPadding: 10,
                  text: cancelText,
                  tooltip: cancelTooltip,
                  onPressed: onCancel,
                  icon: cancelIcon,
                  iconColor: cancelIconColor,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
