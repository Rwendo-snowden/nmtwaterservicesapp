import 'dart:typed_data';

import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tokenpage extends StatefulWidget {
  const Tokenpage({super.key});

  @override
  State<Tokenpage> createState() => _TokenpageState();
}

class _TokenpageState extends State<Tokenpage> {
  final _Tokenformkey = GlobalKey<FormState>();
  var Token = '';
  //
  String _platformVersion = 'Unknown';
  final _bluetoothClassicPlugin = BluetoothClassic();
  List<Device> _devices = [];
  List<Device> _discoveredDevices = [];

  int _deviceStatus = Device.disconnected;
  Uint8List _data = Uint8List(0);
  @override
  void initState() {
    super.initState();
    initPlatformState();
    // _bluetoothClassicPlugin.onDeviceStatusChanged().listen((event) {
    //   setState(() {
    //     _deviceStatus = event;
    //   });
    // });
    // _bluetoothClassicPlugin.onDeviceDataReceived().listen((event) {
    //   setState(() {
    //     _data = Uint8List.fromList([..._data, ...event]);
    //   });
    // });
  }

  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          // check for android permissions
          // TextButton(
          //   onPressed: () async {
          //     await _bluetoothClassicPlugin.initPermissions();
          //   },
          //   child: const Text("Check Permissions"),
          // ),

          TextButton(
            onPressed: _deviceStatus == Device.connected
                ? () async {
                    await _bluetoothClassicPlugin.disconnect();
                  }
                : null,
            child: const Text("disconnect"),
          ),
          // THE RECIEVED TEXT HEREE
          // Text("Received data: ${String.fromCharCodes(_data)}"),

          // Automatic connections to bluetooth device
          Container(
            child: _deviceStatus ==
                    Device.disconnected // checking for the bluetooth status
                ? ElevatedButton(
                    onPressed: () async {
                      // the esp32  bluetooth (mac address) is :3C:71:BF:D5:0E:22
                      await _bluetoothClassicPlugin.connect("3C:71:BF:D5:0E:22",
                          "00001101-0000-1000-8000-00805f9b34fb");
                    },
                    child: Text('Connect to water Meter'),
                  )
                : Text('you are connected to meter'),
          ),

          //
          Form(
            key: _Tokenformkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Tafadhali weka TOKEn  ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Token = value!;
                  },
                  decoration: const InputDecoration(
                    label: Text('TOKEN'),
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    //check for form validation
                    if (_Tokenformkey.currentState!.validate()) {
                      _Tokenformkey.currentState!.save();
                      // check if device is connceted to bluetooth ; if its connected then send the tokens
                      if (_deviceStatus == Device.connected) {
                        await _bluetoothClassicPlugin.write(Token);
                      }
                    }
                  },
                  child: const Text('Send Tokens'),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

//

// functions
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _bluetoothClassicPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
}
