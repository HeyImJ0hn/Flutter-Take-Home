import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_take_home/src/core/constants/app_strings.dart';

import '../../../domain/entities/comment.dart';
import '../../../domain/usecases/fetch_comments_use_case.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {

  final FetchCommentsUseCase fetchCommentsUseCase;

  DetailsBloc(this.fetchCommentsUseCase) : super(DetailsInitial()) {
    on<FetchCommentsEvent>(_onFetchComments);
  }

  Future<void> _onFetchComments(FetchCommentsEvent event, Emitter<DetailsState> emit) async {
    emit(DetailsLoading());

    final result = await fetchCommentsUseCase.call(event.postId);
    emit(result.fold(
      (exception) => DetailsFailure(error: '${AppStrings.detailsBlocFailure}\n -> ${exception.toString()}'),
      (comments) => DetailsSuccess(comments: comments),
    ));
  }
}
