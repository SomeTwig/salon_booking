// ignore: file_names
import 'package:string_validator/string_validator.dart';

class FLService {
  int serviceId;
  int? serviceParamId = -1;
  String serviceName;
  String serviceParam = '';
  int lineOfBusinessId;
  String lineOfBusiness;
  bool hasParam;
  double price;
  double discountedPrice;
  int discountedPercent;
  int duration;

  int quantity = 0;

  String get key {
    return ('$serviceId|${serviceParamId ?? '-1'}');
  }

  FLService(
      {required this.serviceId,
      required this.serviceParamId,
      required this.serviceName,
      required this.serviceParam,
      required this.lineOfBusinessId,
      required this.lineOfBusiness,
      required this.hasParam,
      required this.price,
      required this.discountedPrice,
      required this.discountedPercent,
      required this.duration,
      required this.quantity});

  Map toJson() => {
        'serviceId': serviceId,
        'serviceParamId': serviceParamId,
        'duration': duration,
        'quantity': quantity,
      };

  factory FLService.fromJson(Map<String, dynamic> json) {
    int aDuration = 0;
    if (json['duration'] != null) {
      aDuration = int.parse(json['duration'].toString());
    }
    //print(json['discountedPrice']);
    return FLService(
      serviceId: int.parse(json['serviceId'].toString()),
      serviceParamId: int.tryParse(json['serviceParamId'].toString()),
      serviceParam: json['serviceParam'].toString(),
      serviceName: json['serviceName'] as String,
      lineOfBusinessId: int.parse(json['lineOfBusinessId'].toString()),
      lineOfBusiness: json['lineOfBusiness'] as String,
      hasParam: toBoolean(json['hasParam'].toString()),
      price: double.parse(json['price'].toString()),
      discountedPrice: double.tryParse(json['discountPrice'].toString()) ?? double.parse(json['price'].toString()),
      discountedPercent:
          double.tryParse(json['discountPercent'].toString())?.toInt() ?? 0,
      duration: aDuration,
      quantity: 0,
    );
  }

  Map<String, dynamic> toMap(int bookingId) {
    return {
      'serviceId': serviceId,
      'bookingId': bookingId,
      'serviceParamId': serviceParamId,
      'serviceName': serviceName,
      'serviceParam': serviceParam,
      'lineOfBusinessId': lineOfBusinessId,
      'lineOfBusiness': lineOfBusiness,
      'hasParam': hasParam ? 1 : 0,
      'price': price,
      'discountedPrice': discountedPrice,
      'discountedPercent': discountedPercent,
      'duration': duration,
      'quantity': quantity,
    };
  }
}
