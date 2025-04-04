import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  String _selectedLanguage = 'English';
  String _selectedTheme = 'System';

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Russian',
    'Arabic',
    'Hindi',
    'Portuguese',
    'Italian',
    'Dutch',
    'Swedish',
    'Norwegian',
    'Danish',
    'Finnish',
    'Greek',
    'Turkish',
    'Vietnamese',
  ];

  final List<String> _themes = [
    'System',
    'Light',
    'Dark',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    SwitchListTile(
                      title: const Text('Dark Mode'),
                      subtitle: const Text('Use dark theme'),
                      value: _darkMode,
                      onChanged: (value) {
                        setState(() {
                          _darkMode = value;
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Theme'),
                      subtitle: Text(_selectedTheme),
                      trailing: DropdownButton<String>(
                        value: _selectedTheme,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedTheme = value;
                            });
                          }
                        },
                        items: _themes.map((theme) {
                          return DropdownMenuItem<String>(
                            value: theme,
                            child: Text(theme),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                _buildSection(
                  title: 'Notifications',
                  children: [
                    SwitchListTile(
                      title: const Text('Enable Notifications'),
                      subtitle: const Text('Receive notifications for updates'),
                      value: _notifications,
                      onChanged: (value) {
                        setState(() {
                          _notifications = value;
                        });
                      },
                    ),
                  ],
                ),
                _buildSection(
                  title: 'Language',
                  children: [
                    ListTile(
                      title: const Text('Language'),
                      subtitle: Text(_selectedLanguage),
                      trailing: DropdownButton<String>(
                        value: _selectedLanguage,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedLanguage = value;
                            });
                          }
                        },
                        items: _languages.map((language) {
                          return DropdownMenuItem<String>(
                            value: language,
                            child: Text(language),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                _buildSection(
                  title: 'Account',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      subtitle: const Text('Manage your profile information'),
                      onTap: () {
                        // TODO: Navigate to profile screen
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text('Privacy & Security'),
                      subtitle: const Text('Manage your privacy settings'),
                      onTap: () {
                        // TODO: Navigate to privacy screen
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Help & Support'),
                      subtitle: const Text('Get help with the app'),
                      onTap: () {
                        // TODO: Navigate to help screen
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      subtitle: const Text('App version and information'),
                      onTap: () {
                        // TODO: Show about dialog
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
            padding: const EdgeInsets.all(16.0),
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