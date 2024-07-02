import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/models/models.dart';

class ServiceContainer extends StatefulWidget {
  final FLService service;

  const ServiceContainer({super.key, required this.service});

  @override
  State<ServiceContainer> createState() => _ServiceContainerState();
}

class _ServiceContainerState extends State<ServiceContainer> {
  bool _isDeleteButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(children: [
          Padding(
              padding: const EdgeInsets.only(top: 2, left: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(flex: 10, child: Text(widget.service.serviceName)),
                const Spacer(),
                _quantityControl(widget.service),
              ]))
        ]));
  }

  Widget _quantityControl(FLService aService) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _decrementButton(aService),
          const SizedBox(
            width: 15,
          ),
          Text(
            '${aService.quantity}',
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            width: 15,
          ),
          _incrementButton(aService),
        ],
      ),
    );
  }

  Widget _incrementButton(FLService aService) {
    return IconButton(
      onPressed: () {
        _isDeleteButtonDisabled = false;
        setState(() {
          Provider.of<BookingInfo>(context, listen: false).addService(aService);
        });
      },
      icon: const Icon(Icons.add, color: Colors.black87),
    );
  }

  Widget _decrementButton(FLService aService) {
    return IconButton(
      onPressed: () {
        if (_isDeleteButtonDisabled == true) {
          null;
        } else {
          _handleDeleteButtonTap(aService);
        }
      },
      icon: const Icon(Icons.remove, color: Colors.black87),
    );
  }

  void _handleDeleteButtonTap(FLService aService) {
    setState(() {
      Provider.of<BookingInfo>(context, listen: false).deleteService(aService);
    });
    if (aService.quantity == 0) {
      setState(() {
        _isDeleteButtonDisabled = true;
      });
    }
  }
}
