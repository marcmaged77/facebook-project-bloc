import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/config/paths.dart';
import 'package:flutter/material.dart';

import 'models.dart';


class Posts extends Equatable {
  final String? id;
  final Users author;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;
  final DateTime date;

  const Posts({
    this.id,
    required this.author,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,

    required this.date,
  });

  @override
  List<Object?> get props => [
    id,
    author,
    imageUrl,
    caption,
    likes,
    comments,
    date,
  ];

  Posts copyWith({
    String? id,
    Users? author,
    String? imageUrl,
    String? caption,
    int? likes,
    int? comments,
    DateTime? date,
  }) {
    return Posts(
      id: id ?? this.id,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      date: date ?? this.date,
    );
  }





  Map<String, dynamic> toDocument() {
    return {
      'author':
      FirebaseFirestore.instance.collection('users').doc(author.id),
      'imageUrl': imageUrl,
      'caption': caption,
      'likes': likes,
      'comments': comments,
      'date': Timestamp.fromDate(date),
    };
  }

  static Future<Posts?> fromDocument(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;
    final authorRef = data['author'] as DocumentReference?;
    if (authorRef != null) {
      final authorDoc = await authorRef.get();
      if (authorDoc.exists) {
        return Posts(
          id: doc.id,
          author: Users.fromDocument(authorDoc),
          imageUrl: data['imageUrl'] ?? '',
          caption: data['caption'] ?? '',
          likes: (data['likes'] ?? 0).toInt(),
          comments: (data['comments']?? 0).toInt(),
          date: (data['date'] as Timestamp).toDate(),
        );
      }
    }
    return null;
  }
}