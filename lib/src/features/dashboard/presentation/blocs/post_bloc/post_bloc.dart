import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_take_home/src/core/constants/app_strings.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/usecases/fetch_post_use_case.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FetchPostUseCase fetchPostUseCase;

  PostBloc(this.fetchPostUseCase) : super(PostInitial()) {
    on<FetchPostEvent>(_onFetchPost);
  }

  Future<void> _onFetchPost(FetchPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());

    final result = await fetchPostUseCase.call(event.postId);

    emit(result.fold(
      (exception) => PostFailure(error: '${AppStrings.postBlocFailure}\n -> ${exception.toString()}'),
      (post) => PostSuccess(post: post),
    ));
  }
}
