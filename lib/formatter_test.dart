import 'package:cell_input/precision_limit_formatter.dart';
import 'package:flutter/material.dart';

class FormatterTest extends StatelessWidget {
 final int _precision = 6;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: TextField(
          inputFormatters: [PrecisionLimitFormatter(_precision)],
          keyboardType: TextInputType.numberWithOptions(),
          onChanged: (v) {},
        ),
      ),
    );
  }
}
