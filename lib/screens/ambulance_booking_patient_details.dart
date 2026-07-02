import 'package:flutter/material.dart';
import 'ambulance_listing.dart';

class AmbulanceBookingPatientDetailsScreen extends StatefulWidget {
  const AmbulanceBookingPatientDetailsScreen({super.key});

  @override
  State<AmbulanceBookingPatientDetailsScreen> createState() => _AmbulanceBookingPatientDetailsScreenState();
}

class _AmbulanceBookingPatientDetailsScreenState extends State<AmbulanceBookingPatientDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _insuranceController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedEmergency = 'General / Other';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _insuranceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleProceed(String hospitalName, AmbulanceData ambulance) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(
        '/payment',
        arguments: {
          'hospitalName': hospitalName,
          'ambulance': ambulance,
          'patientName': _nameController.text,
          'patientAge': _ageController.text,
          'patientGender': _selectedGender,
          'emergencyType': _selectedEmergency,
          'insuranceProvider': _insuranceController.text,
          'specialInstructions': _notesController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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

    // Pre-fill name if registered user (Alex Johnson)
    // In our login workflow, we pass name. If not present, we keep empty.
    if (_nameController.text.isEmpty && args?['isGuest'] != true) {
      _nameController.text = 'Alex Johnson';
      _ageController.text = '28';
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info header card
                Card(
                  color: theme.colorScheme.surfaceContainerLow,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.assignment_ind_outlined, color: theme.colorScheme.primary, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Patient Information Form',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'This data is directly synchronized with the hospital emergency crew en route.',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Fields
                Text(
                  'Patient Name',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, color: theme.colorScheme.outline),
                    hintText: 'Enter patient full name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter patient name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    // Age
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Age',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.cake_outlined, color: theme.colorScheme.outline),
                              hintText: 'e.g. 28',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter age';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Gender Dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.wc, color: theme.colorScheme.outline),
                            ),
                            items: <String>['Male', 'Female', 'Other'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedGender = val ?? 'Male';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Emergency Category Dropdown
                Text(
                  'Emergency Category',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedEmergency,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.warning_amber_outlined, color: theme.colorScheme.outline),
                  ),
                  items: <String>[
                    'Cardiac / Chest Pain',
                    'Trauma / Fractures',
                    'Respiratory Distress',
                    'Stroke Symptoms',
                    'Obstetric / Pregnancy',
                    'General / Other'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedEmergency = val ?? 'General / Other';
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Insurance Provider
                Text(
                  'Insurance Provider (Optional)',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _insuranceController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.shield_outlined, color: theme.colorScheme.outline),
                    hintText: 'e.g. Star Health, HDFC Ergo',
                  ),
                ),
                const SizedBox(height: 16),
                
                // Special Instructions
                Text(
                  'Special Symptoms / Instructions (Optional)',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Patient has asthma, penicillin allergy, or is unconscious...',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Action Button
                ElevatedButton(
                  onPressed: () => _handleProceed(hospitalName, ambulance),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Proceed to Payment'),
                      SizedBox(width: 8),
                      Icon(Icons.payment, size: 18),
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
}
