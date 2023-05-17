import 'package:flutter/material.dart';

class ServiceList {
  int serviceId = -1;
  String serviceName = '';
  int lineOfBusinessId = -1;
  String lineOfBusiness = '';
  double price = 0;
  double discountedPrice = 0;
  int discountedPercent = 0;
  int duration = 0;

  ServiceList(this.serviceId, this.serviceName,this.lineOfBusinessId, this.lineOfBusiness, this.price,
      this.discountedPrice, this.discountedPercent, this.duration);
}
