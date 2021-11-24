import 'dart:math';

import 'package:flutter/material.dart';

class ImcChangeNotifierController extends ChangeNotifier {
  var imc = 0.0;

  ImcChangeNotifierController();

  void handleCalculate(
      TextEditingController pesoEC, TextEditingController alturaEC) {
    final peso = double.tryParse(pesoEC.text.replaceAll(',', '.'));
    final altura = double.tryParse(alturaEC.text.replaceAll(',', '.'));
    if (peso == null || altura == null) {
      return;
    }

    _calcularImc(altura: altura, peso: peso);
  }

  void _calcularImc({required double peso, required double altura}) {
    imc = peso / pow(altura, 2);
    notifyListeners();
  }
}
