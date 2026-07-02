import 'package:flutter/material.dart';
import 'ambulance_listing.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'Insurance';
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _handleRequest(Map args) {
    // Determine target success route: if user typed a different patient name than user name, it's third party!
    // User Name: "Alex Johnson"
    final String patientName = args['patientName'] ?? 'Alex Johnson';
    final bool isThirdParty = patientName.toLowerCase() != 'alex johnson' && patientName.isNotEmpty;

    Navigator.of(context).pushReplacementNamed(
      isThirdParty ? '/third_party_booking_success' : '/booking_success',
      arguments: {
        'hospitalName': args['hospitalName'],
        'ambulanceType': (args['ambulance'] as AmbulanceData?)?.type ?? 'Advanced Life Support (ALS)',
        'patientName': patientName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Retrieve arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final hospitalName = args['hospitalName'] as String? ?? 'Manipal Hospital (Old Airport Road)';
    final ambulance = args['ambulance'] as AmbulanceData? ??
        const AmbulanceData(
          type: 'Advanced Life Support (ALS)',
          price: 7500.00,
          eta: '6 mins',
          description: '',
          icon: Icons.airport_shuttle,
          features: [],
        );
    final patientName = args['patientName'] as String? ?? 'Alex Johnson';

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Checkout & Payment'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Card
                    Card(
                      color: isDark ? theme.colorScheme.surfaceContainerLow : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Request Summary',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Divider(height: 24),
                            // Items list
                            _buildSummaryItem(Icons.medical_services_outlined, 'Ambulance Type', ambulance.type, theme),
                            const SizedBox(height: 12),
                            _buildSummaryItem(Icons.local_hospital_outlined, 'Destination Hospital', hospitalName, theme),
                            const SizedBox(height: 12),
                            _buildSummaryItem(Icons.person_outline, 'Patient', patientName, theme),
                            const Divider(height: 24),
                            // Cost
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Base Fare Charge',
                                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                                ),
                                 Text(
                                   '₹${ambulance.price.toStringAsFixed(0)}',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Payment Method selector
                    Text(
                      'Select Payment Method',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    _buildPaymentMethodOption('Insurance', 'Coverage applies under policy co-pay', Icons.shield_outlined, theme),
                    const SizedBox(height: 12),
                    _buildPaymentMethodOption('Credit / Debit Card', 'Visa, Mastercard, RuPay', Icons.credit_card_outlined, theme),
                    const SizedBox(height: 12),
                    _buildPaymentMethodOption('UPI (GPay / PhonePe / Paytm)', 'One-tap secure instant transfer', Icons.phone_android_outlined, theme),
                    const SizedBox(height: 12),
                    _buildPaymentMethodOption('Cash at Destination', 'Pay driver or billing counter directly', Icons.payments_outlined, theme),
                    const SizedBox(height: 24),
                    
                    // Promo Input
                    Text(
                      'Have a Promo Code?',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _promoController,
                            decoration: const InputDecoration(
                              hintText: 'Enter code (e.g. RAPID10)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Promo Code Applied: 10% Discount')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Dispatch request footer
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payable',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                       Text(
                         _selectedMethod == 'Insurance' ? 'Co-pay: ₹0' : '₹${ambulance.price.toStringAsFixed(0)}',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _handleRequest(args),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(width: 12),
                        Text('Confirm & Dispatch Ambulance'),
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

  Widget _buildSummaryItem(IconData icon, String title, String subtitle, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.outline, size: 18),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            Text(subtitle, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(String id, String subtitle, IconData icon, ThemeData theme) {
    final isSelected = _selectedMethod == id;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMethod = id;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.06)
              : theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant.withOpacity(0.5),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    id,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: id,
              groupValue: _selectedMethod,
              activeColor: theme.colorScheme.primary,
              onChanged: (val) {
                setState(() {
                  _selectedMethod = val ?? '';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
