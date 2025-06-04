import 'package:flutterwavepaymenttesting/Databases/models/databaseServices.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DbController extends GetxController {
  // fetching data from database
  List paymentData = [];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    List<Map<String, dynamic>> payments =
        await Databaseservices.instance.fetch();
    paymentData = payments;
    print(paymentData);
    update();
    return paymentData;
  }

  PutData(Map<String, dynamic> payments) async {
    await Databaseservices.instance.insert(payments);
    await getData();
  }

  // delete all data
  DeleteAllPayments() async {
    await Databaseservices.instance.DeleteALL();
    await getData();
  }
}
