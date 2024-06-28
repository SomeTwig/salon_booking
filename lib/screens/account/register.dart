import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/data/db_helper.dart';

import 'package:fl_booking_app/models/models.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.phoneData});

  final PhoneNumber? phoneData;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> clientRegisterFormKey = GlobalKey<FormState>();
  final TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerName = TextEditingController();

  String initialCountry = 'UA';
  PhoneNumber pNumber = PhoneNumber(isoCode: 'UA');

  bool isChecked = false;

  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    dbHelper.initDatabase();
  }

  void validateFunction() {
    if (clientRegisterFormKey.currentState!.validate() && isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All good!')),
      );
      clientRegisterFormKey.currentState?.save();
      Provider.of<MyAccount>(context, listen: false)
          .addAccount(controllerName.text, pNumber.phoneNumber.toString());
      dbHelper.insertAccount(MyAccount(
          accountName: controllerName.text,
          accountPhone: pNumber.phoneNumber!));
      GoRouter.of(context).go('/account');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check again')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Register'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 70,
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: clientRegisterFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: InternationalPhoneNumberInput(
                          inputDecoration: InputDecoration(
                            labelText: "Phone",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialValue: widget.phoneData,
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
                      ),
                      TextFormField(
                        controller: controllerName,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите имя';
                          }
                          return null;
                        },
                        maxLength: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Flexible(
                            child: Text(
                              'Я погоджуюсь з умовами політики конфіденційності і дозволяю обробку моїх даних. *',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: FilledButton(
                      onPressed: isChecked ? validateFunction : null,
                      style: FilledButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromARGB(255, 111, 247, 246),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Продовжити',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
