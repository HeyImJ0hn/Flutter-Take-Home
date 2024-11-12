import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_take_home/src/core/constants/app_strings.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/usecases/fetch_posts_use_case.dart';

import '../../../domain/entities/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  final FetchPostsUseCase fetchPostsUseCase;

  PostsBloc(this.fetchPostsUseCase) 
      : super(PostsInitial()) {
    on<FetchPostsEvent>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPostsEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoading());

    final result = await fetchPostsUseCase.call(event.limit, event.page);
    emit(result.fold(
      (exception) => PostsFailure(error: '${AppStrings.postsBlocFailure}\n -> ${exception.toString()}'),
      (posts) => PostsSuccess(posts: posts),
    ));
  }

}