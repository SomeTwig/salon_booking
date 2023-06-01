import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/models/flService.dart';

class BookingService {
  //base URL path to Booking API-services
  static const serviceURL = "$myOnlineBookingServiceHost/OnlineBooking";

  //initialize http-client
  http.Client _client = http.Client();

  Future<List<FLService>> fetchServices() async {
    const String url =
        'https://fltest.x-tend.com.ua/api/GetBookingPrice?networkId=1&language=2&discountcode=JENPCZ4FSC';
    // '$serviceURL/GetServicesPriceList?networkId=$myNetworkId&languageid=$myLanguageId&discountcode=$myOnlineBooking_DiscountCode&contactsourceid$myOnlineBooking_CountactSourceId';

    String responseBody = await _callAPI(url, 'get');

    //final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    //return parsed.map<Service>((json) => Service.fromJson(json)).toList();

    // Use the compute function to run parseServices in a separate isolate.
    return compute(parseServices, responseBody);
  }

  Future<List<FLService>> fetchOfficeDates() async {
    const String url =
        '$serviceURL/GetOffices?networkId=$myNetworkId&languageid=$myLanguageId';

    String responseBody = await _callAPI(url, 'get');

    // Use the compute function to run parseServices in a separate isolate.
    return compute(parseServices, responseBody);
  }

  // A common function to call web-api method, returns response body if success
  Future<String> _callAPI(String url, String method, [Object? body]) async {
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};

      var uri = Uri.parse(url);

      http.Response response;
      if (method == 'post') {
        response = await _client.post(uri, headers: headers, body: body);
      } else {
        response = await _client.get(uri, headers: headers);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        print(response.toString());
        // If the server did not return a 200-OK or 201-CREATED response,
        // then throw an exception.
        throw Exception('Failed to call Web-API method.');
      }
    } on TimeoutException catch (e) {
      print('Connection timeout: $e');
      throw Exception('Failed to call Web-API method. Connection timeout');
    } on Error catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}

// A function that converts a response body into a List<Service>.
List<FLService> parseServices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<FLService>((json) => FLService.fromJson(json)).toList();
}
