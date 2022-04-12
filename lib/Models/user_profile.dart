import 'package:hidmona/Models/city.dart';
import 'package:hidmona/Models/server_country.dart';

class UserProfile {
  String? username;
  String? phone;
  String? fullName;
  String? email;
  String? version;
  int? id;
  int? cityId;
  // List<Null>? groups;
  ServerCountry? country;
  City? city;

  UserProfile(
      {this.username,
        this.phone,
        this.fullName,
        this.email,
        this.version,
        this.id,
        this.cityId,
        // this.groups,
        this.country,
        this.city});

  UserProfile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    fullName = json['full_name'];
    email = json['email'];
    version = json['version'];
    id = json['id'];
    cityId = json['city_id'];
    // if (json['groups'] != null) {
    //   groups = <Null>[];
    //   json['groups'].forEach((v) {
    //     groups!.add(new Null.fromJson(v));
    //   });
    // }
    country =
    json['country'] != null ? ServerCountry.fromJson(json['country']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['phone'] = phone;
    data['full_name'] = fullName;
    data['email'] = email;
    data['version'] = version;
    data['id'] = id;
    data['city_id'] = cityId;
    // if (this.groups != null) {
    //   data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    // }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}