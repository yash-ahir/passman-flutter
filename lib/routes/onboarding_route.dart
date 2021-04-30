import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:passman/models/app_state.dart';
import 'package:passman/models/unhashed_password.dart';
import 'package:passman/routes/home_route.dart';
import 'package:passman/services/crypt.dart';
import 'package:passman/services/database.dart';
import 'package:passman/widgets/alert.dart';
import 'package:passman/widgets/neumorphic_password_field.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class OnboardingRoute extends StatelessWidget {
  static String routeName = "/onboarding-route";

  final String title;

  Future _storeMasterPassword(BuildContext context, String password) async {
    final database = Provider.of<AppDatabase>(context, listen: false);

    compute(
      Crypt.hash,
      [password, IV.fromSecureRandom(16).base64],
    ).then(
      (hashedData) async {
        Navigator.pop(context);

        database.insertMasterPassword(
          MasterPassword(
            hashedPassword: hashedData["hashedMasterPassword"],
            salt: hashedData["salt"],
          ),
        );

        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool("onboardingComplete", true);
        Provider.of<AppState>(context, listen: false).setStartUp(false);

        Provider.of<UnhashedPassword>(
          context,
          listen: false,
        ).setUnhashedPassword(password);

        Navigator.of(context).pushReplacementNamed(HomeRoute.routeName);
      },
    );

    Alert(context).showLoadingDialog(message: "Authenticating...");
  }

  OnboardingRoute({@required this.title});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appBar = NeumorphicAppBar(
      textStyle: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
      leading: Image.asset("assets/images/logo.png"),
      title: Text(title),
    );

    String password;
    String confirmPassword;

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
        body: Scrollbar(
          isAlwaysShown: true,
          interactive: true,
          showTrackOnHover: true,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Welcome To PassMan!",
                    textAlign: TextAlign.center,
                    style: NeumorphicTheme.currentTheme(context)
                        .textTheme
                        .bodyText1,
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "It seems you're starting the application for the first time, please set a strong master password to proceed.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 35.0),
                  Text("Master Password"),
                  NeumorphicPasswordField(
                    readOnly: false,
                    maxLength: 32,
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
                  Text("Confirm Master Password"),
                  NeumorphicPasswordField(
                    readOnly: false,
                    maxLength: 32,
                    initialValue: "",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Enter your master password again to confirm";
                      }
                      return null;
                    },
                    onChanged: (text) {},
                    onSaved: (text) {
                      confirmPassword = text;
                    },
                    outerPadding: defaultOuterPadding,
                    innerPadding: defaultInnerPadding,
                    placeholderText: "Your master password",
                  ),
                  NeumorphicTextButton(
                    text: "Set Master Password",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        if (password != confirmPassword) {
                          Alert(context).showAlertDialog(
                            message: "Passwords do not match, try again.",
                            onConfirm: () {
                              Navigator.pop(context);
                            },
                            confirmText: "Ok",
                            confirmTooltip: "Dismiss this message",
                            confirmIcon: Icons.error,
                            confirmIconColor: Colors.red,
                          );
                        } else {
                          final shortPwRegExp = RegExp(
                            r"""^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~`!@#$%^&*()\[\]\-|_{}\\\/+=<>,.?:;\'"]).{8,}$""",
                            caseSensitive: false,
                            multiLine: false,
                          );
                          final longPwRegExp = RegExp(
                            r"""^(?=.*?[A-Z])(?=.*?[a-z]).{24,}$""",
                            caseSensitive: false,
                            multiLine: false,
                          );

                          if (!(shortPwRegExp.hasMatch(password) ||
                              longPwRegExp.hasMatch(password))) {
                            Alert(context).showAlertDialog(
                              message:
                                  "Weak password detected\n\n\nUse a password with atleast an uppercase character, a lowercase character, a number, and a special character from ~`!@#\$%^&*-_+=()[]{}:;\"'<>,./|? with atleast 16 characters.\n\nOr with an uppercase character and a lowercase character if longer than 24.\n\nMaximum length is 32 characters.",
                              onConfirm: () {
                                Navigator.pop(context);
                              },
                              confirmText: "Ok",
                              confirmTooltip: "Dismiss this warning",
                              confirmIcon: Icons.error,
                              confirmIconColor: Colors.red,
                            );
                          } else {
                            _storeMasterPassword(context, password);
                          }
                        }
                      }
                    },
                    icon: Icons.enhanced_encryption,
                    iconColor: NeumorphicTheme.accentColor(context),
                    outerPadding: defaultOuterPadding,
                    innerPadding: defaultInnerPadding,
                    tooltip: "Set a master password",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
