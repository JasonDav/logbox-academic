import 'package:json_annotation/json_annotation.dart';
part 'security.g.dart';

@JsonSerializable()
class JWTToken {

  /// An all args constructor is required for json serialization
  JWTToken(this.authScheme, this.token);

  String authScheme;
  String token;

  /// A necessary factory constructor for creating a new JWTToken instance
  /// from a map. Pass the map to the generated `_$JWTTokenFromJson()` constructor.
  /// The constructor is named after the source class, in this case, JWTToken.
  factory JWTToken.fromJson(Map<String, dynamic> json) => _$JWTTokenFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$JWTTokenToJson`.
  Map<String, dynamic> toJson() => _$JWTTokenToJson(this);
}

@JsonSerializable()
class Credentials {

  Credentials(this.username, this.password);

  String username;
  String password;

  Map<String, dynamic> toJson() => _$CredentialsToJson(this);  
}

