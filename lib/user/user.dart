class User_Profile {
  String image;
  String name;
  String email;
  String phone;
  String aboutMeDescription;
  bool isGuide;
  bool booking;

  // Constructor
  User_Profile({
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.aboutMeDescription,
    required this.isGuide,
    required this.booking,
  });

  User_Profile copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? about,
    required bool booking,
  }) =>
      User_Profile(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        aboutMeDescription: about ?? this.aboutMeDescription,
        isGuide: isGuide,
        booking: booking,
      );

  static User_Profile fromJson(Map<String, dynamic> json) {
    return User_Profile(
      image: json['imagePath'] ?? '', // Provide a default value if it's null
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      aboutMeDescription: json['about'] ?? '',
      phone: json['phone'] ?? '',
      isGuide: json['isGuide'] ?? false, // Provide a default value if it's null
      booking: json['booking'] ?? false, // Provide a default value if it's null
    );
  }

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
        'about': aboutMeDescription,
        'phone': phone,
        'isGuide': isGuide,
        'booking': booking
      };
}
