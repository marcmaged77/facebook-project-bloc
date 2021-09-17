import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/config/paths.dart';
import 'package:facebook/models/firebase_comment_model.dart';
import 'package:facebook/models/firebase_post_model.dart';
import 'package:facebook/models/post_model.dart';
import 'package:facebook/repositories/Posts/base_post_repository.dart';

class PostRepository extends BasePostRepository {
  final FirebaseFirestore _firebaseFirestore;

  PostRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createPost({required Posts post}) async {
    await _firebaseFirestore.collection(Paths.posts).add(post.toDocument());
  }

  @override
  Future<void> createComment({required Comment comment}) async {
    await _firebaseFirestore
    //go to comment collection
        .collection(Paths.comments)
    //create a document wiht post id
        .doc(comment.postId)
        .collection(Paths.postComments)
        .add(comment.toDocument());
  }

  

  @override
  Stream<List<Future<Posts?>>> getUserPosts({required String userId}) {
    final authorRef = _firebaseFirestore.collection(Paths.users).doc(userId);
    return _firebaseFirestore
        .collection(Paths.posts)
        .where('author', isEqualTo: authorRef)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) =>
        snap.docs.map((doc) => Posts.fromDocument(doc)).toList());
  }



  @override
  Stream<List<Future<Comment?>>> getPostComments({required String postId}) {
return _firebaseFirestore
    .collection(Paths.comments)
    .doc(postId)
    .collection(Paths.postComments)
    .orderBy('date', descending: false)
    .snapshots()
    .map((snap) =>
    snap.docs.map((doc) => Comment.fromDocument(doc)).toList());  }
  
}