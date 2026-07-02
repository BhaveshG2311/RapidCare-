import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final bool isTab;
  final bool isGuest;

  const UserProfileScreen({
    super.key,
    this.isTab = false,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget body = SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? theme.colorScheme.surfaceContainerLow : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  backgroundImage: const NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDFYohHX74zr2KMKFEaygdLphHfwL8BnVUFmlRHTuPOTB9Nu-d3rVROZiXXbVkOWXu-3nVIJojTTgwTdavhlxOuYEEAt9kE5Co90ppIxZi3uauQmPsfmv1l-6i7j_nJtdegQ-_-OvFc4LDg9e92yoCGKPPuFcQ9b5cBW0LCNtMTlJ2d1M-GXOCKpXJQv86zDQn12-9Xziz6W2JpZSm2uuy9D9BE0CZIZpSOJCOjzyNjOTc53wTCpUBZ99nzGeITUdurc5vgCL-Jo-M',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isGuest ? 'Guest Profile' : 'Alex Johnson',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isGuest ? 'Browse Mode' : 'alex.johnson@example.com',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isGuest)
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: theme.colorScheme.primary),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit Profile Console (Mock)')),
                      );
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          if (isGuest) ...[
            // Guest block warning
            Card(
              color: theme.colorScheme.primaryContainer.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: theme.colorScheme.primaryContainer.withOpacity(0.3)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unlock Medical History Tracking',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Log in to save persistent emergency medical records, allergy logs, blood group files, and synchronize them automatically with paramedics.',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                      child: const Text('Login / Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            // Registered Medical profile details
            Text(
              'Medical Profile Card',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              color: isDark ? theme.colorScheme.surfaceContainerLow : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildMedicalRow('Blood Group', 'O Positive (O+)', theme),
                    const Divider(height: 20),
                    _buildMedicalRow('Allergies', 'Penicillin, Tree Nuts', theme, isAlert: true),
                    const Divider(height: 20),
                    _buildMedicalRow('Chronic Conditions', 'Asthma', theme),
                    const Divider(height: 20),
                    _buildMedicalRow('Current Medications', 'Albuterol Inhaler (PRN)', theme),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              'Emergency Contacts',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            _buildContactItem('Sarah Johnson', 'Wife', '+91 98765 43210', theme),
            const SizedBox(height: 12),
            _buildContactItem('Dr. Robert Chen', 'Primary Care Doctor', '+91 98765 01234', theme),
          ],
        ],
      ),
    );

    if (isTab) {
      return body;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Medical Profile'),
      ),
      body: SafeArea(child: body),
    );
  }

  Widget _buildMedicalRow(String label, String val, ThemeData theme, {bool isAlert = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          val,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isAlert ? theme.colorScheme.error : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(String name, String role, String phone, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '$role • $phone',
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.phone_outlined, color: theme.colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
