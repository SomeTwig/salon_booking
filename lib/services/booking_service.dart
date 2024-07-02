import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/models/models.dart';

class BookingService {
  //base URL path to Booking API-services
  static const serviceURL = "$myOnlineBookingServiceHost/OnlineBooking";

  //initialize http-client
  final http.Client _client = http.Client();

  Future<List<FLService>> fetchServices() async {
    const String url =
        //'https://fltest.x-tend.com.ua/api/GetBookingPrice?networkId=1&language=2&discountcode=';
        '$serviceURL/GetServicesPriceList?networkId=$myNetworkId&languageid=$myLanguageId&discountcode=$myOnlineBookingDiscountCode';

    String responseBody = await _callAPI(url, 'get');

    // Use the compute function to run parseServices in a separate isolate.
    return compute(parseServices, responseBody);
  }

  Future<List<FLOffice>> fetchOffices() async {
    const String url =
        '$serviceURL/GetOffices?networkId=$myNetworkId&languageid=$myLanguageId';

    String responseBody = await _callAPI(url, 'get');

    // Use the compute function to run parseServices in a separate isolate.
    return compute(parseOffices, responseBody);
  }

  Future<List<OfficeDate>> fetchOfficesDates() async {
    const String url =
        // 'https://fltestapi.x-tend.com.ua/OnlineBooking/GetOfficeWorkingDatesList?networkid=1';
    '$serviceURL/GetOfficeWorkingDatesList?networkId=$myNetworkId';

    String responseBody = await _callAPI(url, 'get');

    // Use the compute function to run parseServices in a separate isolate.
    return compute(parseOfficesDates, responseBody);
  }

  Future<List<BookingVariant>> getBookingTimeVariants(
      int officeId, String selectedDate, String jsonBody) async {
    String url =
        '$serviceURL/GetBookingTimeVariants?networkId=$myNetworkId&languageid=$myLanguageId&officeid=$officeId&bookingdate=$selectedDate';
    //'$serviceURL/GetBookingTimeVariants?networkId=$myNetworkId&languageid=$myLanguageId&officeid=$officeId&bookingdate=$selectedDate';
    String responseBody = await _callAPI(url, 'post', jsonBody);
    // Use the compute function to run parseServices in a separate isolate.
    return compute(parseBookingTimeVariants, responseBody);
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
        // If the server did not return a 200-OK or 201-CREATED response,
        // then throw an exception.
        throw Exception('Failed to call Web-API method.');
      }
    } on TimeoutException catch (e) {
      print('Connection timeout: $e');
      throw Exception('Failed to call Web-API method. Connection timeout');
    } on Error catch (e) {
      print('_callAPI Error: $e');
      rethrow;
    }
  }
}

// A function that converts a response body into a List<FLService>.
List<FLService> parseServices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<FLService>((json) => FLService.fromJson(json)).toList();
}

// A function that converts a response body into a List<FLOffice>.
List<FLOffice> parseOffices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<FLOffice>((json) => FLOffice.fromJson(json)).toList();
}

// A function that converts a response body into a List<OfficeDate>.
List<OfficeDate> parseOfficesDates(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<OfficeDate>((json) => OfficeDate.fromJson(json)).toList();
}

// A function that converts a response body into a List<OfficeDate>.
List<BookingVariant> parseBookingTimeVariants(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<BookingVariant>((json) => BookingVariant.fromJson(json))
      .toList();
}
