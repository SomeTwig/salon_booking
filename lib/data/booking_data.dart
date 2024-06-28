import 'package:fl_booking_app/models/flService.dart';


class BookingData {
  String date = '';
  String time = '';
  String salonName = '';
  int salonId = -1;
  List<FLService> services = [];
  double priceTotal = 0;
  String clientName = '';
  String clientPhone = '';
  String clientComment = '';
  bool personalPermit = false;

  BookingData({
    required this.date,
    required this.time,
    required this.salonName,
    required this.salonId,
    required this.services,
    required this.priceTotal,
    required this.clientName,
    required this.clientPhone,
    required this.clientComment,
    required this.personalPermit,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
      'salonName': salonName,
      'salonId': salonId,
      // 'services': _services,
      'priceTotal': priceTotal,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'clientComment': clientComment,
      'personalPermit': personalPermit ? 1 : 0,
    };
  }
}
