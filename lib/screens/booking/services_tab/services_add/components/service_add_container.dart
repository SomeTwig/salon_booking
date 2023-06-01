import 'package:flutter/material.dart';
import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/models/models.dart';

import 'package:provider/provider.dart';
import 'package:fl_booking_app/data/data.dart';
import 'package:fl_booking_app/providers/services_provider.dart';

import '../../../../../routes/route.dart' as route;

class ServiceAddContainer extends StatefulWidget {
  final FLService service;

  const ServiceAddContainer({super.key, required this.service});

  @override
  State<ServiceAddContainer> createState() => _ServiceAddContainerState();
}

class _ServiceAddContainerState extends State<ServiceAddContainer> {
  bool isShow = false;

  bool _isAddButtonDisabled = false;
  bool _isDeleteButtonDisabled = true;

  void _handleAddButtonTap() {
    setState(() {
      _isAddButtonDisabled = true;
      _isDeleteButtonDisabled = false;
    });
    Provider.of<ServiceList>(context, listen: false).addService(widget.service);
  }

  void _handleDeleteButtonTap() {
    setState(() {
      _isAddButtonDisabled = false;
      _isDeleteButtonDisabled = true;
    });
    Provider.of<ServiceList>(context, listen: false)
        .deleteService(widget.service);
  }

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
                IntrinsicHeight(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 10,
                          child: Text(
                            widget.service.serviceName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          tooltip: 'Выбрать услугу',
                          onPressed:
                              _isAddButtonDisabled ? null : _handleAddButtonTap,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        VerticalDivider(),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Удалить услугу',
                          onPressed: _isDeleteButtonDisabled
                              ? null
                              : _handleDeleteButtonTap,
                        ),
                      ]),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text(
                    widget.service.price.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: mySecondryTextColor,
                    ),
                  ),
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
