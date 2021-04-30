import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/services/database.dart';
import 'package:passman/services/random_password_generator.dart';
import 'package:passman/widgets/neumorphic_password_field.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';

class NeumorphicPasswordFieldWithGenerator extends StatefulWidget {
  final bool readOnly;
  final bool fetchData;
  final void Function(String) onSaved;
  final double defaultOuterPadding;
  final double defaultInnerPadding;
  final Credential credential;

  NeumorphicPasswordFieldWithGenerator({
    @required this.readOnly,
    @required this.fetchData,
    @required this.onSaved,
    @required this.defaultOuterPadding,
    @required this.defaultInnerPadding,
    this.credential,
  });

  @override
  _NeumorphicPasswordFieldWithGeneratorState createState() =>
      _NeumorphicPasswordFieldWithGeneratorState();
}

class _NeumorphicPasswordFieldWithGeneratorState
    extends State<NeumorphicPasswordFieldWithGenerator> {
  var _currentValue = 8;

  TextEditingController _passwordFieldController;

  @override
  void initState() {
    super.initState();

    _passwordFieldController = TextEditingController(
      text: widget.fetchData ? widget.credential.password : "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          NeumorphicPasswordField(
            readOnly: widget.readOnly,
            maxLength: 256,
            initialValue: null,
            controller: _passwordFieldController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text.isEmpty) {
                return "Enter or generate a password";
              }
              return null;
            },
            onChanged: (text) {},
            onSaved: widget.onSaved,
            outerPadding: widget.defaultOuterPadding,
            innerPadding: widget.defaultInnerPadding,
            placeholderText: "Strong or random password",
          ),
          widget.readOnly
              ? Container()
              : NeumorphicTextButton(
                  text: "Generate random password",
                  icon: Icons.vpn_key,
                  iconColor: NeumorphicTheme.accentColor(context),
                  innerPadding: widget.defaultInnerPadding,
                  tooltip: "Generate a secure random password",
                  onPressed: () {
                    final pwRegExp = RegExp(
                      r"""^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~`!@#$%^&*()\[\]\-|_{}\\\/+=<>,.?:;\'"]).{8,}$""",
                      caseSensitive: false,
                      multiLine: false,
                    );

                    String generatedPasword = "";

                    while (!pwRegExp.hasMatch(generatedPasword)) {
                      generatedPasword =
                          RandomPasswordGenerator.generateRandomString(
                        length: _currentValue,
                      );
                    }

                    _passwordFieldController.text = generatedPasword;
                  },
                ),
          SizedBox(height: 15.0),
          widget.readOnly
              ? Container()
              : Text("Slide to select password length"),
          SizedBox(height: 15.0),
          widget.readOnly
              ? Container()
              : Neumorphic(
                  child: NumberPicker(
                    selectedTextStyle: TextStyle(
                      color: NeumorphicTheme.accentColor(context),
                    ),
                    haptics: true,
                    infiniteLoop: true,
                    axis: Axis.horizontal,
                    minValue: 8,
                    maxValue: 256,
                    value: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
