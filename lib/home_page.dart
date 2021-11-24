import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/blockPattern/imc_bloc_battern_page.dart';
import 'package:flutter_default_state_manager/changeNotifier/change_notifier_page.dart';
import 'package:flutter_default_state_manager/setState/imc_setstate_page.dart';
import 'package:flutter_default_state_manager/valueNotifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return page;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _goToPage(context, const ImcSetStatePage());
                },
                child: const Text("SetState"),
              ),
              ElevatedButton(
                onPressed: () {
                  _goToPage(context, const ImcValueNotifierPage());
                },
                child: const Text("ValueNotifier"),
              ),
              ElevatedButton(
                onPressed: () {
                  _goToPage(context, const ImcChangeNotifierPage());
                },
                child: const Text("ChangeNotifier"),
              ),
              ElevatedButton(
                onPressed: () {
                  _goToPage(context, const ImcBlocPatternPage());
                },
                child: const Text("Bloc Pattern (Streams)"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
