import 'dart:async';
import 'package:flutter/material.dart';

class AmbulanceTrackingScreen extends StatefulWidget {
  const AmbulanceTrackingScreen({super.key});

  @override
  State<AmbulanceTrackingScreen> createState() => _AmbulanceTrackingScreenState();
}

class _AmbulanceTrackingScreenState extends State<AmbulanceTrackingScreen> with SingleTickerProviderStateMixin {
  bool _shareVitals = true;
  double _vehicleProgress = 0.0;
  Timer? _mapTimer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Simulate vehicle movement
    _mapTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) {
        setState(() {
          _vehicleProgress = (_vehicleProgress + 0.005) % 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _mapTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calling Driver Rajesh Kumar...')),
    );
  }

  void _handleChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat Console Initialized...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Retrieve arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final hospitalName = args['hospitalName'] as String? ?? 'Manipal Hospital (Old Airport Road)';
    final ambulanceType = args['ambulanceType'] as String? ?? 'Advanced Life Support (ALS)';
    final patientName = args['patientName'] as String? ?? 'Alex Johnson';

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Live Tracking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Take back to home
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Map Canvas
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? theme.colorScheme.surfaceContainerLow : const Color(0xFFE5F1FA),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Draw Animated Route Map using a CustomPainter
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _TrackingMapPainter(
                            isDark: isDark,
                            primaryColor: theme.colorScheme.primary,
                            secondaryColor: theme.colorScheme.secondary,
                            progress: _vehicleProgress,
                          ),
                        ),
                      ),
                      
                      // ETA overlay
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'ETA',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '4 Mins',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Info Panel
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? theme.colorScheme.surfaceContainerLow : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Driver details
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=60',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rajesh Kumar',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'ALS Unit • License KA-03-MB-9920',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.call_outlined),
                        onPressed: _handleCall,
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline),
                        onPressed: _handleChat,
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  
                  // Status steps indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusStep('Dispatched', true, theme),
                      _buildStatusStep('En Route', true, theme, isActive: true),
                      _buildStatusStep('Arrived', false, theme),
                    ],
                  ),
                  const Divider(height: 24),
                  
                  // Shared vitals toggle
                  SwitchListTile(
                    value: _shareVitals,
                    activeColor: theme.colorScheme.primary,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Share Patient Vitals',
                      style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Encrypt and sync medical data en route.',
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _shareVitals = val;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(val
                              ? 'Patient Vitals Sharing Activated'
                              : 'Vitals Sync Deactivated'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Cancel action
                  OutlinedButton(
                    onPressed: () {
                      _showCancelDialog(theme);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                      side: BorderSide(color: theme.colorScheme.error),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Cancel Request'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(String label, bool completed, ThemeData theme, {bool isActive = false}) {
    Color stepColor = completed
        ? (isActive ? theme.colorScheme.primary : Colors.green)
        : theme.colorScheme.outlineVariant;

    return Row(
      children: [
        if (isActive)
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: stepColor.withOpacity(0.3 + 0.7 * _pulseController.value),
                ),
              );
            },
          )
        else
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: stepColor,
            ),
          ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: completed ? FontWeight.bold : FontWeight.normal,
            color: completed ? theme.colorScheme.onSurface : theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  void _showCancelDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Emergency Dispatch?'),
          content: const Text(
            'Are you sure you want to cancel the dispatch? Immediate help might be delayed.',
          ),
          actions: [
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
              child: const Text('Cancel Request'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

class _TrackingMapPainter extends CustomPainter {
  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;
  final double progress;

  _TrackingMapPainter({
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF2C3133) : const Color(0xFFDEE5EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0
      ..strokeCap = StrokeCap.round;

    final routePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    // Draw streets grid
    canvas.drawLine(Offset(size.width * 0.1, 0), Offset(size.width * 0.1, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.5, 0), Offset(size.width * 0.5, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.9, 0), Offset(size.width * 0.9, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), roadPaint);

    // Navigation path coordinates
    Offset src = Offset(size.width * 0.5, size.height * 0.7);
    Offset elbow = Offset(size.width * 0.5, size.height * 0.3);
    Offset dst = Offset(size.width * 0.1, size.height * 0.3);

    // Draw static route line
    canvas.drawLine(src, elbow, routePaint);
    canvas.drawLine(elbow, dst, routePaint);

    // Animate active vehicle along path segments
    Offset vehiclePos;
    if (progress < 0.5) {
      double segmentProgress = progress / 0.5;
      vehiclePos = Offset.lerp(src, elbow, segmentProgress)!;
    } else {
      double segmentProgress = (progress - 0.5) / 0.5;
      vehiclePos = Offset.lerp(elbow, dst, segmentProgress)!;
    }

    // Draw source and destination marks
    canvas.drawCircle(src, 8, Paint()..color = primaryColor);
    canvas.drawCircle(dst, 8, Paint()..color = secondaryColor);

    // Draw moving vehicle (Flashing red dot indicator)
    canvas.drawCircle(vehiclePos, 10, Paint()..color = secondaryColor);
    canvas.drawCircle(vehiclePos, 16, Paint()..color = secondaryColor.withOpacity(0.3));
  }

  @override
  bool shouldRepaint(covariant _TrackingMapPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
