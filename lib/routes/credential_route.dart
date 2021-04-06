import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/widgets/alert.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';
import 'package:passman/widgets/neumorphic_text_field.dart';
import 'package:passman/widgets/neumorphic_password_field.dart';

class CredentialRoute extends StatelessWidget {
  static String routeName = "/credential-route";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final NeumorphicAppBar appBar = NeumorphicAppBar(
      leading: NeumorphicIconButton(
        icon: Icon(
          Icons.arrow_back,
          color: NeumorphicTheme.accentColor(context),
        ),
        tooltip: "Go back",
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      textStyle: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
      title: Text("Add new credential"),
    );

    final double _defaultOuterPadding = 15;
    final double _defaultInnerPadding = 15;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Title"),
                NeumorphicTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Enter the title";
                    }
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    print(text);
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  placeholderText: "Title/name of credential",
                ),
                Text("Account"),
                NeumorphicTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Enter the account name";
                    }
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    print(text);
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  placeholderText: "Account name (e.g. E-mail, username, etc.)",
                ),
                Text("Password"),
                NeurmophicPasswordField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Enter or generate a password";
                    }

                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    final pwRegExp = RegExp(r"""
                    ^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~`!@#$%^&*()\[\]\-|_{}\\\/+=<>,.?:;"']).{8,}$
                    """);

                    if (!pwRegExp.hasMatch(text)) {
                      // "If possible, use a password with atleast an uppercase character," +
                      // " a lowercase character, a number," +
                      // " and a special character from ~`!@#\$%^&*-_+=()[]{}:;\"'<>,./|?";
                    }
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  placeholderText: "Strong or random password",
                ),
                NeumorphicTextButton(
                  text: "Generate random password",
                  icon: Icons.vpn_key,
                  iconColor: NeumorphicTheme.accentColor(context),
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  tooltip: "Generate a secure random password",
                  onPressed: () {},
                ),
                Text("Note (Optional)"),
                NeumorphicTextField(
                  validator: (text) {
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    print(text);
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  minLines: 1,
                  maxLines: 5,
                  placeholderText: "Additional notes about this credential",
                ),
                NeumorphicTextButton(
                  text: "Add credential",
                  icon: Icons.enhanced_encryption,
                  iconColor: NeumorphicTheme.accentColor(context),
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  tooltip: "Add this credential to PassMan",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      Alert(context).showSnackBar(
                        message: "Credential added successfully",
                      );

                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
