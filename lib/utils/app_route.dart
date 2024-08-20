import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/views/note_edit.dart';
import 'package:note_app/views/note_form.dart';
import 'package:note_app/views/note_list.dart';

class MyAppRoute {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: NoteList());
        },
      ),
      GoRoute(
        name: 'note_form',
        path: '/note_form',
        pageBuilder: (context, state) {
          return const MaterialPage(child: NoteForm());
        },
      ),
      GoRoute(
        name: 'note_edit',
        path: '/note_edit',
        pageBuilder: (context, state) {
          final note = state.extra as Note;
          return MaterialPage(child: NoteEdit(note: note));
        },
      ),
      GoRoute(path: '/:path*', pageBuilder: (context, state) {
        return const MaterialPage(child: Scaffold(body: Center(child: Text('Page not found'))));
      }),
    ],
  );
}
