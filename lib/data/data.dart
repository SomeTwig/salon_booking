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
  ServiceList(1, "Аппаратный маникюр Baehr без покрытия", 2, "Руки", 300.00,
      270.00, 10, 40),
  ServiceList(
      46, "Стрижка женская", 3, "Стрижка женская", 580.00, 522.00, 10, 50),
  ServiceList(71, "Вечерний макияж", 5, "Макияж", 1000.00, 900.00, 10, 60),
  ServiceList(
      25, "Покрытие лаком Baehr руки", 2, "Руки", 120.00, 108.00, 10, 10),
];

final List<MockDateTime> datetimes = [
  MockDateTime(
      '2023-05-11', ["9:30 - 10:30 AM", "12:00 - 1:30 PM", "5:30 - 6:30 PM"]),
  MockDateTime('2023-05-10', ["10:30 - 11:45 AM", "6:30 - 7:30 PM"]),
  MockDateTime('2023-05-09', ["12:00 - 1:30 PM", "2:00 - 4:30 PM"]),
  MockDateTime('2023-05-08', ["2:00 - 4:30 PM"]),
];
