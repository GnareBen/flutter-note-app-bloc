import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/model/note.dart';

class FirebaseNoteRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insert(Map<String, dynamic> note) async {
    await db.collection('notes').add(note);
  }

  Future<List<Note>> notes() async {
    final snapshot = await db.collection('notes').get();
    return snapshot.docs.map((doc) => Note.fromSnapshot(doc)).toList();
  }

  Future<void> update(Note note) async {
    await db.collection('notes').doc(note.id).update(note.toJson());
  }

  Future<void> delete(String id) async {
    await db.collection('notes').doc(id).delete();
  }

  Future<void> deleteAll() async {
    final snapshot = await db.collection('notes').get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}