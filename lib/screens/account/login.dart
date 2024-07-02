import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/data/db_helper.dart';

import 'package:fl_booking_app/models/models.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.pageData});

  final String? pageData;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> clientLoginFormKey = GlobalKey<FormState>();
  final TextEditingController controllerPhone = TextEditingController();

  String initialCountry = 'UA';
  PhoneNumber pNumber = PhoneNumber(isoCode: 'UA');

  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    dbHelper.initDatabase();
    dbHelper.getAllAccountPhones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (widget.pageData == 'appointment') {
              GoRouter.of(context).pop();
            } else {
              GoRouter.of(context).go('/home');
            }
          },
        ),
        title: const Text('Login'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: clientLoginFormKey,
                child: Expanded(
                  child: InternationalPhoneNumberInput(
                    inputDecoration: InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    onInputChanged: (PhoneNumber number) {},
                    onInputValidated: (bool value) {},
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
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
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: FilledButton(
                  onPressed: () async {
                    //CHANGE
                    if (clientLoginFormKey.currentState!.validate()) {
                      clientLoginFormKey.currentState?.save();
                      List<Map> result =
                          await dbHelper.getAccount(pNumber.phoneNumber!);
                      if (result.isEmpty) {
                        if (context.mounted) {
                          GoRouter.of(context)
                              .push('/register', extra: {"phoneData": pNumber});
                        }
                      } else {
                        if (context.mounted) {
                          Provider.of<MyAccount>(context, listen: false)
                              .addAccount(result.first['accountName'],
                                  result.first['accountPhone']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All good!')),
                          );
                          if (widget.pageData == 'appointment') {
                            GoRouter.of(context).pop();
                          } else {
                            GoRouter.of(context).go('/home');
                          }
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Check again')),
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 111, 247, 246),
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
    );
  }
}
