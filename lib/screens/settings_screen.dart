import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildSection(
                      title: 'Appearance',
                      children: [
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) {
                            return SwitchListTile(
                              title: const Text('Use System Theme'),
                              subtitle: const Text('Follow system theme settings'),
                              value: themeProvider.useSystemTheme,
                              onChanged: (value) {
                                themeProvider.setUseSystemTheme(value);
                              },
                            );
                          },
                        ),
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) {
                            return ListTile(
                              title: const Text('Theme'),
                              subtitle: Text(
                                themeProvider.themeMode == ThemeMode.light
                                    ? 'Light'
                                    : themeProvider.themeMode == ThemeMode.dark
                                        ? 'Dark'
                                        : 'System',
                              ),
                              enabled: !themeProvider.useSystemTheme,
                              onTap: !themeProvider.useSystemTheme
                                  ? () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Select Theme'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: const Text('Light'),
                                                onTap: () {
                                                  themeProvider.setThemeMode(ThemeMode.light);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: const Text('Dark'),
                                                onTap: () {
                                                  themeProvider.setThemeMode(ThemeMode.dark);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                title: const Text('System'),
                                                onTap: () {
                                                  themeProvider.setThemeMode(ThemeMode.system);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                            );
                          },
                        ),
                      ],
                    ),
                    _buildSection(
                      title: 'Notifications',
                      children: [
                        SwitchListTile(
                          title: const Text('Push Notifications'),
                          subtitle: const Text('Receive push notifications'),
                          value: true, // TODO: Implement notifications
                          onChanged: (value) {
                            // TODO: Implement notifications
                          },
                        ),
                        SwitchListTile(
                          title: const Text('Email Notifications'),
                          subtitle: const Text('Receive email notifications'),
                          value: true, // TODO: Implement notifications
                          onChanged: (value) {
                            // TODO: Implement notifications
                          },
                        ),
                      ],
                    ),
                    _buildSection(
                      title: 'Language',
                      children: [
                        ListTile(
                          title: const Text('Language'),
                          subtitle: const Text('English'),
                          onTap: () {
                            // TODO: Implement language selection
                          },
                        ),
                      ],
                    ),
                    _buildSection(
                      title: 'Account',
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Profile'),
                          onTap: () {
                            // TODO: Navigate to profile
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.security),
                          title: const Text('Privacy & Security'),
                          onTap: () {
                            // TODO: Navigate to privacy settings
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.help),
                          title: const Text('Help & Support'),
                          onTap: () {
                            // TODO: Show help dialog
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.info),
                          title: const Text('About'),
                          onTap: () {
                            showAboutDialog(
                              context: context,
                              applicationName: 'Nexus',
                              applicationVersion: '1.0.0',
                              applicationIcon: const FlutterLogo(size: 64),
                              children: [
                                const Text('A modern contact management application.'),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
} 