part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NoteLoad extends NoteEvent {}

class NoteAdd extends NoteEvent {
  final Note note;

  const NoteAdd(this.note);

  @override
  List<Object> get props => [note];
}

class NoteUpdate extends NoteEvent {
  final Note note;

  const NoteUpdate(this.note);

  @override
  List<Object> get props => [note];
}

class NoteDelete extends NoteEvent {
  final String id;

  const NoteDelete(this.id);

  @override
  List<Object> get props => [id];
}
