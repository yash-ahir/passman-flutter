import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/models/unhashed_password.dart';
import 'package:passman/services/database.dart';
import 'package:passman/services/crypt.dart';
import 'package:passman/widgets/alert.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/neumorphic_password_field_with_generator.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';
import 'package:passman/widgets/neumorphic_text_field.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

enum ViewMode {
  create,
  read,
  update,
}

class CredentialRoute extends StatelessWidget {
  static String routeName = "/credential-route";
  final _formKey = GlobalKey<FormState>();

  Future<Credential> _encryptData({
    @required Crypt crypt,
    @required String id,
    @required String title,
    @required String account,
    @required String password,
    String note,
  }) async {
    final titleData = await crypt.encrypt(plainText: title);
    final accountData = await crypt.encrypt(plainText: account);
    final passwordData = await crypt.encrypt(plainText: password);
    Map<String, String> noteData = {};
    if (note != null) {
      noteData = await crypt.encrypt(plainText: note);
    }

    return Credential(
      id: id,
      title: titleData["cipherText"],
      titleIv: titleData["iv"],
      account: accountData["cipherText"],
      accountIv: accountData["iv"],
      password: passwordData["cipherText"],
      passwordIv: passwordData["iv"],
      note: noteData["cipherText"],
      noteIv: noteData["iv"],
    );
  }

  void _finalizeCredentialData({
    @required BuildContext context,
    @required AppDatabase database,
    @required Crypt crypt,
    @required String id,
    @required String title,
    @required String account,
    @required String password,
    @required bool update,
    String note,
  }) {
    _encryptData(
      crypt: crypt,
      id: id,
      title: title,
      account: account,
      password: password,
      note: note,
    ).then(
      (credential) => update
          ? database.updateCredential(credential)
          : database.insertCredential(credential),
    );

    Alert(context).showSnackBar(
      message: update
          ? "Credential updated successfully"
          : "Credential added successfully",
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final crypt = Crypt(
      masterPass: Provider.of<UnhashedPassword>(context).getUnhashedPassword(),
    );

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object> ?? {};
    final viewMode = routeArgs["viewMode"] ?? ViewMode.create;

    String appBarTitle;
    bool fetchData;
    bool readOnly;
    switch (viewMode) {
      case ViewMode.read:
        {
          appBarTitle = "Viewing credential";
          readOnly = true;
          fetchData = true;
        }
        break;

      case ViewMode.update:
        {
          appBarTitle = "Editing credential";
          readOnly = false;
          fetchData = true;
        }
        break;

      default:
        {
          appBarTitle = "Create new credential";
          readOnly = false;
          fetchData = false;
        }
        break;
    }

    final credential = routeArgs["credential"] as Credential;

    String title;
    String account;
    String password;
    String note;

    final appBar = NeumorphicAppBar(
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
      title: Text(appBarTitle),
      actions: [
        readOnly
            ? NeumorphicIconButton(
                icon: Icon(
                  Icons.edit,
                  color: NeumorphicTheme.accentColor(context),
                ),
                tooltip: "Edit credential",
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    routeName,
                    arguments: {
                      "viewMode": ViewMode.update,
                      "credential": credential,
                    },
                  );
                },
              )
            : Container(),
      ],
    );

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
                  Text("Title"),
                  NeumorphicTextField(
                    readOnly: readOnly,
                    maxLength: 128,
                    initialValue: fetchData ? credential.title : "",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Enter the title";
                      }
                      return null;
                    },
                    onChanged: (text) {},
                    onSaved: (text) {
                      title = text;
                    },
                    outerPadding: defaultOuterPadding,
                    innerPadding: defaultInnerPadding,
                    placeholderText: "Title/name of credential",
                  ),
                  Text("Account"),
                  NeumorphicTextField(
                    readOnly: readOnly,
                    maxLength: 256,
                    initialValue: fetchData ? credential.account : "",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Enter the account name";
                      }
                      return null;
                    },
                    onChanged: (text) {},
                    onSaved: (text) {
                      account = text;
                    },
                    outerPadding: defaultOuterPadding,
                    innerPadding: defaultInnerPadding,
                    placeholderText:
                        "Account name (e.g. E-mail, username, etc.)",
                  ),
                  Text("Password"),
                  NeumorphicPasswordFieldWithGenerator(
                    readOnly: readOnly,
                    fetchData: fetchData,
                    defaultInnerPadding: defaultInnerPadding,
                    defaultOuterPadding: defaultOuterPadding,
                    credential: credential,
                    onSaved: (text) {
                      password = text;
                    },
                  ),
                  Text("Note (Optional)"),
                  NeumorphicTextField(
                    readOnly: readOnly,
                    maxLength: 512,
                    initialValue: fetchData ? credential.note : "",
                    validator: (text) => null,
                    onChanged: (text) {},
                    onSaved: (text) {
                      if (text.isNotEmpty) {
                        note = text;
                      }
                    },
                    outerPadding: defaultOuterPadding,
                    innerPadding: defaultInnerPadding,
                    minLines: 1,
                    maxLines: 10,
                    placeholderText: "Additional notes about this credential",
                  ),
                  readOnly
                      ? Container()
                      : NeumorphicTextButton(
                          text: viewMode == ViewMode.update
                              ? "Update credential"
                              : "Add credential",
                          icon: Icons.enhanced_encryption,
                          iconColor: NeumorphicTheme.accentColor(context),
                          outerPadding: defaultOuterPadding,
                          innerPadding: defaultInnerPadding,
                          tooltip: viewMode == ViewMode.update
                              ? "Update this credential with the new data"
                              : "Add this credential to PassMan",
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
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
                                    _finalizeCredentialData(
                                      context: context,
                                      database: database,
                                      crypt: crypt,
                                      id: fetchData
                                          ? credential.id
                                          : Uuid().v4(),
                                      title: title,
                                      account: account,
                                      password: password,
                                      note: note,
                                      update: fetchData,
                                    );

                                    Navigator.of(context).pop();
                                  },
                                  confirmText: "Ok",
                                  confirmTooltip: "Dismiss this warning",
                                  confirmIcon: Icons.warning,
                                  confirmIconColor: Colors.yellowAccent,
                                );
                              } else {
                                _finalizeCredentialData(
                                  context: context,
                                  database: database,
                                  crypt: crypt,
                                  id: fetchData ? credential.id : Uuid().v4(),
                                  title: title,
                                  account: account,
                                  password: password,
                                  note: note,
                                  update: fetchData,
                                );
                              }
                            }
                          },
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
