import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextButton extends StatelessWidget {
  final double innerPadding;
  final double outerPadding;
  final String tooltip;
  final String text;
  final IconData icon;
  final Color iconColor;
  final NeumorphicStyle style;
  final void Function() onPressed;

  NeumorphicTextButton({
    @required this.text,
    @required this.onPressed,
    @required this.icon,
    @required this.iconColor,
    this.innerPadding = 0,
    this.outerPadding = 0,
    this.tooltip = "",
    this.style = const NeumorphicStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(outerPadding),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: NeumorphicButton(
          minDistance: -5,
          tooltip: tooltip,
          padding: EdgeInsets.all(innerPadding),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width * 0.025),
                ),
                Text(
                  text,
                ),
              ],
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            onPressed();
          },
          style: style,
        ),
      ),
    );
  }
}
