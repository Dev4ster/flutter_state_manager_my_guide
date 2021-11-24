import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcValueNotifierPage extends StatefulWidget {
  const ImcValueNotifierPage({Key? key}) : super(key: key);

  @override
  _ImcValueNotifierState createState() => _ImcValueNotifierState();
}

class _ImcValueNotifierState extends State<ImcValueNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  var imc = ValueNotifier(0.0);

  void _handleCalculate() {
    final peso = double.tryParse(pesoEC.text.replaceAll(',', '.'));
    final altura = double.tryParse(alturaEC.text.replaceAll(',', '.'));
    if (peso == null || altura == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Altura ou Peso vazio!")));
      return;
    }

    _calcularImc(altura: altura, peso: peso);
  }

  void _calcularImc({required double peso, required double altura}) {
    imc.value = peso / pow(altura, 2);
  }

  @override
  void dispose() {
    super.dispose();
    pesoEC.dispose();
    alturaEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Value Notifier"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ValueListenableBuilder<double>(
                  valueListenable: imc,
                  builder: (context, value, _) => ImcGauge(imc: value)),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Peso'),
                keyboardType: TextInputType.number,
                controller: pesoEC,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true)
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Altura'),
                keyboardType: TextInputType.number,
                controller: alturaEC,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: _handleCalculate,
                  child: const Text("Calcular Imc"))
            ],
          ),
        ),
      ),
    );
  }
}
