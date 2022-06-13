import 'package:cats/common/widgets/custom_app_padding.dart';
import 'package:cats/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../notifiers/cats_list_notifier.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({Key? key}) : super(key: key);

  final CatsListNotifier _catsListNotifier = CatsListNotifier();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/splash_screen.png',
            height: size.height,
            width: size.width,
            fit: BoxFit.fill,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'An error has occurred :(',
                  style: themeData.textTheme.headline2,
                ),
                CustomElevatedButton(
                    child: const Text('Retry'),
                    onPressed: () {
                      _catsListNotifier.retry();
                      Navigator.pushReplacementNamed(context, 'splash');
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
