import 'package:flutter/material.dart';
import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/models/models.dart';

import 'package:provider/provider.dart';
import 'package:fl_booking_app/providers/services_provider.dart';

class ServiceAddContainer extends StatefulWidget {
  final FLService service;

  const ServiceAddContainer({super.key, required this.service});

  @override
  State<ServiceAddContainer> createState() => _ServiceAddContainerState();
}

class _ServiceAddContainerState extends State<ServiceAddContainer> {
  bool isShow = false;

  bool _isDeleteButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    //print(widget.service.serviceParamId);
    //final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30),
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
                        _quantityControl(),
                      ]),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  // Text(
                  //   widget.service.price.toString(),
                  //   style: const TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //     color: mySecondryTextColor,
                  //   ),
                  // ),
                  _showServicePrice(),
                  const Spacer(),
                  if (widget.service.hasParam == true)
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text(
                        widget.service.serviceParam,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: mySecondryTextColor,
                        ),
                      ),
                    )
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityControl() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _decrementButton(),
          Text(
            '${widget.service.quantity}',
            style: const TextStyle(fontSize: 16.0),
          ),
          _incrementButton(),
        ],
      ),
    );
  }

  Widget _showServicePrice() {
    if (widget.service.discountedPrice< widget.service.price) {
      return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          widget.service.price.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: mySecondryTextColor,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            widget.service.discountedPrice.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: mySecondryTextColor,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15),
          child: Text(
            '-${widget.service.discountedPercent.toString()}%',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        )
      ]);
    } else {
      return Text(
        widget.service.price.toString(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: mySecondryTextColor,
        ),
      );
    }
  }

  Widget _incrementButton() {
    return IconButton(
      icon: const Icon(Icons.add, color: Colors.black87),
      iconSize: 15,
      onPressed: () {
        setState(() {
          _isDeleteButtonDisabled = false;
          Provider.of<ServiceList>(context, listen: false)
              .addService(widget.service);
        });
      },
    );
  }

  Widget _decrementButton() {
    return IconButton(
      icon: const Icon(Icons.remove, color: Colors.black87),
      iconSize: 15,
      onPressed: _isDeleteButtonDisabled ? null : _handleDeleteButtonTap,
    );
  }

  void _handleDeleteButtonTap() {
    setState(() {
      Provider.of<ServiceList>(context, listen: false)
          .deleteService(widget.service);
    });
    if (widget.service.quantity == 0) {
      setState(() {
        _isDeleteButtonDisabled = true;
      });
    }
  }
}
