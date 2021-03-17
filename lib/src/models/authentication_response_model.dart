class AuthenticationResponseModel {
  String jwt;
  User user;

  AuthenticationResponseModel({this.jwt, this.user});

  AuthenticationResponseModel.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  bool confirmed;
  bool blocked;
  String sId;
  String username;
  String email;
  String phoneNumber;
  int userType;
  String provider;
  String createdAt;
  String updatedAt;
  int iV;
  Role role;
  ProfilePicture profilePicture;
  String id;

  User(
      {this.confirmed,
        this.blocked,
        this.sId,
        this.username,
        this.email,
        this.phoneNumber,
        this.userType,
        this.provider,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.role,
        this.profilePicture,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userType = json['userType'];
    provider = json['provider'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    profilePicture = json['profilePicture'] != null
        ? new ProfilePicture.fromJson(json['profilePicture'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['userType'] = this.userType;
    data['provider'] = this.provider;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    if (this.profilePicture != null) {
      data['profilePicture'] = this.profilePicture.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Role {
  String sId;
  String name;
  String description;
  String type;
  int iV;
  String id;

  Role({this.sId, this.name, this.description, this.type, this.iV, this.id});

  Role.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class ProfilePicture {
  String sId;
  String name;
  String hash;
  String ext;
  String mime;
  double size;
  int width;
  int height;
  String url;
  ProviderMetadata providerMetadata;
  Formats formats;
  String provider;
  List<String> related;
  String createdAt;
  String updatedAt;
  int iV;
  String id;

  ProfilePicture(
      {this.sId,
        this.name,
        this.hash,
        this.ext,
        this.mime,
        this.size,
        this.width,
        this.height,
        this.url,
        this.providerMetadata,
        this.formats,
        this.provider,
        this.related,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.id});

  ProfilePicture.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    providerMetadata = json['provider_metadata'] != null
        ? new ProviderMetadata.fromJson(json['provider_metadata'])
        : null;
    formats =
    json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    provider = json['provider'];
    related = json['related'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    if (this.providerMetadata != null) {
      data['provider_metadata'] = this.providerMetadata.toJson();
    }
    if (this.formats != null) {
      data['formats'] = this.formats.toJson();
    }
    data['provider'] = this.provider;
    data['related'] = this.related;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class ProviderMetadata {
  String publicId;
  String resourceType;

  ProviderMetadata({this.publicId, this.resourceType});

  ProviderMetadata.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    resourceType = json['resource_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = this.publicId;
    data['resource_type'] = this.resourceType;
    return data;
  }
}

class Formats {
  Thumbnail thumbnail;
  Thumbnail small;

  Formats({this.thumbnail, this.small});

  Formats.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    small =
    json['small'] != null ? new Thumbnail.fromJson(json['small']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.small != null) {
      data['small'] = this.small.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String name;
  String hash;
  String ext;
  String mime;
  int width;
  int height;
  double size;
  Null path;
  String url;
  ProviderMetadata providerMetadata;

  Thumbnail(
      {this.name,
        this.hash,
        this.ext,
        this.mime,
        this.width,
        this.height,
        this.size,
        this.path,
        this.url,
        this.providerMetadata});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    path = json['path'];
    url = json['url'];
    providerMetadata = json['provider_metadata'] != null
        ? new ProviderMetadata.fromJson(json['provider_metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    data['path'] = this.path;
    data['url'] = this.url;
    if (this.providerMetadata != null) {
      data['provider_metadata'] = this.providerMetadata.toJson();
    }
    return data;
  }
}
