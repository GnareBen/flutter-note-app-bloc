import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/repository/note_repository.dart';
import 'package:note_app/utils/app_route.dart';
import 'package:note_app/utils/db_helper.dart';

import 'bloc/note_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DatabaseHelper().database;

  runApp(RepositoryProvider(
    create: (context) => FirebaseNoteRepository(),
    child: BlocProvider(
      create: (context) =>
          NoteBloc(context.read<FirebaseNoteRepository>())..add(NoteLoad()),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: MyAppRoute().router,
    );
  }
}
