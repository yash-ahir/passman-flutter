import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/services/credential_database.dart';
import 'package:passman/services/crypt.dart';
import 'package:passman/widgets/alert.dart';
import 'package:passman/widgets/neumorphic_icon_button.dart';
import 'package:passman/widgets/neumorphic_text_button.dart';
import 'package:passman/widgets/neumorphic_text_field.dart';
import 'package:passman/widgets/neumorphic_password_field.dart';
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
  final _crypt = Crypt(masterPass: "Alpha Bravo Charlie Delta");

  Future<Credential> _encryptData({
    @required String id,
    @required String title,
    @required String account,
    @required String password,
    String note,
  }) async {
    final titleData = await _crypt.encrypt(plainText: title);
    final accountData = await _crypt.encrypt(plainText: account);
    final passwordData = await _crypt.encrypt(plainText: password);
    Map<String, String> noteData = {};
    if (note != null) {
      noteData = await _crypt.encrypt(plainText: note);
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
    @required String id,
    @required String title,
    @required String account,
    @required String password,
    @required bool update,
    String note,
  }) {
    _encryptData(
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

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object> ?? {};
    final _viewMode = routeArgs["viewMode"] ?? ViewMode.create;

    String _appBarTitle;
    bool _fetchData;
    bool _readOnly;
    switch (_viewMode) {
      case ViewMode.read:
        {
          _appBarTitle = "Viewing credential";
          _readOnly = true;
          _fetchData = true;
        }
        break;

      case ViewMode.update:
        {
          _appBarTitle = "Editing credential";
          _readOnly = false;
          _fetchData = true;
        }
        break;

      default:
        {
          _appBarTitle = "Create new credential";
          _readOnly = false;
          _fetchData = false;
        }
        break;
    }

    final _credential = routeArgs["credential"] as Credential;

    String _title;
    String _account;
    String _password;
    String _note;

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
      title: Text(_appBarTitle),
      actions: [
        _readOnly
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
                      "credential": _credential,
                    },
                  );
                },
              )
            : Container(),
      ],
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
                  readOnly: _readOnly,
                  maxLength: 128,
                  initialValue: _fetchData ? _credential.title : "",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Enter the title";
                    }
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    _title = text;
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  placeholderText: "Title/name of credential",
                ),
                Text("Account"),
                NeumorphicTextField(
                  readOnly: _readOnly,
                  maxLength: 256,
                  initialValue: _fetchData ? _credential.account : "",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Enter the account name";
                    }
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    _account = text;
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  placeholderText: "Account name (e.g. E-mail, username, etc.)",
                ),
                Text("Password"),
                NeurmophicPasswordField(
                  readOnly: _readOnly,
                  maxLength: 256,
                  initialValue: _fetchData ? _credential.password : "",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Enter or generate a password";
                    }
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    _password = text;
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  placeholderText: "Strong or random password",
                ),
                _readOnly
                    ? Container()
                    : NeumorphicTextButton(
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
                  readOnly: _readOnly,
                  maxLength: 512,
                  initialValue: _fetchData ? _credential.note : "",
                  validator: (text) {
                    return null;
                  },
                  onChanged: (text) {},
                  onSaved: (text) {
                    if (text.isNotEmpty) {
                      _note = text;
                    }
                  },
                  outerPadding: _defaultOuterPadding,
                  innerPadding: _defaultInnerPadding,
                  minLines: 1,
                  maxLines: 10,
                  placeholderText: "Additional notes about this credential",
                ),
                _readOnly
                    ? Container()
                    : NeumorphicTextButton(
                        text: _viewMode == ViewMode.update
                            ? "Update credential"
                            : "Add credential",
                        icon: Icons.enhanced_encryption,
                        iconColor: NeumorphicTheme.accentColor(context),
                        outerPadding: _defaultOuterPadding,
                        innerPadding: _defaultInnerPadding,
                        tooltip: _viewMode == ViewMode.update
                            ? "Update this credential with the new data"
                            : "Add this credential to PassMan",
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            final pwRegExp = RegExp(
                              r"""^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~`!@#$%^&*()\[\]\-|_{}\\\/+=<>,.?:;\'"]).{8,}$""",
                              caseSensitive: false,
                              multiLine: false,
                            );

                            if (!pwRegExp.hasMatch(_password)) {
                              Alert(context).showAlertDialog(
                                message:
                                    "Weak password detected\n\nIf possible, use a password with atleast an uppercase character, a lowercase character, a number, and a special character from ~`!@#\$%^&*-_+=()[]{}:;\"'<>,./|? with atleast 8 characters.",
                                onConfirm: () {
                                  _finalizeCredentialData(
                                    context: context,
                                    database: database,
                                    id: _fetchData
                                        ? _credential.id
                                        : Uuid().v4(),
                                    title: _title,
                                    account: _account,
                                    password: _password,
                                    note: _note,
                                    update: _fetchData,
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
                                id: _fetchData ? _credential.id : Uuid().v4(),
                                title: _title,
                                account: _account,
                                password: _password,
                                note: _note,
                                update: _fetchData,
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
    );
  }
}
