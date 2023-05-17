import 'package:flutter/material.dart';
import 'package:test_1/constants/constants.dart';
import 'package:test_1/models/models.dart';

import 'package:test_1/data/data.dart';

import '/route/route.dart' as route;

class ServiceContainer extends StatefulWidget {
  final ServiceList service;

  const ServiceContainer({super.key, required this.service});

  @override
  State<ServiceContainer> createState() => _ServiceContainerState();
}

class _ServiceContainerState extends State<ServiceContainer>{
  bool isShow = false;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: size.width,
      height: size.height / 5 + 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.service.serviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.service.price.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: mySecondryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  MaterialButton(
                    color: myPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      setState(() {
                        isShow = true;
                      });
                    },
                    child: const Text(
                      'Выбрать',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: isShow,
                    // maintainSize: true, //NEW
                    // maintainAnimation: true, //NEW
                    // maintainState: true, //NEW
                    child: MaterialButton(
                      color: myPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        setState(() {
                          isShow = false;
                        });
                      },
                      child: const Text(
                        'Удалить',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
