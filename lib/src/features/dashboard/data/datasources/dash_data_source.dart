import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_take_home/src/features/dashboard/data/models/comment_model.dart';
import 'package:flutter_take_home/src/features/dashboard/data/models/post_model.dart';

abstract class DashDataSource {
  Future<Either<Exception, List<PostModel>>> fetchDashboardPosts(int limit, int page);
  Future<Either<Exception, PostModel>> fetchDashboardPost(int postId);
  Future<Either<Exception, List<CommentModel>>> fetchPostComments(int postId);
}

class DashDataSourceImpl implements DashDataSource {
  final dio = Dio();

  @override
  Future<Either<Exception, List<PostModel>>> fetchDashboardPosts(int limit, int page) async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
      final posts = (response.data as List).map((post) => PostModel.fromJson(post)).toList();
      return Right(posts);
    } catch (e) {
      return Left(Exception('Failed to fetch posts\n -> $e'));
    }
  }

  @override
  Future<Either<Exception, PostModel>> fetchDashboardPost(int postId) async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts/$postId');
      return Right(PostModel.fromJson(response.data));
    } catch (e) {
      return Left(Exception('Failed to fetch post $postId\n -> $e'));
    }
  }

  @override
  Future<Either<Exception, List<CommentModel>>> fetchPostComments(int postId) async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts/$postId/comments');
      final comments = (response.data as List).map((comment) => CommentModel.fromJson(comment)).toList();
      return Right(comments);
    } catch (e) {
      return Left(Exception('Failed to fetch comments for post $postId\n -> $e'));
    }
  }
}