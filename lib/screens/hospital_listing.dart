import 'package:flutter/material.dart';

class HospitalListingScreen extends StatefulWidget {
  final bool isTab;

  const HospitalListingScreen({super.key, this.isTab = false});

  @override
  State<HospitalListingScreen> createState() => _HospitalListingScreenState();
}

class _HospitalListingScreenState extends State<HospitalListingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<HospitalData> _allHospitals = [
    const HospitalData(
      name: 'Manipal Hospital (Old Airport Road)',
      distance: '1.5 km',
      eta: '8 mins',
      specialty: 'Trauma, Cardiac, Emergency',
      rating: 4.8,
      address: '98, HAL Old Airport Rd, Kodihalli, Bengaluru, Karnataka 560008',
      phone: '+91 80 4011 9000',
      facilities: ['ICU', 'NICU', '24/7 ER', 'Trauma Center'],
      image: 'https://images.unsplash.com/photo-1587351021759-3e566b6af7cc?auto=format&fit=crop&w=800&q=80',
    ),
    const HospitalData(
      name: 'Apollo Hospitals (Bannerghatta Road)',
      distance: '3.2 km',
      eta: '12 mins',
      specialty: 'General, Pediatrics, Burn Care',
      rating: 4.6,
      address: 'Opp. IIM Bangalore, Bannerghatta Rd, Bengaluru, Karnataka 560076',
      phone: '+91 80 2630 4050',
      facilities: ['Pediatric ER', 'ICU', 'Stroke Unit'],
      image: 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?auto=format&fit=crop&w=800&q=80',
    ),
    const HospitalData(
      name: 'Narayana Health (Indiranagar)',
      distance: '5.0 km',
      eta: '15 mins',
      specialty: 'Trauma, Neurosurgery',
      rating: 4.9,
      address: '100 Feet Rd, near Doopanahalli, Indiranagar, Bengaluru, Karnataka 560008',
      phone: '+91 80 7122 2333',
      facilities: ['Level 1 Trauma', 'ICU', 'Helipad'],
      image: 'https://images.unsplash.com/photo-1586773860418-d3b3de97e963?auto=format&fit=crop&w=800&q=80',
    ),
    const HospitalData(
      name: 'Fortis Hospital (Cunningham Road)',
      distance: '6.5 km',
      eta: '18 mins',
      specialty: 'General Care, Urgent Care',
      rating: 4.2,
      address: '14, Cunningham Rd, Vasanth Nagar, Bengaluru, Karnataka 560052',
      phone: '+91 80 4199 4444',
      facilities: ['Urgent Care', 'Pharmacy', 'Lab'],
      image: 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=800&q=80',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredHospitals = _allHospitals.where((hospital) {
      final query = _searchQuery.toLowerCase();
      return hospital.name.toLowerCase().contains(query) ||
          hospital.specialty.toLowerCase().contains(query);
    }).toList();

    Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: TextFormField(
            controller: _searchController,
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: theme.colorScheme.outline),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              hintText: 'Search hospital name or specialty...',
            ),
          ),
        ),
        
        // List Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Nearby Hospitals',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        
        // Hospitals List
        Expanded(
          child: filteredHospitals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_hospital_outlined, size: 64, color: theme.colorScheme.outline),
                      const SizedBox(height: 16),
                      Text(
                        'No hospitals found',
                        style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: filteredHospitals.length,
                  itemBuilder: (context, index) {
                    final hospital = filteredHospitals[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/hospital_details',
                            arguments: {'hospital': hospital},
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hospital Image Header
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Stack(
                                children: [
                                  HospitalImage(
                                    imageUrl: hospital.image,
                                    hospitalName: hospital.name,
                                    height: 140,
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star, color: Colors.amber, size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${hospital.rating}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    left: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primaryContainer,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'ETA: ${hospital.eta}',
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          color: theme.colorScheme.onPrimaryContainer,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Hospital Info
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          hospital.name,
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        hospital.distance,
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    hospital.specialty,
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: hospital.facilities.map((fac) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.surfaceContainerLow,
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          fac,
                                          style: theme.textTheme.labelMedium?.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );

    if (widget.isTab) {
      return body;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Select Hospital'),
      ),
      body: SafeArea(child: body),
    );
  }
}

class HospitalImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final String hospitalName;

  const HospitalImage({
    super.key,
    required this.imageUrl,
    this.height = 140,
    this.width = double.infinity,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final initials = hospitalName
        .split(' ')
        .take(2)
        .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
        .join('');

    return Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildPlaceholder(theme, isDark, initials, showProgress: true);
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder(theme, isDark, initials);
      },
    );
  }

  Widget _buildPlaceholder(ThemeData theme, bool isDark, String initials, {bool showProgress = false}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  theme.colorScheme.primaryContainer.withOpacity(0.4),
                  theme.colorScheme.secondaryContainer.withOpacity(0.2),
                ]
              : [
                  theme.colorScheme.primary.withOpacity(0.08),
                  theme.colorScheme.secondary.withOpacity(0.04),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.04,
            child: Icon(Icons.add_moderator, size: height * 0.45, color: theme.colorScheme.primary),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_hospital, size: 12, color: theme.colorScheme.primary),
                  const SizedBox(width: 4),
                  Text(
                    'RapidCare Medical',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (showProgress)
            Positioned(
              bottom: 8,
              right: 8,
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HospitalData {
  final String name;
  final String distance;
  final String eta;
  final String specialty;
  final double rating;
  final String address;
  final String phone;
  final List<String> facilities;
  final String image;

  const HospitalData({
    required this.name,
    required this.distance,
    required this.eta,
    required this.specialty,
    required this.rating,
    required this.address,
    required this.phone,
    required this.facilities,
    required this.image,
  });
}
