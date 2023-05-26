import 'package:flutter/material.dart';
import 'package:test_1/constants/constants.dart';
import 'package:test_1/models/models.dart';

import 'package:provider/provider.dart';
import 'package:test_1/data/data.dart';
import 'package:test_1/providers/services_provider.dart';

import '../../../../../routes/route.dart' as route;

class ServiceAddContainer extends StatefulWidget {
  final Service service;

  const ServiceAddContainer({super.key, required this.service});

  @override
  State<ServiceAddContainer> createState() => _ServiceAddContainerState();
}

class _ServiceAddContainerState extends State<ServiceAddContainer> {
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
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.service.price.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
                  height: 5,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  MaterialButton(
                    color: myPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Provider.of<ServiceList>(context, listen: false)
                          .addService(widget.service);
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
                         Provider.of<ServiceList>(context, listen: false)
                          .deleteService(widget.service);
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
