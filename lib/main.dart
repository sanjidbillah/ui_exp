import 'package:flutter/material.dart';

import 'delete_account.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: const Ui());
  }
}

class Ui extends StatelessWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierColor: Colors.black12,
              builder: (_) {
                return const AlertDialog(
                  content: Wrap(
                    children: [
                      DeleteAccount(),
                    ],
                  ),
                );
              },
            );
          },
          child: const Text("Show Delete Widget"),
        ),
      ),
    );
  }
}
