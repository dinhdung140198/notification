import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tgs/internal/utils/style.dart';

class ErrorPage extends StatelessWidget {
  final String? error;

  const ErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_rounded, size: 48, color: Colors.red,),
            const SizedBox(height: 12),
            Text(
              kDebugMode
                  ? error!
                  : 'Oops! Something went wrong!',
              textAlign: TextAlign.center,
              style: AppTextStyle.bold.copyWith(
                color: kDebugMode ? Colors.red : Colors.black,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              kDebugMode
                  ? 'https://docs.flutter.dev/testing/errors'
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              textAlign: TextAlign.center,
              style: AppTextStyle.normal,
            ),
          ],
        ),
      ),
    );
  }
}