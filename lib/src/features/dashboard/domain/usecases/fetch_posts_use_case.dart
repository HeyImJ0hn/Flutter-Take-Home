import 'package:flutter_take_home/src/features/dashboard/domain/repositories/api_repository.dart';

import '../entities/post.dart';

class FetchPostsUseCase {
  final DashRepository _dashRepository;

  FetchPostsUseCase(this._dashRepository);

  Future<List<Post>> call(int limit, int page) async {
    return await _dashRepository.fetchDashboardPosts(limit, page);
  }
}