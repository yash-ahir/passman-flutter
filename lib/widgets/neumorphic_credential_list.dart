import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:passman/services/database.dart';
import 'package:passman/widgets/neumorphic_credential_list_item.dart';
import 'package:passman/widgets/neumorphic_text_field.dart';

class NeumorphicCredentialList extends StatefulWidget {
  final List<Credential> credentials;

  NeumorphicCredentialList({@required this.credentials});

  @override
  _NeumorphicCredentialListState createState() =>
      _NeumorphicCredentialListState();
}

class _NeumorphicCredentialListState extends State<NeumorphicCredentialList> {
  List<Credential> credentials;

  @override
  void initState() {
    super.initState();
    credentials = widget.credentials;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeumorphicTextField(
          readOnly: false,
          innerPadding: 15.0,
          outerPadding: 15.0,
          placeholderText: "Search",
          validator: (text) => null,
          onChanged: (text) {
            setState(() {
              credentials = widget.credentials
                  .where(
                    (element) =>
                        element.title.toLowerCase().contains(
                              text.toLowerCase(),
                            ) ||
                        element.account.toLowerCase().contains(
                              text.toLowerCase(),
                            ),
                  )
                  .toList();
            });
          },
          onSaved: (text) {},
        ),
        Expanded(
          child: Scrollbar(
            interactive: true,
            isAlwaysShown: true,
            showTrackOnHover: true,
            child: ListView.builder(
              itemCount: credentials.length,
              itemBuilder: (ctx, index) {
                return NeumorphicCredentialListItem(credentials[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
