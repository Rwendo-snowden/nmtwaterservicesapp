import 'package:bluetooth_classic/bluetooth_classic.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:get/get.dart';

class Bluetoothservices extends GetxController {
  final bluetoothClassicPlugin = BluetoothClassic();
  var deviceStatus = Device.disconnected;
  bool isConnected = false;

  BLinitialstate() {
    try {
      bluetoothClassicPlugin.onDeviceStatusChanged().listen(
        (event) {
          deviceStatus = event;
          update();

          print('The event is :${event}');
          print(isConnected);
        },
      );
    } catch (e) {
      print(e);
      print('This device is already intialized ');
    }
    //update();
  }

// this function is for bluetooth connection
  BLconnection() async {
    try {
      await bluetoothClassicPlugin.connect(
        "3C:71:BF:D5:0E:22",
        "00001101-0000-1000-8000-00805f9b34fb",
      );

      // change connection status
      isConnected = true;
    } catch (e) {
      print(e);
      print('could not connect o device there is an execption occured');
    }
  }

// this function is for bluetooth disconnection
  BLdisconnetion() async {
    try {
      await bluetoothClassicPlugin.disconnect();
      // change the connection status
      isConnected = false;
    } catch (e) {
      print("Meter couldn't disconnect please try again");
    }
  }
}
