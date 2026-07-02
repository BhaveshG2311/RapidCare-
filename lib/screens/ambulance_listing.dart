import 'package:flutter/material.dart';

class AmbulanceListingScreen extends StatelessWidget {
  final bool isTab;

  const AmbulanceListingScreen({super.key, this.isTab = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Retrieve arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final selectedHospital = args?['hospitalName'] as String? ?? 'Manipal Hospital (Old Airport Road)';

    final List<AmbulanceData> ambulances = [
      const AmbulanceData(
        type: 'Advanced Life Support (ALS)',
        price: 7500.00,
        eta: '6 mins',
        description: 'Equipped for life-critical cases. Features paramedics, cardiac monitors, and IV medication administration.',
        icon: Icons.airport_shuttle,
        features: ['Paramedic Crew', 'Cardiac Monitor', 'Intubation Kit', 'IV Meds'],
        isRecommended: true,
      ),
      const AmbulanceData(
        type: 'Basic Life Support (BLS)',
        price: 2500.00,
        eta: '8 mins',
        description: 'Ideal for stable patients requiring non-invasive monitoring. Includes oxygen support and stretcher transport.',
        icon: Icons.local_shipping,
        features: ['EMT Crew', 'Oxygen Support', 'Stretcher Board', 'Vitals Monitor'],
      ),
      const AmbulanceData(
        type: 'Critical Care Transport (CCT)',
        price: 15000.00,
        eta: '10 mins',
        description: 'Designed for ICU-to-ICU transfers. Equipped with mechanical ventilators and a specialized Critical Care Nurse.',
        icon: Icons.rv_hookup,
        features: ['ICU Nurse Crew', 'Ventilator System', 'Infusion Pumps', 'Advanced Vitals'],
      ),
      const AmbulanceData(
        type: 'Neonatal / Pediatric Transport',
        price: 10000.00,
        eta: '12 mins',
        description: 'Specialized mobile incubator environment with pediatric emergency care specialists.',
        icon: Icons.child_care,
        features: ['Pediatric Specialist', 'Neonatal Incubator', 'Adaptive Vitals', 'Baby/Child Equipment'],
      ),
    ];

    Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selection context header
        if (!isTab)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: theme.colorScheme.primaryContainer.withOpacity(0.08),
            child: Row(
              children: [
                Icon(Icons.local_hospital, color: theme.colorScheme.primary, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Destination: $selectedHospital',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        // List Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            'Select Ambulance Type',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        
        // Ambulance List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: ambulances.length,
            itemBuilder: (context, index) {
              final amb = ambulances[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: amb.isRecommended
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outlineVariant.withOpacity(0.5),
                    width: amb.isRecommended ? 2.0 : 1.0,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/ambulance_booking',
                      arguments: {
                        'hospitalName': selectedHospital,
                        'ambulance': amb,
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Type, Price, ETA Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (amb.isRecommended
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.outline)
                                    .withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                amb.icon,
                                color: amb.isRecommended
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          amb.type,
                                          style: theme.textTheme.labelLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      if (amb.isRecommended)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            'RECOMMENDED',
                                            style: theme.textTheme.labelMedium?.copyWith(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${amb.price.toStringAsFixed(0)}',
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(Icons.access_time, size: 14, color: theme.colorScheme.outline),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ETA: ${amb.eta}',
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          color: theme.colorScheme.onSurfaceVariant,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Description
                        Text(
                          amb.description,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Bullet Specs Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: amb.features.map((feature) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check, size: 10, color: theme.colorScheme.primary),
                                  const SizedBox(width: 4),
                                  Text(
                                    feature,
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      fontSize: 10,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

    if (isTab) {
      return body;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Select Transport'),
      ),
      body: SafeArea(child: body),
    );
  }
}

class AmbulanceData {
  final String type;
  final double price;
  final String eta;
  final String description;
  final IconData icon;
  final List<String> features;
  final bool isRecommended;

  const AmbulanceData({
    required this.type,
    required this.price,
    required this.eta,
    required this.description,
    required this.icon,
    required this.features,
    this.isRecommended = false,
  });
}
