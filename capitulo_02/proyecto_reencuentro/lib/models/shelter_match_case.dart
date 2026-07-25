class ShelterMatchCase {
  final String petId;
  final String petName;
  final String shelterName;
  final String shelterAddress;
  final double shelterLat;
  final double shelterLng;
  final String contactPhone;

  ShelterMatchCase({
    required this.petId,
    required this.petName,
    required this.shelterName,
    required this.shelterAddress,
    required this.shelterLat,
    required this.shelterLng,
    required this.contactPhone,
  });

  factory ShelterMatchCase.fromMap(Map<dynamic, dynamic> map) {
    return ShelterMatchCase(
      petId: map['pet_id']?.toString() ?? '',
      petName: map['pet_name']?.toString() ?? 'Mascota',
      shelterName: map['shelter_name']?.toString() ?? 'Refugio',
      shelterAddress: map['shelter_address']?.toString() ?? '',
      shelterLat: (map['shelter_lat'] as num?)?.toDouble() ?? 0.0,
      shelterLng: (map['shelter_lng'] as num?)?.toDouble() ?? 0.0,
      contactPhone: map['contact_phone']?.toString() ?? '',
    );
  }
}
