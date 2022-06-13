import 'package:cats/domain/usecases/get_cats_list_use_case.dart';
import 'package:flutter/material.dart';

import '../../common/failure.dart';
import '../../domain/entities/cat.dart';

class CatsListNotifier extends ChangeNotifier {
  static final CatsListNotifier _singleton = CatsListNotifier._internal();

  factory CatsListNotifier() {
    return _singleton;
  }

  CatsListNotifier._internal();

  final GetCatsListUseCase _getCatsListUseCase = GetCatsListUseCase();

  late List<Cat> _cats;
  bool loading = true;
  bool serverError = false;
  bool syntaxError = false;
  String _query = '';

  set query(String value) {
    _query = value.toLowerCase();
    notifyListeners();
  }

  String get query => _query;

  List<Cat> get cats =>
      _cats.where((cat) => cat.name.toLowerCase().contains(_query)).toList();

  void getCatsList() async {
    try {
      _cats = await _getCatsListUseCase();
    } on Failure catch (_) {
      serverError = true;
    } catch (_) {
      syntaxError = true;
    }

    loading = false;
    notifyListeners();
  }

  void retry() {
    loading = true;
    serverError = false;
    syntaxError = false;
    getCatsList();
  }
}
