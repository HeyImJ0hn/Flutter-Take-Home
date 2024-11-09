import 'package:either_dart/either.dart';
import 'package:flutter_take_home/src/features/dashboard/data/datasources/dash_data_source.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/entities/comment.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/entities/post.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/repositories/api_repository.dart';

class DashRepositoryImpl implements DashRepository{
  final DashDataSource apiDataSource;

  DashRepositoryImpl(this.apiDataSource);

  @override
  Future<Either<Exception, List<Post>>> fetchDashboardPosts(int limit, int page) async {
    final result = await apiDataSource.fetchDashboardPosts(limit, page);
    return result.fold(
      (exception) => Left(exception),
      (postModels) => Right(postModels.map((postModel) => postModel.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Exception, Post>>fetchDashboardPost(int postId) async {
    final result = await apiDataSource.fetchDashboardPost(postId);
    return result.fold(
      (exception) => Left(exception),
      (postModel) => Right(postModel.toEntity()),
    );
  }

  @override
  Future<Either<Exception, List<Comment>>> fetchPostComments(int postId) async {
    final result = await apiDataSource.fetchPostComments(postId);
    return result.fold(
      (exception) => Left(exception),
      (commentModels) => Right(commentModels.map((commentModel) => commentModel.toEntity()).toList()),
    );
  }

}