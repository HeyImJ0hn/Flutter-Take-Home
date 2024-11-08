import 'package:flutter_take_home/src/features/dashboard/domain/repositories/api_repository.dart';

import '../entities/comment.dart';

class FetchCommentsUseCase {
  final DashRepository _dashRepository;

  FetchCommentsUseCase(this._dashRepository);

  Future<List<Comment>> call(int postId) async {
    return _dashRepository.fetchPostComments(postId);
  }
}