import 'package:cats/data/repositories/remote_repository_impl.dart';
import 'package:cats/domain/entities/cat.dart';
import 'package:cats/domain/repositories/remote_repository.dart';

class GetCatsListUseCase {
  static final GetCatsListUseCase _singleton = GetCatsListUseCase._internal();

  factory GetCatsListUseCase() {
    return _singleton;
  }

  GetCatsListUseCase._internal();

  final RemoteRepository _remoteRepository = RemoteRepositoryImpl();

  Future<List<Cat>> call() async {
    return await _remoteRepository.getCats();
  }
}
