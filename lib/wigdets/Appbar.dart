import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutterwavepaymenttesting/datamanipulation/bluetoothServices.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class NMTAPPBAR extends StatelessWidget implements PreferredSizeWidget {
  const NMTAPPBAR({
    super.key,
    required this.bluetoothservices,
  });

  final Bluetoothservices bluetoothservices;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        // GetBuilder<Bluetoothservices>(
        //   init: Bluetoothservices(),
        //   initState: (_) {},
        //   builder: (_) {
        //     // return Row(
        //     //   children: [
        //     //     //  _deviceStatus == Device.disconnected
        //     //     bluetoothservices.deviceStatus == Device.disconnected
        //     //         ? IconButton(
        //     //             onPressed: () async {
        //     //               bluetoothservices.BLconnection();
        //     //             },
        //     //             icon: Icon(Icons.bluetooth_disabled),
        //     //           )
        //     //         : //_deviceStatus == Device.connecting
        //     //         bluetoothservices.deviceStatus == Device.connecting
        //     //             ? IconButton(
        //     //                 onPressed: () {},
        //     //                 icon: Icon(Icons.bluetooth_searching_rounded))
        //     //             : IconButton(
        //     //                 onPressed: () async {
        //     //                   bluetoothservices.BLdisconnetion();
        //     //                 },
        //     //                 icon: Icon(Icons.bluetooth_connected_rounded)),
        //     //   ],
        //     // );
        //   },
        // ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notification_add_outlined),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
