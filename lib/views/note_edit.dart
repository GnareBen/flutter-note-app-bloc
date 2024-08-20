import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/note_bloc.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/widgets/textfield.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit({super.key, required this.note});

  final Note note;

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.note.title);
    final contentController = TextEditingController(text: widget.note.content);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une note')),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteUpdated) Navigator.pop(context);
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextFormField(controller: titleController, label: 'Titre'),
                  MyTextFormField(
                      controller: contentController, label: 'Contenu'),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final note = Note(
                          title: titleController.text,
                          content: contentController.text,
                          id: widget.note.id,
                        );
                        context.read<NoteBloc>().add(NoteUpdate(note));
                      }
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
