import 'package:flutter/material.dart';

class MyAccount extends ChangeNotifier {
  // String country = '';
  String accountName = '';
  String accountPhone = '';
  // String language = '';
  // String sex = '';

  MyAccount({
    this.accountName = '',
    this.accountPhone = '',
  });

  void addPhone(String cPhone) {
    accountPhone = cPhone;
    notifyListeners();
  }

  void addAccount(
    String cName,
    // String cCountry,
    String cPhone,
    // String cLanguage,
    // String cSex
  ) {
    accountName = cName;
    // country = cCountry;
    accountPhone = cPhone;
    // language = cLanguage;
    // sex = cSex;
    notifyListeners();
  }

  bool accountLogedIn() {
    if (accountName.isNotEmpty && accountPhone.isNotEmpty) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toMap() {
    return {
      'accountName': accountName,
      'accountPhone': accountPhone,
    };
  }
}
