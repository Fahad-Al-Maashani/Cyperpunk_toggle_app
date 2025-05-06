import 'package:flutter/material.dart';

void main() {
  runApp(const CyberpunkToggleApp());
}

class CyberpunkToggleApp extends StatelessWidget {
  const CyberpunkToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyberpunk Toggle App',
      theme: ThemeData(
        fontFamily: 'PressStart2P',
        brightness: Brightness.dark,
      ),
      home: const ToggleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToggleScreen extends StatefulWidget {
  const ToggleScreen({super.key});

  @override
  State<ToggleScreen> createState() => _ToggleScreenState();
}

class _ToggleScreenState extends State<ToggleScreen> {
  final List<Map<String, dynamic>> items = [];
  final TextEditingController _controller = TextEditingController();

  void _addItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        items.add({'name': _controller.text, 'isToggled': false});
        _controller.clear();
      });
    }
  }

  void _toggleItem(int index, bool value) {
    setState(() {
      items[index]['isToggled'] = value;
    });

    // Show a surprise popup when toggled ON
    if (value) {
      _showPopup(context, "⚡ System Upgrade Completed!");
    }
  }

  void _showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("🚀 Neon Achievement!", style: TextStyle(color: Colors.cyanAccent)),
          content: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(color: Colors.amberAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cyberpunk Dynamic Background
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460), Color(0xFFE94560)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                "🚀 Cyberpunk Task List",
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Input Bar (Separate Section)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter item',
                      labelStyle: const TextStyle(color: Colors.cyanAccent),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shadowColor: Colors.pinkAccent.withOpacity(0.5),
                    elevation: 10,
                  ),
                  onPressed: _addItem,
                  child: const Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

          // List Section (Separate)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      color: Colors.black.withOpacity(0.8),
                      child: ListTile(
                        title: Text(
                          items[index]['name'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Switch(
                          activeColor: Colors.pinkAccent,
                          value: items[index]['isToggled'],
                          onChanged: (value) => _toggleItem(index, value),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
