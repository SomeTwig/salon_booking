import 'package:flutter/material.dart';
import 'package:test_1/models/models.dart';

final List<FLSalon> flSalon = [
  FLSalon(
    'ЖК Нова Англія',
    'Вул. Максимовича 26-б, оф 447',
    'assets/images/1.png',
    const Color(0xFFFFF0EB),
  ),
  FLSalon(
    'ЖК Малахіт',
    'м. Київ, вул. Богданівська, 7Г',
    'assets/images/2.png',
    const Color(0xFFEBF6FF),
  ),
  FLSalon(
    'Варшава Fast Line Studio',
    'Варшава, Яна Казімежа, 27А',
    'assets/images/3.png',
    const Color(0xFFFFF3EB),
  ),
  FLSalon(
    'Кракiв, Заблоччя',
    'Краків, вул. Заблоччя, 19-А',
    'assets/images/4.png',
    const Color(0xFFEBFFED),
  )
];

final List<ServiceList> servicesList = [
  ServiceList('Men\'s Hair Cut', 45, 30),
  ServiceList('Women\'s Hair Cut', 60, 50),
  ServiceList('Color & Blow Dry', 90, 75),
  ServiceList('Oil Treatment', 30, 20),
];

final List<MockDateTime> datetimes = [
  MockDateTime(
      '2023-05-11', ["9:30 - 10:30 AM", "12:00 - 1:30 PM", "5:30 - 6:30 PM"]),
  MockDateTime('2023-05-10', ["10:30 - 11:45 AM", "6:30 - 7:30 PM"]),
  MockDateTime('2023-05-09', ["12:00 - 1:30 PM", "2:00 - 4:30 PM"]),
  MockDateTime('2023-05-08', ["2:00 - 4:30 PM"]),
];
