import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/services.dart';

class BlC {
  String platformVersions = 'Unknown';
  final bluetoothClassicPlugin = BluetoothClassic();
  List<Device> devices = [];
  List<Device> discoveredDevices = [];

  int deviceStatus = Device.disconnected;
  Uint8List _data = Uint8List(0);

  f() {
    initPlatformState();
    bluetoothClassicPlugin.onDeviceStatusChanged().listen((event) {
      deviceStatus = event;
    });
    bluetoothClassicPlugin.onDeviceDataReceived().listen((event) {
      _data = Uint8List.fromList([..._data, ...event]);
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await bluetoothClassicPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //  if (!mounted) return;

    platformVersions = platformVersion;
  }
}
