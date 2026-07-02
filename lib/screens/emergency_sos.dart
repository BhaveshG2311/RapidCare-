import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/pulse_background.dart';

class EmergencySosScreen extends StatefulWidget {
  final bool isGuest;

  const EmergencySosScreen({
    super.key,
    this.isGuest = false,
  });

  @override
  State<EmergencySosScreen> createState() => _EmergencySosScreenState();
}

class _EmergencySosScreenState extends State<EmergencySosScreen> with SingleTickerProviderStateMixin {
  bool _isActive = false;
  int _timeLeft = 5;
  Timer? _timer;
  
  // Animation controller for progress ring
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  void _startSosCountdown() {
    setState(() {
      _isActive = true;
      _timeLeft = 5;
    });

    _progressController.forward(from: 0.0);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _timeLeft = 0;
        });
        _completeSosTrigger();
      }
    });
  }

  void _cancelSos() {
    _timer?.cancel();
    _progressController.stop();
    setState(() {
      _isActive = false;
      _timeLeft = 5;
    });
  }

  void _completeSosTrigger() {
    // Show quick success state before transition
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SOS Alert Dispatched Successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Transition based on user state
    Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        if (widget.isGuest) {
          Navigator.of(context).pushReplacementNamed('/emergency_guest_booking');
        } else {
          // Direct fast-path to tracking for registered users
          Navigator.of(context).pushReplacementNamed('/ambulance_tracking', arguments: {
            'isSOS': true,
            'hospitalName': 'Manipal Hospital (Old Airport Road)',
            'ambulanceType': 'Advanced Life Support (ALS)',
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: PulseBackground(
        animate: _isActive,
        pulseColor: theme.colorScheme.error,
        child: SafeArea(
          child: Column(
            children: [
              // Top Action Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (_isActive) {
                          _cancelSos();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    Text(
                      'RapidCare',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48), // Spacer to balance back button
                  ],
                ),
              ),
              
              // Main content area
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Status Text
                      AnimatedOpacity(
                        opacity: _isActive ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          children: [
                            Text(
                              'EMERGENCY',
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: theme.colorScheme.error,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to alert nearest emergency services.',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      
                      // SOS Main Button Container
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Pulse indicator rings (Visual rings managed by PulseBackground CustomPaint)
                          
                          // Circular Progress Ring Overlay
                          if (_isActive)
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: AnimatedBuilder(
                                animation: _progressController,
                                builder: (context, child) {
                                  return CircularProgressIndicator(
                                    value: 1.0 - _progressController.value,
                                    strokeWidth: 6,
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                  );
                                },
                              ),
                            ),
                          
                          // Inner Interactive Button
                          GestureDetector(
                            onTap: () {
                              if (!_isActive) {
                                _startSosCountdown();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              width: _isActive ? 160 : 172,
                              height: _isActive ? 160 : 172,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.error,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.error.withOpacity(0.4),
                                    blurRadius: _isActive ? 16 : 28,
                                    spreadRadius: _isActive ? 1 : 2,
                                    offset: const Offset(0, 4),
                                  ),
                                  if (_isActive)
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  _isActive ? '$_timeLeft' : 'SOS',
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    color: theme.colorScheme.onError,
                                    fontSize: _isActive ? 56 : 44,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      
                      // Location Tracker Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.my_location,
                              color: theme.colorScheme.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isActive ? 'Broadcasting Location...' : 'GPS: Locating Position...',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom action sheet (Cancel button)
              AnimatedSlide(
                offset: _isActive ? const Offset(0, 0) : const Offset(0, 1),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: OutlinedButton(
                    onPressed: _cancelSos,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                      side: BorderSide(color: theme.colorScheme.error, width: 2),
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, size: 20),
                        SizedBox(width: 8),
                        Text('Cancel SOS Alert'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
