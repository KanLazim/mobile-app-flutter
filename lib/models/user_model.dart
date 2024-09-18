final class UserModel {
  final String? email;
  final String? name;
  final String? city;
  final String? district;
  final String? bloodType;
  UserModel({
    this.email,
    this.name,
    this.city,
    this.district,
    this.bloodType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'city': city,
      'district': district,
      'bloodType': bloodType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      bloodType: map['bloodType'] != null ? map['bloodType'] as String : null,
    );
  }
}
