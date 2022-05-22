class AppUser {
  String? username;
  String? phone;
  String? fullName;
  String? email;
  // Null? version;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? expiryTime;
  List<Permissions>? permissions;
  String? detail;
  String? kycApplicationId;
  String? kycUserToken;

  AppUser(
      {this.username,
        this.phone,
        this.fullName,
        this.email,
        // this.version,
        this.accessToken,
        this.refreshToken,
        this.tokenType,
        this.expiryTime,
        this.permissions,
        this.detail,
        this.kycApplicationId,
        this.kycUserToken});

  AppUser.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    fullName = json['full_name'];
    email = json['email'];
    // version = json['version'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expiryTime = json['expiry_time'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
    detail = json['detail'];
    kycApplicationId = json['kyc_application_id'];
    kycUserToken = json['kyc_user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['phone'] = phone;
    data['full_name'] = fullName;
    data['email'] = email;
    // data['version'] = version;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['expiry_time'] = expiryTime;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    data['detail'] = detail;
    data['kyc_application_id'] = kycApplicationId;
    data['kyc_user_token'] = kycUserToken;
    return data;
  }
}

class Permissions {
  int? id;
  String? moduleName;
  List<MenuPermission>? menuPermission;

  Permissions({this.id, this.moduleName, this.menuPermission});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleName = json['module_name'];
    if (json['menu_permission'] != null) {
      menuPermission = <MenuPermission>[];
      json['menu_permission'].forEach((v) {
        menuPermission!.add(MenuPermission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['module_name'] = moduleName;
    if (menuPermission != null) {
      data['menu_permission'] =
          menuPermission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuPermission {
  int? id;
  String? name;
  String? url;
  String? icon;
  // int? parentId;
  bool? canCreate;
  bool? canView;
  bool? canList;
  bool? canDelete;
  bool? canEdit;

  MenuPermission(
      {this.id,
        this.name,
        this.url,
        this.icon,
        // this.parentId,
        this.canCreate,
        this.canView,
        this.canList,
        this.canDelete,
        this.canEdit});

  MenuPermission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    icon = json['icon'];
    // parentId = json['parent_id'];
    canCreate = json['can_create'];
    canView = json['can_view'];
    canList = json['can_list'];
    canDelete = json['can_delete'];
    canEdit = json['can_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['icon'] = icon;
    // data['parent_id'] = parentId;
    data['can_create'] = canCreate;
    data['can_view'] = canView;
    data['can_list'] = canList;
    data['can_delete'] = canDelete;
    data['can_edit'] = canEdit;
    return data;
  }
}