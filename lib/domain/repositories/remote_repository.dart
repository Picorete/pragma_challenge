import 'package:cats/domain/entities/cat.dart';

abstract class RemoteRepository {
  Future<List<Cat>> getCats();
}
