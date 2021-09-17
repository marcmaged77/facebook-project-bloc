import 'package:facebook/models/models.dart';


abstract class BasePostRepository{
  Future<void> createPost({required Posts post});
  Future<void> createComment({required Comment comment});



  //to fetch user posts
  Stream<List<Future<Posts?>>> getUserPosts({required String userId});


//to fetch comments in every post
  Stream<List<Future<Comment?>>> getPostComments({required String postId});



}