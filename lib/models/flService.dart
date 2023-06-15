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
  double discountedPrice = 0;
  int discountedPercent = 0;
  int duration;

  int quantity = 0;

  String get key {
    return ('$serviceId|${serviceParamId ?? '-1'}');
  }

  FLService(
      {required this.serviceId,
      required this.serviceParamId,
      required this.serviceName,
      required this.lineOfBusinessId,
      required this.lineOfBusiness,
      required this.hasParam,
      required this.price,
      required this.discountedPrice,
      required this.discountedPercent,
      required this.duration});

  Map toJson() => {
        'serviceId': serviceId,
        'serviceParamId': serviceParamId,
        'duration': duration,
        'quantity': quantity,
      };

  factory FLService.fromJson(Map<String, dynamic> json) {
    int aDuration = 0;
    if (json['Duration'] != null) {
      aDuration = int.parse(json['Duration'].toString());
    }
    //print(json['HasParam']);
    return FLService(
      serviceId: int.parse(json['ServiceId'].toString()),
      serviceParamId: int.tryParse(json['ServiceParamId'].toString()),
      serviceName: json['ServiceName'] as String,
      lineOfBusinessId: int.parse(json['LineOfBusinessId'].toString()),
      lineOfBusiness: json['LineOfBusiness'] as String,
      hasParam: toBoolean(json['HasParam'].toString()),
      price: double.parse(json['Price'].toString()),
      discountedPrice: double.parse(json['DiscountedPrice'].toString()),
      discountedPercent:
          double.parse(json['DiscountPercent'].toString()).toInt(),
      duration: aDuration,
    );
  }
}
