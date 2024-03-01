import 'package:flutter/material.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/services/booking_service.dart';

class OfficeList with ChangeNotifier {
  final _bookingService = BookingService();
  ServiceStatus _status = ServiceStatus.none;

  FLOffice _office = FLOffice.empty();
  final List<String> _officeDates = [];

  List<String> get officeDates => _officeDates;
  ServiceStatus get status => _status;

  FLOffice get office => _office;

  Future<List<FLOffice>> fetchAllOffices() async {
    _status = ServiceStatus.loading;
    notifyListeners();

    try {
      final res = await _bookingService.fetchOffices();
      //_allServices = res;

      _status = ServiceStatus.success;
      notifyListeners();

      return res;
    } catch (e) {
      print('fetchAllOffices Error: $e');

      _status = ServiceStatus.failed;
      return [];
    }
  }

  Future<List<OfficeDate>> fetchAllOfficeDates() async {
    _status = ServiceStatus.loading;
    notifyListeners();

    try {
      final res = await _bookingService.fetchOfficesDates();
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

  void addOffice(FLOffice aOffice) {
    _office = aOffice;
    notifyListeners();
  }

  void calcOfficeDates(List<OfficeDate> aOfficeDates) {
    for (var element in aOfficeDates) {
      if (element.officeId == _office.officeId) {
        officeDates.add(element.date);
      }
    }
  }
}
