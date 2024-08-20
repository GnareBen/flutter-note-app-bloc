import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/note_bloc.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/widgets/textareafield.dart';
import 'package:note_app/widgets/textfield.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({super.key});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une note')),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteAdded) Navigator.pop(context);
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFormField(controller: _titleController, label: 'Titre'),
                  TextAreaField(controller: _contentController, label: 'Contenu'),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final note = Note(
                          title: _titleController.text,
                          content: _contentController.text,
                        );
                        context.read<NoteBloc>().add(NoteAdd(note));
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