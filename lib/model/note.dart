import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String? id;
  final String title;
  final String content;

  Note({
    this.id,
    required this.title,
    required this.content,
  });

  toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  factory Note.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Note(
      id: document.id,
      title: data['title'],
      content: data['content'],
    );
  }
}
