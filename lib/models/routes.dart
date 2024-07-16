import 'package:cloud_firestore/cloud_firestore.dart';
class BusInfo {
  final String ladiesReservation;
  final String lastBus;
  final String firstBus;
  final int frequency;
  final String from;
  late final String to;
  final int busNumber;
  late final int fare;

  BusInfo({
    required this.ladiesReservation,
    required this.lastBus,
    required this.firstBus,
    required this.frequency,
    required this.from,
    required this.to,
    required this.busNumber,
    required this.fare,
  });
}

// Step 2: Parse the data
List<BusInfo> parseBusData(Map<String, dynamic> data) {
  return data.entries.map((entry) {
    final busData = entry.value;
    return BusInfo(
      ladiesReservation: busData['Ladies Reservation'] ?? false,
      lastBus: busData['Last Bus'],
      firstBus: busData['First Bus'],
      frequency: busData['Frequency'],
      from: busData['From'],
      to: busData['To'],
      busNumber: busData['Bus Number'],
      fare: busData['Fare'],
    );
  }).toList();
}


