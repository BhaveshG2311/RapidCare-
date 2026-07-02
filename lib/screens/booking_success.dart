import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({super.key});

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  bool _initialized = false;
  bool _showSmsNotification = false;
  String _smsRecipient = '';
  String _smsBody = '';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _setupSmsSimulation();
    }
  }

  void _setupSmsSimulation() {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final isGuest = args['isGuest'] as bool? ?? false;
    final patientName = args['patientName'] as String? ?? 'Alex Johnson';
    final phone = args['phone'] as String? ?? '+91 98450 12345';

    if (isGuest) {
      _smsRecipient = phone;
      _smsBody = "RapidCare: BLS ambulance dispatched! ETA: 8 mins. Unit will contact you at $phone. Track live: https://rcare.in/t/RC8829";
    } else {
      _smsRecipient = '+91 98450 12345';
      _smsBody = "RapidCare: ALS ambulance dispatched to Indiranagar for $patientName. Driver Rajesh Kumar (KA-03-MB-9920). ETA: 6 mins. Track live: https://rcare.in/t/RC8829";
    }

    // Trigger animation after a delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _showSmsNotification = true;
        });
      }
    });

    // Hide after 6 seconds
    Future.delayed(const Duration(milliseconds: 7200), () {
      if (mounted) {
        setState(() {
          _showSmsNotification = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
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
      body: Stack(
        children: [
          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  
                  // Pulsing Success Indicator Icon
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Success Text
                  Text(
                    'Ambulance Dispatched!',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Emergency medical team is on their way to your location.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Details Summary Card
                  Card(
                    color: isDark ? theme.colorScheme.surfaceContainerLow : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildDetailRow('Booking ID', '#RC-8829-01', theme),
                          const Divider(height: 24),
                          _buildDetailRow('Estimated ETA', '6 Mins', theme, isAccent: true),
                          const Divider(height: 24),
                          _buildDetailRow('Assigned Crew', 'Paramedic Team 4', theme),
                          const Divider(height: 24),
                          _buildDetailRow('Patient Name', patientName, theme),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  
                  // Action Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        '/ambulance_tracking',
                        arguments: {
                          'hospitalName': hospitalName,
                          'ambulanceType': ambulanceType,
                          'patientName': patientName,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_searching),
                        SizedBox(width: 12),
                        Text('Track Ambulance Live'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Floating SMS System Notification Overlay
          AnimatedPositioned(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOutBack,
            top: _showSmsNotification ? 20 : -200,
            left: 16,
            right: 16,
            child: _buildSmsNotificationCard(theme, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSmsNotificationCard(ThemeData theme, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _showSmsNotification = false;
            });
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SMS Icon Bubble
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.sms_rounded,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RapidCare SMS Gateway',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'now',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'To: $_smsRecipient',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF38BDF8), // Bright Sky Blue
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _smsBody,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String val, ThemeData theme, {bool isAccent = false}) {
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
            color: isAccent ? theme.colorScheme.primary : theme.colorScheme.onSurface,
            fontSize: isAccent ? 16 : 14,
          ),
        ),
      ],
    );
  }
}
