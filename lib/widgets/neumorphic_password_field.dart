import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/neumorphic_text_field.dart';

class NeumorphicPasswordField extends StatefulWidget {
  final double outerPadding;
  final double innerPadding;
  final String placeholderText;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final void Function(String) onSaved;
  final AutovalidateMode autovalidateMode;
  final bool readOnly;
  final int maxLength;
  final String initialValue;
  final TextEditingController controller;

  NeumorphicPasswordField({
    @required this.validator,
    @required this.onChanged,
    @required this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.outerPadding = 0,
    this.innerPadding = 0,
    this.placeholderText = "",
    this.initialValue = "",
    this.readOnly = false,
    this.maxLength,
    this.controller,
  });

  @override
  _NeumorphicPasswordFieldState createState() =>
      _NeumorphicPasswordFieldState();
}

class _NeumorphicPasswordFieldState extends State<NeumorphicPasswordField> {
  bool _obscurity = true;

  @override
  Widget build(BuildContext context) {
    return NeumorphicTextField(
      controller: widget.controller,
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      validator: widget.validator,
      outerPadding: widget.outerPadding,
      innerPadding: widget.innerPadding,
      placeholderText: widget.placeholderText,
      obscureText: _obscurity,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          color: NeumorphicTheme.accentColor(context),
          onPressed: () {
            setState(
              () {
                _obscurity = !_obscurity;
              },
            );
          },
          icon:
              _obscurity ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
