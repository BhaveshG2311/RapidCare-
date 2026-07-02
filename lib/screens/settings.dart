import 'package:flutter/material.dart';

// Callback style theme mode switch
// We will register a listener to update settings state
class SettingsScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const SettingsScreen({
    super.key,
    required this.themeNotifier,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _locationSync = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkModeActive = widget.themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Preference header
            Text(
              'Application Settings',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Dark Mode toggle
            Card(
              child: SwitchListTile(
                title: const Text('Dark Theme Mode'),
                subtitle: const Text('Toggle custom appearance styling'),
                secondary: const Icon(Icons.dark_mode_outlined),
                value: isDarkModeActive,
                activeColor: theme.colorScheme.primary,
                onChanged: (val) {
                  setState(() {
                    widget.themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            
            // Push Notifications
            Card(
              child: SwitchListTile(
                title: const Text('Push Alerts'),
                subtitle: const Text('Receive warnings and driver status alerts'),
                secondary: const Icon(Icons.notifications_active_outlined),
                value: _pushNotifications,
                activeColor: theme.colorScheme.primary,
                onChanged: (val) {
                  setState(() {
                    _pushNotifications = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            
            // Location Sync
            Card(
              child: SwitchListTile(
                title: const Text('Continuous GPS Sync'),
                subtitle: const Text('Coordinate real-time dispatch routes'),
                secondary: const Icon(Icons.gps_fixed_outlined),
                value: _locationSync,
                activeColor: theme.colorScheme.primary,
                onChanged: (val) {
                  setState(() {
                    _locationSync = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            
            // Legal section
            Text(
              'General & Support',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            _buildNavigationOption('Help & Emergency Support', Icons.help_outline, theme),
            const SizedBox(height: 8),
            _buildNavigationOption('Privacy & Medical HIPAA Compliance', Icons.security_outlined, theme),
            const SizedBox(height: 8),
            _buildNavigationOption('About RapidCare v1.0.0', Icons.info_outline, theme),
            const SizedBox(height: 32),
            
            // Logout
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 8),
                  Text('Log Out Profile'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationOption(String label, IconData icon, ThemeData theme) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.outline),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label - Mock Module Triggered'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
