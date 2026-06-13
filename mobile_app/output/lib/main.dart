import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchTrackerScreen(),
    );
  }
}

class SearchTrackerScreen extends StatefulWidget {
  const SearchTrackerScreen({super.key});

  @override
  State<SearchTrackerScreen> createState() => _SearchTrackerScreenState();
}

class _SearchTrackerScreenState extends State<SearchTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTextController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  
  bool _isLoading = false;
  String _statusMessage = "";
  String _job_id = "";
  
  // Replace with your endpoint URL
  final String _serverUrl = 'http://arhyas.command.peertalk.net:5000';
  //final String _reportUrl = 'http://arhyas.command.peertalk.net:5000/report/';
  final String _statusUrl = 'http://arhyas.command.peertalk.net:5000/task-status/';

  // Step 1: Request Permission and Get Coordinates
  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _statusMessage = 'Location services are disabled.');
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _statusMessage = 'Location permissions are denied.');
        return null;
      }
    }
    
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
    );
  }

  // Step 2: Combine GPS + User Inputs and Send Data
  Future<void> _sendDataToServer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _statusMessage = "Fetching GPS location...";
    });

    Position? position = await _getCurrentLocation();
    if (position == null) {
      setState(() => _isLoading = false);
      return;
    }

    //setState(() => _statusMessage = "Sending packet to server...");

    try {
      // Build the unified payload package
      final Map<String, dynamic> combinedPayload = {
        'searchText': _searchTextController.text,
        'searchDistanceKm': double.parse(_distanceController.text),
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': DateTime.now().toIso8601String(),
        'deviceId': 'flutter_search_node_01'
      };
    
      setState(() => _statusMessage = "found location data: latitude: " + position.latitude.toString()  + " longitude: " + position.longitude.toString() );

      final response = await http.post(
        Uri.parse(_serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(combinedPayload),
      );

      if (response.statusCode == 200) {
        _job_id = jsonDecode(response.body)["job_id"];
        setState(() => _statusMessage = 'Success! Server received your search request and return job id: ' + _job_id + ' with coordinates: latitude: ' + position.latitude.toString()  +  'longitude: '  + position.longitude.toString() );
      } else {
        setState(() => _statusMessage = 'Server rejected data: Status ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _statusMessage = 'Network error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }



// Step 3: fetch job status with job id 
  Future<void> _sendQueryToServer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _statusMessage = "query status with job id: " + _job_id;
    });


    setState(() => _statusMessage = "Sending packet to server...");

    try {

      final response = await http.get( 
	Uri.parse(_statusUrl + "/" +  _job_id),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() => _statusMessage = response.body);
			//jsonDecode(response.body) as String);
      } else {
        setState(() => _statusMessage = 'Server rejected data: Status ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _statusMessage = 'Network error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  void dispose() {
    _searchTextController.dispose();
    _distanceController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arhyas Command Location Query Sender')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Text Input
              TextFormField(
                controller: _searchTextController,
                decoration: const InputDecoration(
                  labelText: 'Search Query (e.g. en, zh)',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Please enter a two character language code' : null,
              ),
              const SizedBox(height: 15),
              
              // Search Distance Input
              TextFormField(
                controller: _distanceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Search Radius Max (Kilometers)',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val!.isEmpty) return 'Please enter a radius distance';
                  if (double.tryParse(val) == null) return 'Please enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              
              // Submit button trigger
              ElevatedButton(
                onPressed: _isLoading ? null : _sendDataToServer,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Send Job with GPS Coordinates', style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(height: 15),
              
	     
               // job status button trigger
              ElevatedButton(
                onPressed: _isLoading ? null : _sendQueryToServer,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
                child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Get Task Status', style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(height: 15),

              // Operational Status Output Log
              Text(
                _statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
              )

            ],
          ),
        ),
      ),
    );
  }
}
