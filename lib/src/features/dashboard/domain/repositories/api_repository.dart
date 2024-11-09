import 'package:either_dart/either.dart';

import '../entities/post.dart';
import '../entities/comment.dart';

abstract class DashRepository {
  Future<Either<Exception, List<Post>>> fetchDashboardPosts(int limit, int page);
  Future<Either<Exception, Post>> fetchDashboardPost(int postId);
  Future<Either<Exception, List<Comment>>> fetchPostComments(int postId);
}