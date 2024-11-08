import 'package:flutter_take_home/src/features/dashboard/domain/repositories/api_repository.dart';

import '../entities/post.dart';

class FetchPostUseCase {
  final DashRepository _dashRepository;

  FetchPostUseCase(this._dashRepository);

  Future<Post> call(int id) async {
    return _dashRepository.fetchDashboardPost(id);
  }
}