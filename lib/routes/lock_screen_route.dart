import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/models/plain_text_password_data.dart';
import 'package:passman/services/crypt.dart';
import 'package:passman/services/database.dart';
import 'package:passman/widgets/alert.dart';
import 'package:passman/widgets/neumorphic_password_field.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';
import 'package:provider/provider.dart';

class LockScreenRoute extends StatelessWidget {
  static String routeName = "/lock-screen-route";

  final String title;
  final void Function() unlocker;
  LockScreenRoute({@required this.title, @required this.unlocker});

  Future _authenticate(BuildContext context, String password) async {
    final database = Provider.of<AppDatabase>(context, listen: false);

    final storedMasterPassword = await database.getMasterPassword();

    compute(
      Crypt.hash,
      [password, storedMasterPassword.salt],
    ).then(
      (hashedData) {
        Navigator.pop(context);

        if (hashedData["hashedMasterPassword"] ==
            storedMasterPassword.hashedPassword) {
          Provider.of<PlainTextPasswordData>(
            context,
            listen: false,
          ).setUnhashedMasterPassword(password);

          unlocker();
        } else {
          Alert(context).showAlertDialog(
            message: "Invalid password, please try again",
            onConfirm: () {
              Navigator.pop(context);
            },
            confirmText: "Ok",
            confirmTooltip: "Dismiss this message",
            confirmIcon: Icons.error,
            confirmIconColor: Colors.red,
          );
        }
      },
    );

    Alert(context).showLoadingDialog(message: "Authenticating...");
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appBar = NeumorphicAppBar(
      textStyle: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
      leading: Image.asset("assets/images/logo.png"),
      title: Text(title),
    );

    String password;

    final defaultOuterPadding = 15.0;
    final defaultInnerPadding = 15.0;

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
                Text("Master Password"),
                NeumorphicPasswordField(
                  readOnly: false,
                  maxLength: 256,
                  initialValue: "",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Enter your master password to proceed";
                    }
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    password = text;
                  },
                  outerPadding: defaultOuterPadding,
                  innerPadding: defaultInnerPadding,
                  placeholderText: "Your master password",
                ),
                NeumorphicTextButton(
                  text: "Authenticate",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _authenticate(context, password);
                    }
                  },
                  icon: Icons.vpn_key,
                  iconColor: NeumorphicTheme.accentColor(context),
                  outerPadding: defaultOuterPadding,
                  innerPadding: defaultInnerPadding,
                  tooltip: "Authenticate to access your credentials",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
