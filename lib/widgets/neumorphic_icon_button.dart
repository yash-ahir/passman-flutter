import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicIconButton extends StatelessWidget {
  final Icon icon;
  final String tooltip;
  final void Function() onPressed;
  final NeumorphicStyle style;

  NeumorphicIconButton({
    @required this.icon,
    @required this.onPressed,
    this.tooltip = "",
    this.style = const NeumorphicStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: NeumorphicButton(
        minDistance: -5,
        tooltip: tooltip,
        child: icon,
        onPressed: () => onPressed(),
        style: style,
      ),
    );
  }
}
