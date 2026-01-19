import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math; // Ez kell a forgatáshoz

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

// Hozzáadtuk a mixint az animációhoz
class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  
  String _selectedLanguage = 'English';
  final Map<String, String> _languageMap = {
    'English': 'en',
    'Hungarian': 'hu',
    'German': 'de',
  };

  @override
  void initState() {
    super.initState();
    // 15 másodperc alatt tesz meg egy kört, végtelenítve
    _rotationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _handleFactoryReset() {
    print('Factory Reset performed');
    Navigator.of(context).pushReplacementNamed('/vehicle-selection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Stack(
        children: [
          // Háttér
          Positioned.fill(
            child: SvgPicture.asset(
              'lib/assets/background.svg',
              fit: BoxFit.cover,
            ),
          ),
          // Tartalom
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      
                      _buildLabel('Select Language:'),
                      _buildDropdown(
                        hint: 'Select Language',
                        value: _selectedLanguage,
                        items: _languageMap.keys.toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedLanguage = val);
                        },
                      ),

                      const SizedBox(height: 30),

                      _buildLabel('Appearance:'),
                      Card(
                        color: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.white, width: 1.5)),
                        child: Column(
                          children: [
                            SwitchListTile(
                              title: const Text('Use System Theme',
                                  style: TextStyle(color: Colors.white)),
                              value: true,
                              activeColor: Colors.pink,
                              onChanged: (val) {},
                            ),
                            const Divider(color: Colors.white24, height: 1),
                            SwitchListTile(
                              title: const Text('Dark Mode',
                                  style: TextStyle(color: Colors.white)),
                              value: false,
                              activeColor: Colors.pink,
                              onChanged: (val) {},
                            ),
                          ],
                        ),
                      ),

                      // --- ITT A FORGÓ FOGASKERÉK A PANEL ALATT ---
                      const SizedBox(height: 50),
                      Center(
                        child: AnimatedBuilder(
                          animation: _rotationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationController.value * 2.0 * math.pi,
                              child: child,
                            );
                          },
                          child: Icon(
                            Icons.settings,
                            size: 200,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Rögzített Factory Reset Gomb
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _showResetDialog,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'FACTORY RESET',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  // --- Segédfüggvények maradnak változatlanul ---
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
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This will reset all settings to factory defaults.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('CANCEL')),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _handleFactoryReset();
            },
            child: const Text('RESET', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}