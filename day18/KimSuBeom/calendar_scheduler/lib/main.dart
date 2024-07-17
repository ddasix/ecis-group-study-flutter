import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:calendar_scheduler/repository/auth_repository.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';
import 'package:calendar_scheduler/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final repository = ScheduleRepository();
    // final scheduleProvider = ScheduleProvider(repository: repository);

    final scheduleRepository = ScheduleRepository();
    final authRepository = AuthRepository();
    final scheduleProvider =
        ScheduleProvider(authRepository, repository: scheduleRepository);

    return ChangeNotifierProvider(
      create: (_) => scheduleProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'calendar scheduler',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthScreen(),
      ),
    );
  }
}
