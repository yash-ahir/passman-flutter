import 'package:flutter/foundation.dart';

class Credential {
  final String id;
  final String title;
  final String account;
  final String password;
  final String note;

  Credential({
    @required this.id,
    @required this.title,
    @required this.account,
    @required this.password,
    @required this.note,
  });
}
