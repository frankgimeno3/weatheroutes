import 'package:flutter/material.dart';
import 'api_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController locationController = TextEditingController();
  String weatherData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ... Tus widgets relacionados con WeatherPage ...
          ],
        ),
      ),
    );
  }

// ... Otros métodos y lógica relacionados con WeatherPage ...
}