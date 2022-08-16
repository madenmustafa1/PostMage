// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '/util/app_util.dart';
import '/util/color_util.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class PhoneNumberTextField extends StatelessWidget {
  PhoneNumberTextField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  String initialCountry = 'TR';
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 15,
        ),
        child: InternationalPhoneNumberInput(
          textStyle: TextStyle(
            fontSize: AppUtil.getHeight(context) / 50,
            color: ColorUtil.MAIN_COLOR,
            fontWeight: FontWeight.w900,
          ),
          inputDecoration: InputDecoration(
            border: InputBorder.none,
            labelText: constants.phoneNumber,
            labelStyle: TextStyle(
              color: ColorUtil.MAIN_COLOR,
              fontWeight: FontWeight.w900,
            ),
          ),

          onInputChanged: (PhoneNumber number) {
            //print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            //print(value);
          },
          initialValue: number,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.black),
          //initialValue: ,
          textFieldController: controller,
          formatInput: false,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputBorder: const OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            //print('On Saved: $number');
          },
        ),
      ),
    );
  }
}
