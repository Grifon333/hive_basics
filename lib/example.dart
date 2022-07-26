import 'package:flutter/material.dart';
import 'package:hive_basics/example_widget_model.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ExampleWidgetModel();

    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: model.add,
                  child: const Text('Add'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: model.setup,
                  child: const Text('Setup'),
                ),
                // const SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: model.secureStorage,
                //   child: const Text('Save secure storage'),
                // ),
              ],
            ),
          ),
        )
    );
  }
}
