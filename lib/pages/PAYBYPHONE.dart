import 'package:flutter/material.dart';
import 'package:easy_sms_receiver/easy_sms_receiver.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/paybyphonemodel.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/smscontroller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Paybyphone extends StatefulWidget {
  const Paybyphone({super.key});

  @override
  State<Paybyphone> createState() => _PaybyphoneState();
}

class _PaybyphoneState extends State<Paybyphone> {
  final EasySmsReceiver _smsReceiver = EasySmsReceiver.instance;
  final Smscontroller sms = Smscontroller();

  String _receiverStatus = "Idle";
  SmsDetails _latestSmsDetails = SmsDetails(originalMessage: "No message yet.");

  String? lastProcessedTransactionId;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchUssdCode(String ussdCode) async {
    final Uri url = Uri(scheme: 'tel', path: ussdCode);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showDialog("Error",
          "Could not launch USSD code. Please ensure your device supports dialing.");
    }
  }

  Future<bool> _requestSmsPermission() async {
    final PermissionStatus status = await Permission.sms.request();
    if (status.isPermanentlyDenied) {
      _showDialog("Permission Denied",
          "SMS permission is permanently denied. Please enable it from app settings.");
      openAppSettings();
      return false;
    }
    return status.isGranted;
  }

  Future<void> _startSmsReceiver() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await _requestSmsPermission()) {
      _smsReceiver.listenIncomingSms(
        onNewMessage: (message) {
          if (!mounted) return;

          debugPrint("📥 New SMS received from: ${message.address}");
          debugPrint("📄 Message body: ${message.body}");

          final details = SmsDetails.fromMessage(message.body ?? "");
          final String? currentTransactionId = details.transactionId;

          // Prevent duplicate processing
          if (currentTransactionId != null &&
              currentTransactionId == lastProcessedTransactionId) {
            debugPrint("⚠️ Duplicate transaction ID detected. Ignoring.");
            return;
          }
          lastProcessedTransactionId = currentTransactionId;

          setState(() {
            _latestSmsDetails = details;
          });

          // Get meter number from SharedPreferences
          final String meterNo =
              prefs.getString('Meter_NO') ?? 'No meter number';
          final double amount =
              double.tryParse(details.amountPaid ?? "0") ?? 0.0;
          final double liters = amount / 100;

          final isValidSender =
              message.address == "HaloPesa" || message.address == "M-PESA";
          final isValidRecipient =
              details.recipientName == 'MELTRIDES MZEE RWEYENDERA';

          if (isValidRecipient && isValidSender) {
            switch (meterNo) {
              case "1":
                sms.SendSms('A:$liters,B:0,C:0');
                break;
              case "2":
                sms.SendSms('A:0,B:$liters,C:0');
                break;
              case "3":
                sms.SendSms('A:0,B:0,C:$liters');
                break;
              default:
                debugPrint("❌ Unknown meter number: $meterNo");
            }

            debugPrint("📤 Response SMS sent based on meter $meterNo.");
          }
        },
      );

      if (!mounted) return;
      setState(() {
        _receiverStatus = "Running";
      });
    } else {
      if (!mounted) return;
      setState(() {
        _receiverStatus = "Permission Denied";
      });
    }
  }

  void _stopSmsReceiver() {
    _smsReceiver.stopListenIncomingSms();
    if (!mounted) return;
    setState(() {
      _receiverStatus = "Stopped";
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 227, 227),
        appBar: AppBar(
          title: const Text('Pay by Phone'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Payment RxT : $_receiverStatus',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  _startSmsReceiver();
                  _launchUssdCode("*150*00#");
                },
                icon: const Icon(Icons.phone_android),
                label: const Text('Pay by M-Pesa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  _startSmsReceiver();
                  _launchUssdCode("*150*88#");
                },
                icon: const Icon(Icons.phone_android),
                label: const Text('Pay by HaloPesa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
