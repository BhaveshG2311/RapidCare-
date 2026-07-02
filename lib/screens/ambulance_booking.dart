import 'package:flutter/material.dart';
import 'ambulance_listing.dart';

class AmbulanceBookingScreen extends StatelessWidget {
  const AmbulanceBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Retrieve arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final hospitalName = args?['hospitalName'] as String? ?? 'Manipal Hospital (Old Airport Road)';
    final ambulance = args?['ambulance'] as AmbulanceData? ??
        const AmbulanceData(
          type: 'Advanced Life Support (ALS)',
          price: 7500.00,
          eta: '6 mins',
          description: '',
          icon: Icons.airport_shuttle,
          features: [],
        );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Confirm Route'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Map Canvas Viewport
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
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
                      // Draw Mock Route Path Map using a CustomPainter
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _MockMapPainter(
                            isDark: isDark,
                            primaryColor: theme.colorScheme.primary,
                            secondaryColor: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      
                      // Bottom sheet-like info panel inside map
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? theme.colorScheme.surfaceContainerLowest.withOpacity(0.95)
                                : Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.my_location, color: theme.colorScheme.primary, size: 20),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pickup Location',
                                          style: theme.textTheme.labelMedium?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                        Text(
                                          '100 Feet Rd, Indiranagar, Bengaluru',
                                          style: theme.textTheme.labelLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(height: 16),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.local_hospital, color: theme.colorScheme.secondary, size: 20),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Destination Hospital',
                                          style: theme.textTheme.labelMedium?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                        Text(
                                          hospitalName,
                                          style: theme.textTheme.labelLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
            
            // Transport Selection Summary & Action Footer
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
                  // Quick Summary Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ambulance.type,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'ETA: ${ambulance.eta} • Distance: 2.0 km',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹${ambulance.price.toStringAsFixed(0)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Action Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/ambulance_booking_patient_details',
                        arguments: {
                          'hospitalName': hospitalName,
                          'ambulance': ambulance,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Confirm Route & Proceed'),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MockMapPainter extends CustomPainter {
  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;

  _MockMapPainter({
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
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

    // Draw Map grid / mock streets
    canvas.drawLine(Offset(size.width * 0.1, 0), Offset(size.width * 0.1, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.5, 0), Offset(size.width * 0.5, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.9, 0), Offset(size.width * 0.9, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), roadPaint);

    // Draw main navigation route path
    final routePath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.7)
      ..lineTo(size.width * 0.5, size.height * 0.3)
      ..lineTo(size.width * 0.1, size.height * 0.3);
    canvas.drawPath(routePath, routePaint);

    // Draw source point (Current location - Blue dot)
    final srcPaint = Paint()..color = primaryColor;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.7), 10, srcPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.7), 16, srcPaint..color = primaryColor.withOpacity(0.3));

    // Draw destination point (Hospital - Red Cross icon/dot)
    final dstPaint = Paint()..color = secondaryColor;
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.3), 10, dstPaint);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.3), 16, dstPaint..color = secondaryColor.withOpacity(0.3));
  }

  @override
  bool shouldRepaint(covariant _MockMapPainter oldDelegate) => false;
}
