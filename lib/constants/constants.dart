import 'package:flutter/material.dart';

//CTheme Colors
const myTextColor = Color(0XFF1c0d33);
const myBtnColor = Color(0XFFFF8573);
const myPrimaryColor = Color(0XFF4E295B);
const mySecondryTextColor = Color(0XFF6B617A);
const starColor = Color(0xff5D4F73);

//
enum ServiceStatus { noInternet, loading, failed, success, none }

//For app language display
const myLanguageId = 2; //2-Rus, 1-Ukr, 7-Eng, 4-PL

//For list of offices display
const myNetworkId = 1; //1-UA , 2-PL

//Parts of api requests
const myOnlineBookingServiceHost = 'http://fltestapi.x-tend.com.ua';
const myOnlineBookingDiscountCode = 'JENPCZ4FSC';
const myOnlineBookingCountactSourceId = '7'; //where the api request is coming from
