import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hackoverflow/screen/doctor/doctor_dashboard.dart';

class ClinicFormPage extends StatefulWidget {
  @override
  _ClinicFormPageState createState() => _ClinicFormPageState();
}

class _ClinicFormPageState extends State<ClinicFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _openingController = TextEditingController();
  final TextEditingController _closingController = TextEditingController();

  String _slotLength = "PT30M";
  String _speciality = "Cardiology"; // Default
  double? _latitude;
  double? _longitude;
  String? _street;
  String? _city;

  int doctorId = 1; // Replace with real doctor ID (from login ideally)

  @override
  void initState() {
    super.initState();
    _fetchLocationAndAddress();
  }

  Future<void> _fetchLocationAndAddress() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _latitude = position.latitude;
      _longitude = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(_latitude!, _longitude!);
      Placemark place = placemarks.first;
      setState(() {
        _street = place.street;
        _city = place.locality;
      });
    } catch (e) {
      print('Location Error: $e');
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate() ||
        _latitude == null ||
        _street == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please fill all fields and allow location.")));
      return;
    }

    final clinicData = {
      "clinicName": _clinicNameController.text,
      "email": _emailController.text,
      "speciality": _speciality,
      "opening": _openingController.text,
      "closing": _closingController.text,
      "slotLength": _slotLength,
      "doctorId": doctorId,
      "address": {
        "street": _street!,
        "city": _city!,
        "latitude": _latitude,
        "longitude": _longitude,
      }
    };

    // Simulate successful API call
    print("Sending clinic data: $clinicData");

    // TODO: Replace with real HTTP POST request using `http` package

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DoctorDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Clinic")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _clinicNameController,
                decoration: InputDecoration(labelText: "Clinic Name"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              DropdownButtonFormField<String>(
                value: _speciality,
                items: [
                  "Cardiology",
                  "Dermatology",
                  "Neurology",
                  "Pediatrics",
                  "Orthopedics",
                  "ENT",
                  "Gynecology",
                  "Psychiatry"
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _speciality = val!),
                decoration: InputDecoration(labelText: "Speciality"),
              ),
              TextFormField(
                controller: _openingController,
                decoration:
                    InputDecoration(labelText: "Opening Time (e.g. 08:00)"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _closingController,
                decoration:
                    InputDecoration(labelText: "Closing Time (e.g. 17:00)"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              DropdownButtonFormField<String>(
                value: _slotLength,
                items: ["PT15M", "PT30M", "PT1H"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _slotLength = val!),
                decoration: InputDecoration(labelText: "Slot Length"),
              ),
              SizedBox(height: 16),
              Text("Location: ${_street ?? 'Fetching...'}, ${_city ?? ''}"),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _submitForm, child: Text("Create Clinic")),
            ],
          ),
        ),
      ),
    );
  }
}
