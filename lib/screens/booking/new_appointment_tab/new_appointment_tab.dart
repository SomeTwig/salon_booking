import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/data/db_helper.dart';
import 'package:fl_booking_app/data/booking_data.dart';

class NewAppointmentTab extends StatefulWidget {
  const NewAppointmentTab(
      {super.key, required this.onSubmit, required this.onPrev});
  final VoidCallback onSubmit;
  final VoidCallback onPrev;

  @override
  State<NewAppointmentTab> createState() => _NewAppointmentTabState();
}

class _NewAppointmentTabState extends State<NewAppointmentTab>
    with AutomaticKeepAliveClientMixin<NewAppointmentTab> {
      
  final GlobalKey<FormState> clientCommentFormKey = GlobalKey<FormState>();
  final TextEditingController controllerComment = TextEditingController();

  late DatabaseHelper dbHelper;

  String initialCountry = 'UA';
  PhoneNumber pNumber = PhoneNumber(isoCode: 'UA');
  bool? check = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    dbHelper.initDatabase();
  }

  void dbCreateBooking() {
    BookingData bData = BookingData(
      date: Provider.of<BookingInfo>(context, listen: false).bDate,
      time: Provider.of<BookingInfo>(context, listen: false).bTime,
      salonName: Provider.of<BookingInfo>(context, listen: false).sName,
      salonId: Provider.of<BookingInfo>(context, listen: false).salonId,
      services: Provider.of<BookingInfo>(context, listen: false).services,
      priceTotal: Provider.of<BookingInfo>(context, listen: false).priceTotal,
      clientName: Provider.of<MyAccount>(context, listen: false).accountName,
      clientPhone: Provider.of<MyAccount>(context, listen: false).accountPhone,
      clientComment:
          Provider.of<BookingInfo>(context, listen: false).clientComment,
      personalPermit:
          Provider.of<BookingInfo>(context, listen: false).personalPermit,
    );
    dbHelper.insertBooking(bData);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 255, 221, 182),
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: FilledButton(
                onPressed: () => {
                  widget.onPrev(),
                },
                style: FilledButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    minimumSize: const Size(80, 48)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Назад'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      // <-- Icon
                      Icons.arrow_back_ios_rounded,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: FilledButton(
                onPressed: () {
                  if (clientCommentFormKey.currentState!.validate() && Provider.of<MyAccount>(context, listen: false).accountLogedIn()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Создание бронировки... \n')),
                    );
                    clientCommentFormKey.currentState?.save();
                    dbCreateBooking();
                    widget.onSubmit();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Пожалуйста, заполните ваши данные')),
                    );
                  }
                },
                style: FilledButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    minimumSize: const Size(80, 48)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Бронировать'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 70,
        ),
        child: newAppointmentInfo(),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget chooseWidget() {
    if (Provider.of<MyAccount>(context, listen: false).accountPhone.isEmpty) {
      return FilledButton(
        onPressed: () {
          GoRouter.of(context)
              .push('/login', extra: {"pageData": 'appointment'});
        },
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color.fromARGB(255, 3, 166, 166),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          fixedSize: const Size.fromWidth(124),
        ),
        child: const Text('Login'),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Provider.of<MyAccount>(context, listen: false).accountName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          Provider.of<MyAccount>(context, listen: false).accountPhone,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget newAppointmentInfo() {
    return ListView(
      children: [
        const Text(
          'Ваш запис до салону',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          Provider.of<BookingInfo>(context, listen: false).sName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 221, 182),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      Provider.of<BookingInfo>(context, listen: false).bDate,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 221, 182),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      Provider.of<BookingInfo>(context, listen: false).bTime,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Text(
          'Акаунт',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 255, 221, 182)),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Center(
            child: Consumer<MyAccount>(
              builder: (context, account, child) => chooseWidget(),
            ),
          ),
        ),
        Form(
          key: clientCommentFormKey,
          child: TextFormField(
            controller: controllerComment,
            decoration: const InputDecoration(
              labelText: "Комментарий",
            ),
            keyboardType: TextInputType.multiline,
            maxLength: 400,
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
