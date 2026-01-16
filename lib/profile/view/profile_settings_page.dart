import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const _SettingsSection(title: 'Account'),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive push notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('Biometric Authentication'),
            subtitle: const Text('Use fingerprint or face ID'),
            value: _biometricEnabled,
            onChanged: (value) {
              setState(() {
                _biometricEnabled = value;
              });
            },
            secondary: const Icon(Icons.fingerprint),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_selectedLanguage),
            leading: const Icon(Icons.language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Select Language'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile<String>(
                        title: const Text('English'),
                        value: 'English',
                        groupValue: _selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            _selectedLanguage = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Spanish'),
                        value: 'Spanish',
                        groupValue: _selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            _selectedLanguage = value!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const Divider(),
          const _SettingsSection(title: 'Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          const _SettingsSection(title: 'About'),
          ListTile(
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
            leading: const Icon(Icons.info),
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Policy')),
              );
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terms of Service')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
