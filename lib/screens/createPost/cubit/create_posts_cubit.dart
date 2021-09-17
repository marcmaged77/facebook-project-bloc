import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/blocs/auth/auth_bloc.dart';
import 'package:facebook/models/failure_model.dart';
import 'package:facebook/models/firebase_user_model.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'create_posts_state.dart';

class CreatePostsCubit extends Cubit<CreatePostsState> {
  final PostRepository _postRepository;
  final StorageRepository _storageRepository;


  final AuthBloc _authBloc;

  CreatePostsCubit({
    required PostRepository postRepository,
    required StorageRepository storageRepository,
    required AuthBloc})
      : _postRepository = postRepository,
        _storageRepository =storageRepository,
        _authBloc =AuthBloc,
        super(CreatePostsState.initial());


  void postImageChanged(File file) {
    emit(state.copyWith(postImage: file, status: CreatePostStatus.initial));
  }

  void captionChanged(String caption) {
    emit(state.copyWith(caption: caption, status: CreatePostStatus.initial));
  }


  void submit() async {
    emit(state.copyWith(status: CreatePostStatus.submitting));
    try {


      //submit functions post and image
final author = Users.empty.copyWith(id: _authBloc.state.user!.uid);
final postImageUrl =
await _storageRepository.uploadPostImage(image: state.postImage!);


final post = Posts(
  author: author,
  imageUrl: postImageUrl,
  caption: state.caption,
  likes: 0,
  comments:0,
  date: DateTime.now(),
);

await _postRepository.createPost(post: post);
emit(state.copyWith(status: CreatePostStatus.success));
    } catch (err) {
      emit(state.copyWith(
          status: CreatePostStatus.error,
          failure: const Failure(message:'We were unable to create yor post.')));
    }
  }



  void reset(){
    //default state
    emit(CreatePostsState.initial());
  }
}
