import 'package:encrypt/encrypt.dart';
import 'constants.dart';

class EncryptHelper {
  static final _key = Key.fromUtf8(Constant.encryptKey);
  final _iv = IV.fromLength(16);
  final _encrypter = Encrypter(AES(_key));

  String? encrypt(String input) {
    if (input.isEmpty) return null;
    final encrypterText = _encrypter.encrypt(input, iv: _iv);
    //print('encrypt ${encrypterText.base64}');
    //decrypt(encrypterText.base64);
    return encrypterText.base64;
  }

  String? decrypt(String input) {
    if (input.isEmpty) return null;
    final decrypterText = _encrypter.decrypt64(input, iv: _iv);
    //print('decrypt $decrypterText');
    return decrypterText;
  }
}
