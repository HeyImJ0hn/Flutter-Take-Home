import '../entities/post.dart';
import '../entities/comment.dart';

abstract class DashRepository {
  Future<List<Post>> fetchDashboardPosts(int limit, int page);
  Future<Post> fetchDashboardPost(int postId);
  Future<List<Comment>> fetchPostComments(int postId);
}