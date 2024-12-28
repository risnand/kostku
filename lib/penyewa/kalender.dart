import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmppl/penyewa/homepenyewa.dart';
import 'package:table_calendar/table_calendar.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  _KalenderState createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  final DateTime _selectedDate = DateTime.now();
  List<Map<String, dynamic>> _kamarList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('kamar').get();

    List<Map<String, dynamic>> kamarList = [];
    for (var doc in snapshot.docs) {
      kamarList.add(doc.data() as Map<String, dynamic>);
    }

    setState(() {
      _kamarList = kamarList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_downward,
              color: Colors.black,
              size: 50.0,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const homepenyewa()),
            );
          },
        ),
        title: const Text(
          'Kalender',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime.utc(2000),
              lastDay: DateTime.utc(2100),
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
