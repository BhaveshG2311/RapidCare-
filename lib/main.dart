import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/splash.dart';
import 'screens/onboarding.dart';
import 'screens/login.dart';
import 'screens/home_dashboard.dart';
import 'screens/emergency_sos.dart';
import 'screens/emergency_guest_booking.dart';
import 'screens/hospital_listing.dart';
import 'screens/hospital_details.dart';
import 'screens/ambulance_listing.dart';
import 'screens/ambulance_booking.dart';
import 'screens/ambulance_booking_patient_details.dart';
import 'screens/payment.dart';
import 'screens/booking_success.dart';
import 'screens/third_party_booking_success.dart';
import 'screens/ambulance_tracking.dart';
import 'screens/settings.dart';

// Package-level Theme Mode controller
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

void main() {
  runApp(const RapidCareApp());
}

class RapidCareApp extends StatelessWidget {
  const RapidCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentThemeMode, child) {
        return MaterialApp(
          title: 'RapidCare',
          debugShowCheckedModeBanner: false,
          theme: RapidCareTheme.lightTheme,
          darkTheme: RapidCareTheme.darkTheme,
          themeMode: currentThemeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/login': (context) => const LoginScreen(),
            '/emergency_guest_booking': (context) => const EmergencyGuestBookingScreen(),
            '/hospital_listing': (context) => const HospitalListingScreen(),
            '/hospital_details': (context) => const HospitalDetailsScreen(),
            '/ambulance_listing': (context) => const AmbulanceListingScreen(),
            '/ambulance_booking': (context) => const AmbulanceBookingScreen(),
            '/ambulance_booking_patient_details': (context) => const AmbulanceBookingPatientDetailsScreen(),
            '/payment': (context) => const PaymentScreen(),
            '/booking_success': (context) => const BookingSuccessScreen(),
            '/third_party_booking_success': (context) => const ThirdPartyBookingSuccessScreen(),
            '/ambulance_tracking': (context) => const AmbulanceTrackingScreen(),
          },
          // Handle dynamic routes with arguments (like Home, SOS)
          onGenerateRoute: (settings) {
            if (settings.name == '/home') {
              final args = settings.arguments as Map? ?? {};
              final isGuest = args['isGuest'] as bool? ?? false;
              final userName = args['userName'] as String? ?? 'Alex Johnson';
              final email = args['email'] as String? ?? 'alex.johnson@example.com';
              
              return MaterialPageRoute(
                builder: (context) => HomeDashboard(
                  isGuest: isGuest,
                  userName: userName,
                  email: email,
                ),
              );
            }
            if (settings.name == '/emergency_sos') {
              final args = settings.arguments as Map? ?? {};
              final isGuest = args['isGuest'] as bool? ?? false;
              
              return MaterialPageRoute(
                builder: (context) => EmergencySosScreen(
                  isGuest: isGuest,
                ),
              );
            }
            if (settings.name == '/settings') {
              return MaterialPageRoute(
                builder: (context) => SettingsScreen(
                  themeNotifier: themeNotifier,
                ),
              );
            }
            return null;
          },
        );
      },
    );
  }
}
