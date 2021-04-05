import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flash/flash.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';

class Alert {
  final BuildContext context;
  final double innerPadding;
  final double outerPadding;

  Alert(
    this.context, {
    this.innerPadding = 0,
    this.outerPadding = 0,
  });

  void showSnackBar({
    @required String message,
  }) {
    showFlash(
      duration: Duration(seconds: 2),
      context: context,
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          backgroundColor:
              NeumorphicTheme.currentTheme(context).shadowLightColor,
          borderRadius: BorderRadius.circular(10),
          enableDrag: true,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          margin: const EdgeInsets.all(10),
          forwardAnimationCurve: Curves.easeIn,
          reverseAnimationCurve: Curves.easeOut,
          child: FlashBar(
            message: Text(
              message,
              style: TextStyle(
                fontSize: NeumorphicTheme.currentTheme(context)
                    .textTheme
                    .headline6
                    .fontSize,
                color: NeumorphicTheme.defaultTextColor(context),
              ),
            ),
          ),
        );
      },
    );
  }

  void showDialog({
    @required String message,
    @required void Function() onConfirm,
  }) {
    showFlash(
      context: context,
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          backgroundColor:
              NeumorphicTheme.currentTheme(context).shadowLightColor,
          borderRadius: BorderRadius.circular(10),
          enableDrag: false,
          margin: const EdgeInsets.all(10),
          forwardAnimationCurve: Curves.easeIn,
          reverseAnimationCurve: Curves.easeOut,
          child: FlashBar(
            message: Text(
              message,
              style: TextStyle(
                fontSize: NeumorphicTheme.currentTheme(context)
                    .textTheme
                    .headline6
                    .fontSize,
                color: NeumorphicTheme.defaultTextColor(context),
              ),
            ),
            actions: [
              NeumorphicTextButton(
                innerPadding: this.innerPadding,
                outerPadding: this.outerPadding,
                text: "Yes",
                tooltip: "Permanently delete this credential",
                onPressed: onConfirm,
                icon: Icons.delete,
                iconColor: Colors.red,
              ),
              NeumorphicTextButton(
                innerPadding: this.innerPadding,
                outerPadding: this.outerPadding,
                text: "No",
                tooltip: "Dismiss this message",
                onPressed: () {
                  controller.dismiss();
                },
                icon: Icons.cancel,
                iconColor: NeumorphicTheme.defaultTextColor(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
