import 'package:flutter/material.dart';
import 'package:one_checkbox/one_checkbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneCheckbox Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'OneCheckbox Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _checkboxAController = OneCheckboxController();
  final _checkboxBController = OneCheckboxController();
  final _checkboxCController = OneCheckboxController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OneCheckbox(
              controller: _checkboxAController,
            ),
            OneCheckbox(
              label: const Text('With label'),
              controller: _checkboxBController,
            ),
            OneCheckbox(
              label: const Text('With another icon'),
              checkedIcon: const Icon(Icons.access_time_filled, color: Colors.red),
              uncheckIcon: const Icon(Icons.access_time, color: Colors.green),
              controller: _checkboxCController,
            ),
            TextButton(
              onPressed: () {
                _checkboxAController.isChecked = true;
                _checkboxBController.isChecked = true;
                _checkboxCController.isChecked = true;
              },
              child: const Text('Check all'),
            ),
            TextButton(
              onPressed: () {
                _checkboxAController.isChecked = false;
                _checkboxBController.isChecked = false;
                _checkboxCController.isChecked = false;
              },
              child: const Text('Uncheck all'),
            ),
          ],
        ),
      ),
    );
  }
}
