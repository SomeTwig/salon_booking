import 'package:flutter/material.dart';
import 'package:fl_booking_app/models/flService.dart';
import 'package:fl_booking_app/models/booking_variant.dart';

import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/services/booking_service.dart';

class BookingInfo extends ChangeNotifier {
  final _bookingService = BookingService();
  ServiceStatus _status = ServiceStatus.none;

  String _date = '';
  String _time = '';
  String _salonName = '';
  int _salonId = -1;
  final List<FLService> _services = [];
  double _priceTotal = 0;
  String _clientName = '';
  String _clientPhone = '';
  String _clientComment = '';
  bool _personalPermit = false;

  ServiceStatus get status => _status;

  String get bDate => _date;
  String get bTime => _time;
  String get sName => _salonName;
  int get salonId => _salonId;
  List<FLService> get services => _services;
  double get priceTotal => _priceTotal;
  String get clientName => _clientName;
  String get clientPhone => _clientPhone;
  String get clientComment => _clientComment;
  bool get personalPermit => _personalPermit;

 



  Future<List<BookingVariant>> fetchBookingVariants(
      int salId, String selectedDate, String jsonBody) async {
    _status = ServiceStatus.loading;
    notifyListeners();
    //print(salId);
    try {
      final res = await _bookingService.getBookingTimeVariants(
          salId, selectedDate, jsonBody);
      //_allServices = res;

      _status = ServiceStatus.success;
      notifyListeners();

      return res;
    } catch (e) {
      print('fetchAllOfficeDates Error: $e');

      _status = ServiceStatus.failed;
      return [];
    }
  }

  void addSalon(String salName, int salId) {
    _salonName = salName;
    _salonId = salId;
    //print(_salonId);
    notifyListeners();
  }

  void addDate(String aDate) {
    _date = aDate;
    notifyListeners();
  }

  void addTime(String aTime) {
    _time = aTime;
    notifyListeners();
  }

  void addServices(List<FLService> aServices, double aServiceSum) {
    for (var service in aServices) {
      if (_services.indexWhere((element) => element.key == service.key) == -1) {
        //print(service.serviceName);
        _services.add(service);
      } else {
        _services
            .firstWhere((element) => element.key == service.key)
            .quantity += service.quantity;
      }
    }
    _priceTotal += aServiceSum;
    notifyListeners();
  }

  void addService(FLService aService) {
    aService.discountedPrice < aService.price
        ? addSum(aService.discountedPrice)
        : addSum(aService.price);
    for (var element in _services) {
      if (element.key == aService.key) {
        element.quantity++;
        return;
      }
    }
    aService.quantity++;
    _services.add(aService);
    notifyListeners();
  }

  void deleteService(FLService aService) {
    if (_services.contains(aService) == true) {
      aService.discountedPrice < aService.price
          ? subtractSum(aService.discountedPrice)
          : subtractSum(aService.price);
      int qty = _services
          .firstWhere((element) => element.key == aService.key)
          .quantity--;
      qty--;
      if (qty <= 0) {
        _services.remove(aService);
      }
      notifyListeners();
    }
  }

  void addClientInfo(String aClientName, String aClientPhone,
      String aClientComment, bool isPermitted) {
    _clientName = aClientName;
    _clientPhone = aClientPhone;
    _clientComment = aClientComment;
    _personalPermit = isPermitted;
  }

  void addSum(double aServicePrice) {
    _priceTotal += aServicePrice;
    notifyListeners();
  }

  void subtractSum(double aServicePrice) {
    _priceTotal -= aServicePrice;
    notifyListeners();
  }
}
