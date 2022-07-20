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
            child: ElevatedButton(
              onPressed: model.doSome,
              child: const Text('Press me'),
            ),
          ),
        )
    );
  }
}
