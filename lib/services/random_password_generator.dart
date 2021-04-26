import 'dart:math';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class RandomPasswordGenerator {
  static final _randomGenerator = Random.secure();

  static String generateRandomString({@required int length}) {
    final randomBytes =
        List.generate(length, (index) => _randomGenerator.nextInt(256));

    return base64.encode(randomBytes).substring(1, length + 1);
  }
}
