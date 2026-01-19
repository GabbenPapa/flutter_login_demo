import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VehicleSelectionScreen extends StatefulWidget {
  static const routeName = '/vehicle-selection';

  const VehicleSelectionScreen({super.key});

  @override
  State<VehicleSelectionScreen> createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  final List<String> _vehicles = [
    '1601 - International 1000 Gal Vac -',
    '1612 - International Vac 2500 GAL B&W',
    '1801 - Red Freightliner 2000 Gal Vac Truck -',
    '1804 - Gulf Coast Grease Truck -',
    '1805 - Blue Freightliner 2000 Gal Vac Truck -',
    '2002 - Little Hino Service Truck',
    '2008 - KW 2500 Gal Vac',
  ];

  final List<String> _plates = [
    '1601-17', '1612-14', '1801-15', '1804-22', '1805-19',
  ];

  final List<String> _drivers = [
    'Ashley Borman', 'Full Facts Test User', 'Gabor Bozzay', 'Mr. Sanders', 'Viktor Bozzay',
  ];

  String? _selectedVehicle;
  String? _selectedPlate;
  String? _selectedDriver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Vehicle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],

      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple,

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50), 
            const ListTile(
              title: Text(
                'Dashboard',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            _buildDrawerItem('Pickups', () {}),
            _buildDrawerItem('Unload', () {}),
            const Divider(color: Colors.grey, indent: 15, endIndent: 15),
            _buildDrawerItem('Print manifests', () {}),
            _buildDrawerItem('Master data', () {}),
            const Divider(color: Colors.grey, indent: 15, endIndent: 15),
            _buildDrawerItem('Sign out', () {}),
            _buildDrawerItem('Dark mode', () {}),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'lib/assets/background.svg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      _buildLabel('Vehicle:'),
                      _buildDropdown(
                        hint: 'Select Vehicle',
                        value: _selectedVehicle,
                        items: _vehicles,
                        onChanged: (val) =>
                            setState(() => _selectedVehicle = val),
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Plate number:'),
                      _buildDropdown(
                        hint: 'Select Plate',
                        value: _selectedPlate,
                        items: _plates,
                        onChanged: (val) => setState(() => _selectedPlate = val),
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Driver:'),
                      _buildDropdown(
                        hint: 'Select Driver',
                        value: _selectedDriver,
                        items: _drivers,
                        onChanged: (val) =>
                            setState(() => _selectedDriver = val),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'A driver can be selected and used when registering the pickup.',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/launcher');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: Theme.of(context).primaryColor,
          hint: Text(hint, style: const TextStyle(color: Colors.white70)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontSize: 15),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}