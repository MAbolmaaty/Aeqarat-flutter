class RealEstateUpdateResponseModel {
  List<Images> images;
  String sId;
  String title;
  String description;
  String latitude;
  String longitude;
  String publishedAt;
  String createdAt;
  String updatedAt;
  int iV;
  int realEstateStatus;
  String address;
  String price;
  String insuranceAmount;
  List<Requests> requests;
  String ownerId;
  String id;

  RealEstateUpdateResponseModel(
      {this.images,
      this.sId,
      this.title,
      this.description,
      this.latitude,
      this.longitude,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.realEstateStatus,
      this.address,
      this.price,
      this.insuranceAmount,
      this.requests,
        this.ownerId,
      this.id});

  RealEstateUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    publishedAt = json['published_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    realEstateStatus = json['realEstateStatus'];
    address = json['address'];
    price = json['price'];
    insuranceAmount = json['insuranceAmount'];
    if (json['requests'] != null) {
      requests = new List<Requests>();
      json['requests'].forEach((v) {
        requests.add(new Requests.fromJson(v));
      });
    }
    ownerId = json['ownerId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['published_at'] = this.publishedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['realEstateStatus'] = this.realEstateStatus;
    data['address'] = this.address;
    data['price'] = this.price;
    data['insuranceAmount'] = this.insuranceAmount;
    if (this.requests != null) {
      data['requests'] = this.requests.map((v) => v.toJson()).toList();
    }
    data['ownerId'] = this.ownerId;
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
  Thumbnail medium;
  Thumbnail small;
  Thumbnail large;

  Formats({this.thumbnail, this.medium, this.small, this.large});

  Formats.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    medium =
        json['medium'] != null ? new Thumbnail.fromJson(json['medium']) : null;
    small =
        json['small'] != null ? new Thumbnail.fromJson(json['small']) : null;
    large =
        json['large'] != null ? new Thumbnail.fromJson(json['large']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium.toJson();
    }
    if (this.small != null) {
      data['small'] = this.small.toJson();
    }
    if (this.large != null) {
      data['large'] = this.large.toJson();
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

class Requests {
  String userId;
  String username;
  String email;
  String phoneNumber;
  String amount;
  String insuranceAmount;
  String startDate;
  String requestDate;
  int duration;
  int paymentMethod;
  String realEstateStatus;
  int requestStatus;

  Requests({
    this.userId,
    this.username,
    this.email,
    this.phoneNumber,
    this.amount,
    this.insuranceAmount,
    this.startDate,
    this.requestDate,
    this.duration,
    this.paymentMethod,
    this.realEstateStatus,
    this.requestStatus,
  });

  Requests.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    amount = json['amount'];
    insuranceAmount = json['insuranceAmount'];
    startDate = json['startDate'];
    requestDate = json['requestDate'];
    duration = json['duration'];
    paymentMethod = json['paymentMethod'];
    realEstateStatus = json['realEstateStatus'];
    requestStatus = json['requestStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['amount'] = this.amount;
    data['insuranceAmount'] = this.insuranceAmount;
    data['startDate'] = this.startDate;
    data['requestDate'] = this.requestDate;
    data['duration'] = this.duration;
    data['paymentMethod'] = this.paymentMethod;
    data['realEstateStatus'] = this.realEstateStatus;
    data['status'] = this.requestStatus;
    return data;
  }
}
