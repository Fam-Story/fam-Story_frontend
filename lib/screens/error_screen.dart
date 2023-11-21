import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("! An error occurred !"),
            Text("please turn the app off and re-open."),
          ],
        ),
      ),
    );
  }
}
