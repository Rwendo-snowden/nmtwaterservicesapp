import 'package:encrypt/encrypt.dart';

class Tokenmanipulation {
  // final _DuwasaRatePerUNIT = 1667.5;
  final _DuwasaRatePerUNIT = 2000;

  final _meterNo = '2460005897111141';

  CreateToken(int PaidAmount) async {
    var literObtained = PaidAmount / _DuwasaRatePerUNIT;

    //
    // final key = Key.fromUtf8(_meterNo); // 16-byte key
    // final encrypter = Encrypter(
    //   AES(key, mode: AESMode.ecb),
    // );
    // final token = encrypter.encrypt(literObtained.toString());
    // print('Encrypted: ${token.base64}');
    // return token.base64.toString();
    return literObtained.toString();
  }
}
