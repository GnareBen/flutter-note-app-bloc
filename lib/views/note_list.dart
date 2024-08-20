import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/bloc/note_bloc.dart';
import 'package:note_app/utils/app_route_constant.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des notes'),
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        buildWhen: (previous, current) => current is NoteAdded || current is NoteDeleted || current is NoteLoaded || current is NoteUpdated || current is NoteError,
        listenWhen: (previous, current) => current is NoteAdded || current is NoteDeleted || current is NoteLoaded || current is NoteUpdated || current is NoteError,
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (NoteLoading):
              return const Center(child: CircularProgressIndicator());
            case const (NoteAdded):
            case const (NoteDeleted):
            case const (NoteUpdated):
              context.read<NoteBloc>().add(NoteLoad());
              return const Center(child: CircularProgressIndicator());
            case const (NoteLoaded):
              final noteState = state as NoteLoaded;
              return ListView.builder(
                itemCount: noteState.notes.length,
                itemBuilder: (context, index) {
                  final note = noteState.notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    trailing: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            GoRouter.of(context).pushNamed(AppRouteConstants.noteEdit, extra: note);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<NoteBloc>().add(NoteDelete(note.id!));
                          },
                        )
                      ],
                    ),
                    onTap: () {},
                  );
                },
              );
            case NoteError:
              final errorState = state as NoteError;
              return Center(child: Text(errorState.message));
            default:
              return const Center(child: Text('Aucune note'));
          }
        },
        listener: (context, state) {
          if (state is NoteError) {
            final errorState = state as NoteError;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorState.message)));
          } else if (state is NoteAdded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note ajoutée avec succès')));
          } else if (state is NoteDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note supprimée avec succès')));
          } else if (state is NoteUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note mise à jour avec succès')));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppRouteConstants.noteForm);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}