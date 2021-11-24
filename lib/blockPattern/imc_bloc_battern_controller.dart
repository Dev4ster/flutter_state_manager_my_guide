import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/blockPattern/imc_state.dart';

class ImcBlockPatternController {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(const ImcState(imc: 0));

  Stream<ImcState> get imcOut => _imcStreamController.stream;

  void handleCalculate(
      TextEditingController pesoEC, TextEditingController alturaEC) {
    final peso = double.tryParse(pesoEC.text.replaceAll(',', '.'));
    final altura = double.tryParse(alturaEC.text.replaceAll(',', '.'));
    if (peso == null || altura == null) {
      return;
    }

    _calcularImc(altura: altura, peso: peso);
  }

  Future<void> _calcularImc(
      {required double peso, required double altura}) async {
    _imcStreamController.add(ImcStateLoading());
    await Future.delayed(const Duration(seconds: 1));
    var imc = peso / pow(altura, 2);
    _imcStreamController.add(ImcState(imc: imc));
  }

  void dispose() {
    _imcStreamController.close();
  }
}
