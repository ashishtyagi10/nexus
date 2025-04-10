class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? mobile;
  final String? company;
  final String? jobTitle;
  final DateTime? dateOfBirth;
  final DateTime? anniversary;
  final String? notes;
  
  // Address Information
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  
  // Social Media
  final String? linkedIn;
  final String? twitter;
  final String? facebook;
  final String? instagram;
  
  // Additional Information
  final String? website;
  final String? department;
  final String? assistantName;
  final String? assistantPhone;
  final String? relationship;
  final List<String>? tags;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.mobile,
    this.company,
    this.jobTitle,
    this.dateOfBirth,
    this.anniversary,
    this.notes,
    this.streetAddress,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.linkedIn,
    this.twitter,
    this.facebook,
    this.instagram,
    this.website,
    this.department,
    this.assistantName,
    this.assistantPhone,
    this.relationship,
    this.tags,
  });

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}';

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      mobile: json['mobile'] as String?,
      company: json['company'] as String?,
      jobTitle: json['jobTitle'] as String?,
      dateOfBirth: json['dateOfBirth'] != null 
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      anniversary: json['anniversary'] != null 
          ? DateTime.parse(json['anniversary'] as String)
          : null,
      notes: json['notes'] as String?,
      streetAddress: json['streetAddress'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      linkedIn: json['linkedIn'] as String?,
      twitter: json['twitter'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      website: json['website'] as String?,
      department: json['department'] as String?,
      assistantName: json['assistantName'] as String?,
      assistantPhone: json['assistantPhone'] as String?,
      relationship: json['relationship'] as String?,
      tags: json['tags'] != null 
          ? List<String>.from(json['tags'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'mobile': mobile,
      'company': company,
      'jobTitle': jobTitle,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'anniversary': anniversary?.toIso8601String(),
      'notes': notes,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'linkedIn': linkedIn,
      'twitter': twitter,
      'facebook': facebook,
      'instagram': instagram,
      'website': website,
      'department': department,
      'assistantName': assistantName,
      'assistantPhone': assistantPhone,
      'relationship': relationship,
      'tags': tags,
    };
  }

  Contact copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? mobile,
    String? company,
    String? jobTitle,
    DateTime? dateOfBirth,
    DateTime? anniversary,
    String? notes,
    String? streetAddress,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? linkedIn,
    String? twitter,
    String? facebook,
    String? instagram,
    String? website,
    String? department,
    String? assistantName,
    String? assistantPhone,
    String? relationship,
    List<String>? tags,
  }) {
    return Contact(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      company: company ?? this.company,
      jobTitle: jobTitle ?? this.jobTitle,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      anniversary: anniversary ?? this.anniversary,
      notes: notes ?? this.notes,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      linkedIn: linkedIn ?? this.linkedIn,
      twitter: twitter ?? this.twitter,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      website: website ?? this.website,
      department: department ?? this.department,
      assistantName: assistantName ?? this.assistantName,
      assistantPhone: assistantPhone ?? this.assistantPhone,
      relationship: relationship ?? this.relationship,
      tags: tags ?? this.tags,
    );
  }
} 