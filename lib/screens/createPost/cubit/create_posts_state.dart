part of 'create_posts_cubit.dart';



enum CreatePostStatus { initial, submitting , success, error}

 class CreatePostsState extends Equatable{

  final File? postImage;
  final String caption;
  final CreatePostStatus status;
  final Failure failure;




  const CreatePostsState({
    required this.postImage,
    required this.caption,
    required this.status,
    required this.failure,
  });



  factory CreatePostsState.initial() {
    return const CreatePostsState(
      postImage: null,
      caption: '',
      status: CreatePostStatus.initial,
      failure: Failure(),
    );
  }

@override
  List<Object?> get props => [postImage,caption,status,failure];



  CreatePostsState copyWith({
    File? postImage,
    String? caption,
    CreatePostStatus? status,
    Failure? failure,
  }) {
    return CreatePostsState(
      postImage: postImage ?? this.postImage,
      caption: caption ?? this.caption,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

}

