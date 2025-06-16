import 'package:encrypt/encrypt.dart';

class Tokenmanipulation {
  final _meterNo = '2460005897111141';

  CreateToken(String PaidAmount) async {
    final key = Key.fromUtf8(_meterNo); // 16-byte key
    final encrypter = Encrypter(
      AES(key, mode: AESMode.ecb),
    );
    final token = encrypter.encrypt(PaidAmount);
    print('Encrypted: ${token.base64}');
    return token.base64.toString();
  }
}
