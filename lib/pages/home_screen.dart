import 'package:flutter/material.dart';
import './preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  double _fontSize = 20.0;
  String? _errorMessage;

  void _navigateToPreview() async {
    if (_textController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter some text';
      });
      return;
    } else {
      setState(() {
        _errorMessage = null;
      });
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    );

    if (result == 'ok') {
      _showDialog('Cool!');
    } else if (result == 'cancel') {
      _showDialog('Let’s try something else');
    } else {
      _showDialog('Don\'t know what to say');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.network(
                'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '@ Enter some text',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),

            const SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Font size: ${_fontSize.toStringAsFixed(0)}'),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),

            Center(
              child: ElevatedButton(
                onPressed: _navigateToPreview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(150, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Preview'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
