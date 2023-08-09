import 'package:cillyfox_accurate_distance/navigation_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController sourceLatController = TextEditingController();
  TextEditingController sourceLngController = TextEditingController();
  TextEditingController destLatController = TextEditingController();
  TextEditingController destLngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACCURATE DISTANCE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the fields below',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: sourceLatController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Source Latitude',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: sourceLngController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Source Longitude',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: destLatController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Destination Latitude',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: destLngController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Destination Longitude',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NavigationScreen(
                          double.parse(sourceLatController.text),
                          double.parse(sourceLngController.text),
                          double.parse(destLatController.text),
                          double.parse(destLngController.text),
                        ),
                      ),
                    );
                  },
                  child: const Text('Get Directions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
