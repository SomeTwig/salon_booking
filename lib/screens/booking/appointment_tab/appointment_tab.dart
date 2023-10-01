import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/models/models.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerComment = TextEditingController();

  String initialCountry = 'UA';
  PhoneNumber pNumber = PhoneNumber(isoCode: 'UA');
  bool? check = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(157, 192, 158, 120),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: ElevatedButton(
                onPressed: () => {
                  widget.onPrev(),
                },
                style: ElevatedButton.styleFrom(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    minimumSize: Size(100, 50)),
                child: Row(
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
            Spacer(),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Создание бронировки... \n')),
                    );
                    formKey.currentState?.save();
                    Provider.of<BookingInfo>(context, listen: false)
                        .addClientInfo(
                            controllerName.text,
                            pNumber.phoneNumber.toString(),
                            controllerComment.text,
                            check!);
                    widget.onSubmit();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Пожалуйста, проверьте ваши данные')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    minimumSize: Size(100, 50)),
                child: Row(
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
                  'Выбраный салон: \n${Provider.of<BookingInfo>(context, listen: false).sName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Выбраное время: \n${Provider.of<BookingInfo>(context, listen: false).bDate} \n ${Provider.of<BookingInfo>(context, listen: false).bTime}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Form(
                    key: formKey,
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: controllerName,
                            decoration: InputDecoration(
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
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            initialValue: pNumber,
                            textFieldController: controllerPhone,
                            formatInput: true,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            hintText: 'Номер телефона',
                            errorMessage: 'Неправильный номер',
                            inputBorder: OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {
                              pNumber = number;
                              print('On Saved: $number');
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: controllerComment,
                            decoration: InputDecoration(
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
                            title: Text(
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

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // final TextEditingController controller = TextEditingController();
  // String initialCountry = 'NG';
  // PhoneNumber number = PhoneNumber(isoCode: 'NG');

  // @override
  // Widget build(BuildContext context) {
  //   return Form(
  //     key: formKey,
  //     child: Container(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           InternationalPhoneNumberInput(
  //             onInputChanged: (PhoneNumber number) {
  //               print(number.phoneNumber);
  //             },
  //             onInputValidated: (bool value) {
  //               print(value);
  //             },
  //             selectorConfig: SelectorConfig(
  //               selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
  //             ),
  //             ignoreBlank: false,
  //             autoValidateMode: AutovalidateMode.disabled,
  //             selectorTextStyle: TextStyle(color: Colors.black),
  //             initialValue: number,
  //             textFieldController: controller,
  //             formatInput: true,
  //             keyboardType:
  //                 TextInputType.numberWithOptions(signed: true, decimal: true),
  //             inputBorder: OutlineInputBorder(),
  //             onSaved: (PhoneNumber number) {
  //               print('On Saved: $number');
  //             },
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               formKey.currentState?.validate();
  //             },
  //             child: Text('Validate'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               getPhoneNumber('+15417543010');
  //             },
  //             child: Text('Update'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               formKey.currentState?.save();
  //             },
  //             child: Text('Save'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void getPhoneNumber(String phoneNumber) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

  //   setState(() {
  //     this.number = number;
  //   });
  // }

  @override
  void dispose() {
    controllerPhone.dispose();
    controllerName.dispose();
    super.dispose();
  }
}
