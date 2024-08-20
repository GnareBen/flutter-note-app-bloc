part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  final List<Note> notes;

  const NoteLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}

final class NoteError extends NoteState {
  final String message;

  const NoteError(this.message);

  @override
  List<Object> get props => [message];
}

final class NoteDeleted extends NoteState {}

final class NoteAdded extends NoteState {}

final class NoteUpdated extends NoteState {}
