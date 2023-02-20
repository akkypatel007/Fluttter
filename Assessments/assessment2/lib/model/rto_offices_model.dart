class RTOofficeModel {
  String? code;
  String? name;
  String? address;
  String? url;
  String? phone;

  RTOofficeModel(
    this.code,
    this.name,
    this.address,
    this.url,
    this.phone,
  );

  RTOofficeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    address = json['address'];
    url = json['url'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['code'] = this.code;
    data['name'] = this.name;
    data['address'] = this.address;
    data['url'] = this.url;
    data['phone'] = this.phone;

    return data;
  }
}
