import 'package:cats/common/constants/colors.dart';
import 'package:flutter/material.dart';

import '../notifiers/cats_list_notifier.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CatsListNotifier _catsListNotifier = CatsListNotifier();

  @override
  void initState() {
    _catsListNotifier.getCatsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return AnimatedBuilder(
        animation: _catsListNotifier,
        builder: (context, _) {
          if (!_catsListNotifier.loading) {
            if (!_catsListNotifier.serverError &&
                !_catsListNotifier.syntaxError) {
              _moveToHome();
            } else {
              _moveToError();
            }
          }
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/splash_screen.png',
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.fill,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Catbreeds',
                          style: themeData.textTheme.headline1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void _moveToHome() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(context, 'home'));
  }

  void _moveToError() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(context, 'error'));
  }
}
