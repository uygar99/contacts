class User {
  String? id;
  DateTime? createdAt;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? profileImageUrl;

  User({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    profileImageUrl: json["profileImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt!.toIso8601String(),
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "profileImageUrl": profileImageUrl,
  };
}
