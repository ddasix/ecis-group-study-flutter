import 'package:calendar_schedule/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_schedule/database/drift_database.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';
import 'package:calendar_schedule/repository/schedule_repository.dart';
import 'package:calendar_schedule/provider/schedule_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:calendar_schedule/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting();

  //db 선언
  //final database = LocalDatabase();

  //database를 전역 선언
  //GetIt.I.registerSingleton<LocalDatabase>(database);

  //final repository = ScheduleRepository();
  //final schduleProvider = ScheduleProvider(repository: repository);

  runApp(
    /*
    ChangeNotifierProvider(create: (_) => schduleProvider,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ) ,
    ),
    */
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    )
  );
}