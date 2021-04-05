import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:encrypt/encrypt.dart' as EncryptLib;
import 'package:pinenacl/key_derivation.dart' as HashLib;

class Crypt {
  final String masterPass;

  Crypt({@required this.masterPass});

  Map<String, String> encrypt({@required String plainText}) {
    final key = EncryptLib.Key.fromUtf8(this.masterPass.padRight(32));
    final iv = EncryptLib.IV.fromSecureRandom(16);

    final encrypter = EncryptLib.Encrypter(
      EncryptLib.AES(key, mode: EncryptLib.AESMode.cbc),
    );

    final cipherText = encrypter.encrypt(plainText, iv: iv);

    return {
      "cipherText": cipherText.base64,
      "iv": iv.base64,
    };
  }

  String decrypt({@required String cipherText, @required String iv}) {
    final key = EncryptLib.Key.fromUtf8(this.masterPass.padRight(32));

    final encrypter = EncryptLib.Encrypter(
      EncryptLib.AES(key, mode: EncryptLib.AESMode.cbc),
    );

    final plainText = encrypter.decrypt(
      EncryptLib.Encrypted.fromBase64(cipherText),
      iv: EncryptLib.IV.fromBase64(iv),
    );

    return plainText;
  }

  Map<String, String> hash() {
    final salt = EncryptLib.IV.fromSecureRandom(16);

    final hashedMasterPass = HashLib.PBKDF2
        .hmac_sha512(utf8.encode(this.masterPass), salt.bytes, 100100, 64);

    return {
      "hashedMasterPass": base64.encode(hashedMasterPass),
      "salt": salt.base64,
    };
  }
}
