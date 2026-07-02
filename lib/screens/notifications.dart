import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final bool isTab;

  const NotificationsScreen({super.key, this.isTab = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<NotificationItem> alerts = [
      const NotificationItem(
        title: 'Ambulance Arrived',
        description: 'Advanced Life Support unit #RC-8829 has arrived at your location.',
        time: '10 Mins Ago',
        icon: Icons.check_circle_outline,
        color: Colors.green,
      ),
      const NotificationItem(
        title: 'Ambulance Dispatched',
        description: 'ALS Unit Marcus Vance is en route. ETA is 6 mins.',
        time: '16 Mins Ago',
        icon: Icons.airport_shuttle,
        color: Colors.blue,
      ),
      const NotificationItem(
        title: 'Emergency SOS Triggered',
        description: 'SOS alert broadcasted successfully from your coordinates.',
        time: '18 Mins Ago',
        icon: Icons.warning_amber_rounded,
        color: Colors.red,
      ),
      const NotificationItem(
        title: 'High Heat Warning',
        description: 'Extreme heat indexes expected. Stay hydrated and avoid outdoor physical work.',
        time: '2 Hours Ago',
        icon: Icons.lightbulb_outline,
        color: Colors.amber,
      ),
      const NotificationItem(
        title: 'Medical Record Synced',
        description: 'Your blood group and allergy details were synchronized with Mercy General.',
        time: '1 Day Ago',
        icon: Icons.sync,
        color: Colors.purple,
      ),
    ];

    Widget body = ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: alert.color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    alert.icon,
                    color: alert.color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              alert.title,
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            alert.time,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.outline,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        alert.description,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (isTab) {
      return body;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Notifications & Alerts'),
      ),
      body: SafeArea(child: body),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  const NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });
}
