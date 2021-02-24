class RealEstateResponseModel {
  List<Images> images;
  String sId;
  String title;
  String price;
  String address;
  String description;
  String latitude;
  String longitude;
  String insuranceAmount;
  String publishedAt;
  String createdAt;
  String updatedAt;
  int iV;
  String status;
  String id;

  RealEstateResponseModel(
      {this.images,
        this.sId,
        this.title,
        this.price,
        this.address,
        this.description,
        this.latitude,
        this.longitude,
        this.insuranceAmount,
        this.publishedAt,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.status,
        this.id});

  RealEstateResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    address = json['address'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    insuranceAmount = json['insuranceAmount'];
    publishedAt = json['published_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['address'] = this.address;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['insuranceAmount'] = this.insuranceAmount;
    data['published_at'] = this.publishedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}

class Images {
  String sId;
  String name;
  String alternativeText;
  String caption;
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

  Images(
      {this.sId,
        this.name,
        this.alternativeText,
        this.caption,
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

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
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
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
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
  Thumbnail large;
  Thumbnail medium;

  Formats({this.thumbnail, this.small, this.large, this.medium});

  Formats.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    small =
    json['small'] != null ? new Thumbnail.fromJson(json['small']) : null;
    large =
    json['large'] != null ? new Thumbnail.fromJson(json['large']) : null;
    medium =
    json['medium'] != null ? new Thumbnail.fromJson(json['medium']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.small != null) {
      data['small'] = this.small.toJson();
    }
    if (this.large != null) {
      data['large'] = this.large.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium.toJson();
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
  var size;
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
