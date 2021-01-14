class RealEstatesResponseModel {
  String sId;
  String title;
  String description;
  String latitude;
  String longitude;
  String publishedAt;
  String createdAt;
  String updatedAt;
  int iV;
  String id;
  String status;

  RealEstatesResponseModel(
      {this.sId,
      this.title,
      this.description,
      this.latitude,
      this.longitude,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.id,
      this.status});

  RealEstatesResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    publishedAt = json['published_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['published_at'] = this.publishedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
