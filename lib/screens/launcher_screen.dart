import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LauncherScreen extends StatefulWidget {
  static const routeName = '/launcher';

  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  final List<String> _locations = [
    'Brewhouse Café & Grill - Milwaukee',
    'Safe House - 779 N Front St, Milwaukee',
    'Lakefront Brewery - 1872 N Commerce St',
    'Old German Beer Hall - 1009 N Old World 3rd St',
    'Milwaukee Public Market - 400 N Water St',
  ];

  String? _selectedLocation;
  bool _isGreaseTrap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Pickup'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Locations'),
                      _buildDropdown(
                        hint: 'Select Location',
                        value: _selectedLocation,
                        items: _locations,
                        onChanged: (val) => setState(() => _selectedLocation = val),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(Icons.refresh , color: Colors.white),
                          const SizedBox(width: 10),
                          Expanded(child: _buildActionBtn('Less')),
                          const SizedBox(width: 8),
                          Expanded(child: _buildActionBtn('More')),
                          const SizedBox(width: 8),
                          Expanded(child: _buildActionBtn('Filter')),
                        ],
                      ),
                      const SizedBox(height: 15),

                      _buildLabel('Timestamp'),
                      _buildFakeTextField('mm/dd/yyyy --:-- --', Icons.calendar_today),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Volume'),
                                _buildTextField('Enter volume'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _isGreaseTrap,
                                  onChanged: (v) => setState(() => _isGreaseTrap = v!),
                                  side: const BorderSide(color: Colors.white),
                                  checkColor: Colors.black,
                                  activeColor: Colors.white,
                                ),
                                const Text('Grease trap', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      _buildLabel('Notes'),
                      _buildTextField('Enter description...', maxLines: 3),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBottomBtn('Start'),
                          _buildBottomBtn('GPS' ),
                          _buildBottomBtn('Info'),
                          _buildBottomBtn('Save'),
                          _buildBottomBtn('Cancel'),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Divider(color: Colors.redAccent, thickness: 2),

                      // Táblázat fejléce
                      const Row(
                        children: [
                          Expanded(flex: 3, child: _HeaderCell('ADDRESS')),
                          Expanded(flex: 2, child: _HeaderCell('LOCATION')),
                          Expanded(flex: 2, child: _HeaderCell('TIMESTAMP')),
                          Expanded(flex: 1, child: _HeaderCell('VOL')),
                        ],
                      ),
                      const Divider(color: Colors.grey),

                      _buildDataRow(
                        '789 E Brady Street, Milwaukee, WI 53202',
                        'Brewhouse Café',
                        '01/14/2026, 15:55',
                        '200',
                      ),
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDropdown({required String hint, required String? value, required List<String> items, required Function(String?) onChanged}) {
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
          style: const TextStyle(color: Colors.white, fontSize: 13),
          items: items.map((e) => DropdownMenuItem(
            value: e, 
            child: Text(e, style: const TextStyle(color: Colors.white))
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        isDense: true,
      ),
    );
  }

  Widget _buildFakeTextField(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.white70)),
          Icon(icon, size: 18, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5, 
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildBottomBtn(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5, 
          ),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
    );
  }
  Widget _buildDataRow(String addr, String loc, String time, String vol) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.5).withValues( ), 
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(addr, style: const TextStyle(fontSize: 10, color: Colors.white))),
          Expanded(flex: 2, child: Text(loc, style: const TextStyle(fontSize: 10, color: Colors.white))),
          Expanded(flex: 2, child: Text(time, style: const TextStyle(fontSize: 10, color: Colors.white))),
          Expanded(flex: 1, child: Text(vol, style: const TextStyle(fontSize: 10, color: Colors.white))),
          const Icon(Icons.edit, size: 16, color: Colors.white),
          const Icon(Icons.close, size: 16, color: Colors.white),
          const Icon(Icons.camera_alt, size: 16, color: Colors.white),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  const _HeaderCell(this.label);
  @override
  Widget build(BuildContext context) {
    return Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10));
  }
}