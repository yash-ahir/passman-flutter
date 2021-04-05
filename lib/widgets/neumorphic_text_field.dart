import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextField extends StatefulWidget {
  final double innerPadding;
  final double outerPadding;
  final int minLines;
  final int maxLines;
  final InputDecoration decoration;
  final bool obscureText;
  final String placeholderText;
  final String initialValue;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final void Function(String) onSaved;
  final AutovalidateMode autovalidateMode;

  NeumorphicTextField({
    @required this.validator,
    @required this.onChanged,
    @required this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.initialValue = "",
    this.innerPadding = 0,
    this.outerPadding = 0,
    this.minLines = 1,
    this.maxLines = 1,
    this.decoration = const InputDecoration(),
    this.obscureText = false,
    this.placeholderText = "",
  });

  @override
  _NeumorphicTextFieldState createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  final FocusNode _focusNode = FocusNode();

  double _depth = -5;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _depth = _focusNode.hasFocus ? 5 : -5;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: Container(
        padding: EdgeInsets.all(widget.outerPadding),
        child: Neumorphic(
          style: NeumorphicStyle(
            lightSource: NeumorphicTheme.currentTheme(context).lightSource,
            depth: _depth,
          ),
          padding: EdgeInsets.all(this.widget.innerPadding),
          child: TextFormField(
            initialValue: widget.initialValue,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            validator: widget.validator,
            autovalidateMode: widget.autovalidateMode,
            focusNode: _focusNode,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            decoration: widget.decoration.copyWith(
              hintText: widget.placeholderText,
              hintStyle: TextStyle(color: NeumorphicTheme.accentColor(context)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: NeumorphicTheme.isUsingDark(context)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            obscureText: widget.obscureText,
            style: TextStyle(
              fontSize: NeumorphicTheme.currentTheme(context)
                  .textTheme
                  .headline6
                  .fontSize,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
