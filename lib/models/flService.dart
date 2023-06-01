// ignore: file_names
import 'package:flutter/foundation.dart';
import 'dart:convert';

class FLService {
  int serviceId;
  int serviceParamId = -1;
  String serviceName = '';
  int lineOfBusinessId = -1;
  String lineOfBusiness = '';
  double price = 0;
  double discountedPrice = 0;
  int discountedPercent = 0;
  int duration = 0;

  String get key {
    return ('$serviceId|${serviceParamId > 0 ? serviceParamId : '-1'}');
  }

  FLService(
      {required this.serviceId,
      required this.serviceName,
      required this.lineOfBusinessId,
      required this.lineOfBusiness,
      required this.price,
      required this.discountedPrice,
      required this.discountedPercent,
      required this.duration});

  factory FLService.fromJson(Map<String, dynamic> json) {
    int aDuration = 0;
    if (json['Duration'] != null) {
      aDuration = int.parse(json['Duration'].toString());
    }
    return FLService(
      serviceId: int.parse(json['ServiceId'].toString()),
      serviceName: json['ServiceName'] as String,
      lineOfBusinessId: int.parse(json['LineOfBusinessId'].toString()),
      lineOfBusiness: json['LineOfBusiness'] as String,
      price: double.parse(json['Price'].toString()),
      discountedPrice: double.parse(json['DiscountedPrice'].toString()),
      discountedPercent:
          double.parse(json['DiscountPercent'].toString()).toInt(),
      duration: aDuration,
    );
  }
}

/* Future<List<Service>> fetchServices(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://fltest.x-tend.com.ua/api/GetBookingPrice?networkId=1&language=2&discountcode=JENPCZ4FSC'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseServices, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Service> parseServices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Service>((json) => Service.fromJson(json)).toList();
}
 */