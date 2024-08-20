import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/repository/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FirebaseNoteRepository _noteRepository;

  NoteBloc(this._noteRepository) : super(NoteLoading()) {
    on<NoteLoad>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await _noteRepository.notes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(const NoteError('Erreur lors du chargement des notes'));
      }
    });

    on<NoteAdd>((event, emit) async {
      emit(NoteLoading());
      try {
        final note = event.note;
        await _noteRepository.insert(note.toJson());
        emit(NoteAdded());
      } catch (e) {
        emit(const NoteError('Erreur lors de l\'ajout de la note'));
      }
    });

    on<NoteUpdate>((event, emit) async {
      emit(NoteLoading());
      try {
        final note = event.note;
        await _noteRepository.update(note);
        emit(NoteUpdated());
      } catch (e) {
        emit(const NoteError('Erreur lors de la mise à jour de la note'));
      }
    });

    on<NoteDelete>((event, emit) async {
      emit(NoteLoading());
      try {
        await _noteRepository.delete(event.id);
        emit(NoteDeleted());
      } catch (e) {
        emit(const NoteError('Erreur lors de la suppression de la note'));
      }
    });
  }
}
