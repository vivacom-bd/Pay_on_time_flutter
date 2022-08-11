class VersionControl{
  AppVersion? android;
  AppVersion? iOS;


  VersionControl({this.android,this.iOS});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};

    data["versionControlAndroid"] = android!.toJson();
    data["versionControlIOS"] = iOS!.toJson();

    return data;
  }


  VersionControl.fromJson(Map<String, dynamic> data) {

    android = data["versionControlAndroid"] != null? AppVersion.fromJson(Map<String, dynamic>.from(data["versionControlAndroid"])):null;
    iOS = data["versionControlIOS"] != null? AppVersion.fromJson(Map<String, dynamic>.from(data["versionControlIOS"])):null;

  }
}


class AppVersion{

  String? version;
  String? versionCode;

  AppVersion({this.version,this.versionCode});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};

    data["version"] = version;
    data["versionCode"] = versionCode;
    return data;
  }


  AppVersion.fromJson(Map<String, dynamic> data) {
    version = data["version"];
    versionCode = data["versionCode"];
  }
}