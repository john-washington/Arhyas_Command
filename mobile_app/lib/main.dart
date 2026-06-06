import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: GPSTrackerHome());
}

class GPSTrackerHome extends StatefulWidget {
  const GPSTrackerHome({super.key});
  @override
  State<GPSTrackerHome> createState() => _GPSTrackerHomeState();
}

class _GPSTrackerHomeState extends State<GPSTrackerHome> {
  String _statusMessage = "Ready";

  // Replace with your Flask backend server IP address
  // Note: '10.0.0.X' is an example. Do not use 'localhost' if testing on a physical phone.
  final String backendUrl = "http://arhyas.command.peetalk.net:5000/"; 

  Future<void> _sendGPSData() async {
    setState(() => _statusMessage = "Fetching GPS location...");

    try {
      // 1. Check and request user location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _statusMessage = "Location permissions denied.");
          return;
        }
      }

      // 2. Query hardware GPS sensor for coordinates
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() => _statusMessage = "Sending data to Arhyas Command Web Service...");

      // 3. Compile data structure and send HTTP POST request
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "device_id": "mobile_phone_01",
          "latitude": position.latitude,
          "longitude": position.longitude,
          "radius": "10000",
          "lang_code": "en",
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _statusMessage = "Success! Saved coordinates: ${position.latitude}, ${position.longitude}");
      } else {
        setState(() => _statusMessage = "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _statusMessage = "Connection failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Arhyas_Command GPS Web Service Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _sendGPSData,
              icon: const Icon(Icons.location_on),
              label: const Text("Track & Transmit Location"),
            ),
            const SizedBox(height: 30),
            Text(
              "Status:",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              _statusMessage,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
