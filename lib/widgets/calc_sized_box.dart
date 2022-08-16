import 'package:flutter/cupertino.dart';

import '../util/app_util.dart';

class CalcSizedBox extends StatelessWidget {
  final int calc;
  const CalcSizedBox({Key? key, required this.calc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: AppUtil.getHeight(context) / calc);
  }
}