import 'package:flutter_background_messenger/flutter_background_messenger.dart';

class Smscontroller {
  String smsStatus = '';
  final messenger = FlutterBackgroundMessenger();

  SendSms(var Token) async {
    try {
      final success =
          await messenger.sendSMS(phoneNumber: '+255747597935', message: Token);
      //smsStatus = success.toString();

      if (success) {
        print('message sent ');
      } else {
        print('something went wrong');
      }
    } catch (e) {
      smsStatus = 'message not sent! ${e.toString()}';

      print(smsStatus);
    }
  }
}
