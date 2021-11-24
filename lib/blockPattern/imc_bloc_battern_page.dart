import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/blockPattern/imc_bloc_battern_controller.dart';
import 'package:flutter_default_state_manager/blockPattern/imc_state.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  _ImcBlocPatternState createState() => _ImcBlocPatternState();
}

class _ImcBlocPatternState extends State<ImcBlocPatternPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final controller = ImcBlockPatternController();

  @override
  void dispose() {
    super.dispose();
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc Pattern"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    var imc = snapshot.data?.imc ?? 0;
                    return ImcGauge(imc: imc);
                  }),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data is ImcStateLoading,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }),
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
                  onPressed: () => controller.handleCalculate(pesoEC, alturaEC),
                  child: const Text("Calcular Imc"))
            ],
          ),
        ),
      ),
    );
  }
}
