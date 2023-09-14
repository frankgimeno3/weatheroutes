import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController locationController = TextEditingController();
  String weatherData = "";

  Future<void> fetchWeather(String location) async {
    final apiKey = "fe9a7ae0c91c4ad386d221043231409";
    final apiUrl = "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location&aqi=no";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final weatherJson = json.decode(response.body);
      final locationData = weatherJson['location'];
      final currentData = weatherJson['current'];

      final name = locationData['name'];
      final region = locationData['region'];
      final country = locationData['country'];
      final tempC = currentData['temp_c'];
      final isDay = currentData['is_day'];
      final condition = currentData['condition']['text'];
      final windKph = currentData['wind_kph'];
      final precipMm = currentData['precip_mm'];
      final humidity = currentData['humidity'];
      final cloud = currentData['cloud'];
      final feelslikeC = currentData['feelslike_c'];
      final uv = currentData['uv'];

      setState(() {
        weatherData = 'Ubicación: $name, $region, $country\n'
            'Temperatura: $tempC°C\n'
            'Es de día: ${isDay == 1 ? "Sí" : "No"}\n'
            'Condición: $condition\n'
            'Velocidad del viento: $windKph km/h\n'
            'Precipitación: $precipMm mm\n'
            'Humedad: $humidity%\n'
            'Nubosidad: $cloud%\n'
            'Sensación térmica: $feelslikeC°C\n'
            'Índice UV: $uv';
      });
    } else {
      setState(() {
        weatherData = 'Error al obtener el pronóstico del tiempo';
      });
    }
  }

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
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Ubicación'),
            ),
            ElevatedButton(
              onPressed: () {
                final location = locationController.text;
                fetchWeather(location);
              },
              child: const Text('Obtener Pronóstico'),
            ),
            const SizedBox(height: 20),
            Text(
              weatherData,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}