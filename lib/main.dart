import 'dart:async';
import 'dart:math';

import 'package:a_special_clock/widgets/sun_earth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbit',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
          bodySmall: TextStyle(),
        ).apply(
          bodyColor: Colors.white54,
          displayColor: Colors.blue,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime endDt = DateTime.parse('2024-01-26 17:30:00Z');

  Future<DateTime?> _pickDateTime(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endDt,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: pickedDate.hour, minute: pickedDate.minute),
      );
      if (pickedTime != null) {
        Duration d =
            Duration(hours: pickedTime.hour, minutes: pickedTime.minute);
        return pickedDate.add(d);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDt = DateTime.now();
    Duration duration = endDt.difference(currentDt);
    print(duration);
    print(currentDt);
    print(endDt);
    double angleEarth =
        (currentDt.difference(DateTime(currentDt.year, 1, 1)).inDays) /
            365.0 *
            2 *
            pi;
    double angleShadow =
        (endDt.difference(DateTime(endDt.year, 1, 1)).inDays) / 365.0 * 2 * pi;
    double angleDif = (angleShadow - angleEarth);
    Duration oneSecond = const Duration(seconds: 1);
    Timer.periodic(oneSecond, (Timer t) => setState(() {}));

    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xF2000000),
              Color(0xFF0F1624),
            ],
            //stops: [0.9]
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (duration.inDays).toString(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Dias"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  duration.inHours.remainder(24).toString(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Horas"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  duration.inMinutes.remainder(60).toString(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Minutos"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  duration.inSeconds.remainder(60).toString(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Segundos"),
              ),
              Container(
                  width: 400,
                  height: 400,
                  child: SunEarth(
                    radius: 10,
                    parentRadius: 30,
                    color: const Color(0xFFA7C7E7),
                    shadowColor: const Color(0xFF0047AB),
                    angle: angleDif,
                    currentDt: currentDt,
                    endDt: endDt,
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          mini: true,
            backgroundColor: Colors.blueGrey.withOpacity(0.4),
            onPressed: () async {
              final selectedDateTime = await _pickDateTime(context);
              if (selectedDateTime != null) {
                endDt = selectedDateTime;
              }
            },
            child: const Icon(
              Icons.settings,
              color: Colors.white60,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
