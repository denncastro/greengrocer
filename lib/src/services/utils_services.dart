import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  Future<void> saveLocalData({
    required String key,
    required String data,
  }) async {
    return storage.write(key: key, value: data);
  }

  Future<String?> getLocalData({required String key}) async {
    return storage.read(key: key);
  }

  Future<void> removeLocalData({required String key}) async {
    return storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "pt_BR");

    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat.yMd().add_Hm();

    return dateFormat.format(dateTime);
  }

  showToast({
    required String label,
    bool isError = false,
  }) {
    Fluttertoast.showToast(
      msg: label,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 16.0,
    );
  }
}
