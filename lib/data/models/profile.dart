class ProfileModel {
  final int id;
  final String phoneNumber;
  final DateTime born;
  final String address;
  final String referralCode;
  final String point;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int usersId;

  ProfileModel({
    required this.id,
    required this.phoneNumber,
    required this.born,
    required this.address,
    required this.referralCode,
    required this.point,
    required this.createdAt,
    required this.updatedAt,
    required this.usersId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      phoneNumber: json['phone_number'],
      born: DateTime.parse(json['born']),
      address: json['address'],
      referralCode: json['referral_code'],
      point: json['point'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      usersId: json['users_id'],
    );
  }
}
