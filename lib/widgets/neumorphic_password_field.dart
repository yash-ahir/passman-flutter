import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/neumorphic_text_field.dart';

class NeurmophicPasswordField extends StatefulWidget {
  final double outerPadding;
  final double innerPadding;
  final String placeholderText;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final void Function(String) onSaved;
  final AutovalidateMode autovalidateMode;

  NeurmophicPasswordField({
    @required this.validator,
    @required this.onChanged,
    @required this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.outerPadding = 0,
    this.innerPadding = 0,
    this.placeholderText = "",
  });

  @override
  _NeurmophicPasswordFieldState createState() =>
      _NeurmophicPasswordFieldState();
}

class _NeurmophicPasswordFieldState extends State<NeurmophicPasswordField> {
  bool _obscurity = true;

  @override
  Widget build(BuildContext context) {
    return NeumorphicTextField(
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      validator: widget.validator,
      outerPadding: widget.outerPadding,
      innerPadding: widget.innerPadding,
      placeholderText: widget.placeholderText,
      obscureText: _obscurity,
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