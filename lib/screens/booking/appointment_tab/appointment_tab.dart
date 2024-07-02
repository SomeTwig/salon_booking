import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/data/db_helper.dart';
import 'package:fl_booking_app/data/booking_data.dart';


class AppointmentTab extends StatefulWidget {
  const AppointmentTab(
      {super.key, required this.onSubmit, required this.onPrev});
  final VoidCallback onSubmit;
  final VoidCallback onPrev;

  @override
  State<AppointmentTab> createState() => _AppointmentTabState();
}

class _AppointmentTabState extends State<AppointmentTab>
    with AutomaticKeepAliveClientMixin<AppointmentTab> {

  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerComment = TextEditingController();

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
      clientName: Provider.of<BookingInfo>(context, listen: false).clientName,
      clientPhone: Provider.of<BookingInfo>(context, listen: false).clientPhone,
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
                  if (personalFormKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Создание бронировки... \n')),
                    );
                    personalFormKey.currentState?.save();
                    Provider.of<BookingInfo>(context, listen: false)
                        .addClientInfo(
                            controllerName.text,
                            pNumber.phoneNumber.toString(),
                            controllerComment.text,
                            check!);
                    dbCreateBooking();
                    widget.onSubmit();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Пожалуйста, проверьте ваши данные')),
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
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
              child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 70,
            ),
            child: Column(
              children: [
                Text(
                  'Выбраное время: \n${Provider.of<BookingInfo>(context, listen: false).bDate} \n ${Provider.of<BookingInfo>(context, listen: false).bTime}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Form(
                    key: personalFormKey,
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: controllerName,
                            decoration: const InputDecoration(
                              labelText: "Имя",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Введите имя';
                              }
                              return null;
                            },
                            maxLength: 40,
                          ),
                          const SizedBox(height: 30),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
                            initialValue: pNumber,
                            textFieldController: controllerPhone,
                            formatInput: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            hintText: 'Номер телефона',
                            errorMessage: 'Неправильный номер',
                            inputBorder: const OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {
                              pNumber = number;
                              print('On Saved: $number');
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: controllerComment,
                            decoration: const InputDecoration(
                              labelText: "Комментарий",
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLength: 400,
                            maxLines: null,
                          ),
                          const SizedBox(height: 30),
                          CheckboxListTile(
                            //checkbox positioned at left
                            value: check,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (bool? value) {
                              setState(() {
                                check = value;
                              });
                            },
                            title: const Text(
                                "Разрешить использование персональных данных"),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )),
              ],
            ),
          ))),
    );
  }

  @override
  void dispose() {
    controllerPhone.dispose();
    controllerName.dispose();
    super.dispose();
  }
}
