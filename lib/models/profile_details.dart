class ProfileDetails {
  String? name;
  String? address;
  String? email;
  String? dateOfBirth;

  ProfileDetails({this.name, this.address, this.email, this.dateOfBirth});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['email'] = email;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }

  ProfileDetails copyWith(
      {String? name, String? address, String? email, String? dateOfBirth}) {
    return ProfileDetails(
        name: name ?? this.name,
        address: address ?? this.address,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth);
  }
}
