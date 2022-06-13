import 'package:cats/data/datasource/remote_data_source.dart';
import 'package:cats/data/failures/remote_failure.dart';
import 'package:cats/domain/entities/cat.dart';
import 'package:cats/domain/repositories/remote_repository.dart';

import '../models/cat_model.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Cat>> getCats() async {
    final response = await _remoteDataSource.getCats();

    final statusCode = response.statusCode ?? 500;

    if (statusCode >= 200 && statusCode <= 299) {
      return CatModel.fromJsonList(response.data);
    } else {
      throw ServerFailure();
    }
  }
}
