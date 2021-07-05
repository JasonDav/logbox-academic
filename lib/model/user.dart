import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String surname;
  IdentityType identityType;
  String? idNumber;
  String? passportNumber;
  Country? passportCountry;
  String username;
  String? password;

  User(this.id, this.name, this.surname, this.identityType, this.idNumber,
      this.passportNumber, this.passportCountry, this.username, this.password);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum IdentityType { IDDOC, PASSPORT, UNKNOWN }

@JsonSerializable()
class Country {
  int id;
  String name;

  Country(this.id, this.name);
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
