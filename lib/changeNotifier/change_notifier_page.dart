import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/changeNotifier/imc_change_notifier_controller.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';

class ImcChangeNotifierPage extends StatefulWidget {
  const ImcChangeNotifierPage({Key? key}) : super(key: key);

  @override
  _ImcChangeNotifierState createState() => _ImcChangeNotifierState();
}

class _ImcChangeNotifierState extends State<ImcChangeNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  final imcController = ImcChangeNotifierController();

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
        title: const Text("Change Notifier"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AnimatedBuilder(
                  animation: imcController,
                  builder: (context, child) =>
                      ImcGauge(imc: imcController.imc)),
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
                  onPressed: () =>
                      imcController.handleCalculate(pesoEC, alturaEC),
                  child: const Text("Calcular Imc"))
            ],
          ),
        ),
      ),
    );
  }
}
