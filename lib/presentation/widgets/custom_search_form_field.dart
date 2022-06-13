import 'package:flutter/material.dart';

import '../notifiers/cats_list_notifier.dart';

class CustomSearchFormField extends StatelessWidget {
  CustomSearchFormField({Key? key}) : super(key: key);

  final CatsListNotifier _catsListNotifier = CatsListNotifier();

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return TextFormField(
      autofocus: false,
      onChanged: (value) {
        _catsListNotifier.query = value;
      },
      style: appTheme.textTheme.bodyText1,
      decoration: const InputDecoration(
          hintText: 'Find your favorite cat by its breed...'),
    );
  }
}
