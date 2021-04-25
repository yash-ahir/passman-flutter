import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:encrypt/encrypt.dart' as EncryptLib;
import 'package:pinenacl/key_derivation.dart' as HashLib;

class Crypt {
  final String masterPass;

  Crypt({@required this.masterPass});

  /// The encrypt method takes the plaintext as input and returns a map of
  /// base64 encoded ciphertext and initialization vector.
  Future<Map<String, String>> encrypt({@required String plainText}) async {
    /// Pad master password to 32 bytes for optimal key length.
    final key = EncryptLib.Key.fromUtf8(this.masterPass.padRight(32));

    /// Generate a securely random initialization vector of 16 bytes.
    final iv = EncryptLib.IV.fromSecureRandom(16);

    /// Instantiate an Encrypter with AES CBC as the mode of operation.
    final encrypter = EncryptLib.Encrypter(
      EncryptLib.AES(key, mode: EncryptLib.AESMode.cbc),
    );

    /// Encrypt the plaintext with the previously generated initialization vector.
    final cipherText = encrypter.encrypt(plainText, iv: iv);

    /// Encode ciphertext and initialization vector to base64 for storage.
    return {
      "cipherText": cipherText.base64,
      "iv": iv.base64,
    };
  }

  /// The decrypt method takes the base64 encoded ciphertext and initialization vector,
  /// and returns the original plaintext.
  Future<String> decrypt(
      {@required String cipherText, @required String iv}) async {
    /// Pad master password to 32 bytes for optimal key length.
    final key = EncryptLib.Key.fromUtf8(this.masterPass.padRight(32));

    /// Instantiate an Encrypter with AES CBC as the mode of operation.
    final encrypter = EncryptLib.Encrypter(
      EncryptLib.AES(key, mode: EncryptLib.AESMode.cbc),
    );

    /// Decrypt the ciphertext with after decoding both it and the initialization vector
    /// back to utf8 from base64.
    final plainText = encrypter.decrypt(
      EncryptLib.Encrypted.fromBase64(cipherText),
      iv: EncryptLib.IV.fromBase64(iv),
    );

    return plainText;
  }

  /// The hash method takes the master password and optionally a salt value, hashes it with 50000 rounds
  /// of PBKDF2 with SHA256 as HMAC. It returns a map of base64 encoded
  /// hashed master password and salt.
  ///
  /// Note that to prevent the UI thread from being blocked, this method should
  /// always be offloaded to a separate isolate with the [compute] function.
  static Future<Map<String, String>> hash(List args) async {
    final salt = args.length > 1
        ? EncryptLib.IV.fromBase64(args[1])
        : EncryptLib.IV.fromSecureRandom(16);

    final hashedMasterPass =
        HashLib.PBKDF2.hmac_sha256(utf8.encode(args[0]), salt.bytes, 50000, 32);

    return {
      "hashedMasterPassword": base64.encode(hashedMasterPass),
      "salt": salt.base64,
    };
  }
}
