// lib/screens/settings.dart
import 'package:flutter/material.dart';
import 'package:anmaya/utils/deep_link_helper.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Enable Direct Links'),
            subtitle: const Text('Open anmaya.in links in this app'),
            onTap: () => DeepLinkHelper.showManualInstructionsDialog(context),
          ),
          const Divider(),
          // Add more settings options here
        ],
      ),
    );
  }
}