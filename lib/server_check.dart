import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api/custom_http.dart';

class ServerCheckPage extends StatefulWidget {
  const ServerCheckPage({Key? key}) : super(key: key);

  @override
  State<ServerCheckPage> createState() => _ServerCheckPageState();
}

class _ServerCheckPageState extends State<ServerCheckPage> {
  String _status = 'Press the button to check server connection';
  bool _isLoading = false;
  final String _endpoint = '/api/health';

  Future<void> checkServerConnection() async {
    setState(() {
      _isLoading = true;
      _status = 'Checking $_endpoint...';
    });

    try {
      final response = await CustomHttp.get(
        _endpoint,
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if response is HTML (which means we hit the website, not an API)
        if (response.body.trim().toLowerCase().startsWith('<!doctype html') ||
            response.body.trim().toLowerCase().startsWith('<html')) {
          setState(() {
            _isLoading = false;
            _status = '❌ Endpoint returned HTML instead of API response.\n\nThis means the API endpoint does not exist or is not configured correctly.';
          });
        } else {
          // Try to parse as JSON
          try {
            final jsonData = jsonDecode(response.body);
            setState(() {
              _isLoading = false;
              _status = '✅ Connection successful!\n\nResponse: ${jsonEncode(jsonData)}';
            });
          } catch (e) {
            // Not JSON, just return the text
            setState(() {
              _isLoading = false;
              _status = '✅ Connection successful!\n\nResponse: ${response.body}';
            });
          }
        }
      } else {
        setState(() {
          _isLoading = false;
          _status = '❌ Server error: ${response.statusCode}\n\nResponse: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = '❌ Could not connect to server: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Server Connection Test')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(
                _status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: _status.contains('✅') ? Colors.green : 
                         _status.contains('❌') ? Colors.red : 
                         Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Check button
            ElevatedButton(
              onPressed: _isLoading ? null : checkServerConnection,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Check Server Connection'),
            ),
          ],
        ),
      ),
    );
  }
}
