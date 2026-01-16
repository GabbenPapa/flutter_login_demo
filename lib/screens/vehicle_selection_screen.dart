import 'package:flutter/material.dart';

class VehicleSelectionScreen extends StatelessWidget {
  static const routeName = '/vehicle-selection';

  const VehicleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicles = ['Tesla Model 3', 'BMW i4', 'Audi e-tron', 'Porsche Taycan'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Vehicle'),
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: const Icon(Icons.directions_car),
          title: Text(vehicles[i]),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
          },
        ),
      ),
    );
  }
}
