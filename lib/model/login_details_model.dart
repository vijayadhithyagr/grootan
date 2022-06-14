class CreateLoginDetailModel {
  String? ipAddress;
  int? qrNumber;
  String? loginDateTime;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? qrImageUrl;

  CreateLoginDetailModel(
      {this.ipAddress,
        this.qrNumber,
        this.loginDateTime,
        this.city,
        this.state,
        this.country,
        this.qrImageUrl,
        this.pincode});

  CreateLoginDetailModel.fromJson(Map<String, dynamic> json) {
    ipAddress = json['ipAddress'];
    qrNumber = json['qrNumber'];
    loginDateTime = json['loginDateTime'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    qrImageUrl = json['qrImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ipAddress'] = this.ipAddress;
    data['qrNumber'] = this.qrNumber;
    data['loginDateTime'] = this.loginDateTime;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['qrImageUrl'] = this.qrImageUrl;
    return data;
  }
}


class GetLoginDetailsModel {
  String? pincode;
  String? country;
  int? qrNumber;
  String? city;
  String? ipAddress;
  String? loginDateTime;
  String? state;
  String? qrImageUrl;

  GetLoginDetailsModel(
      {this.pincode,
        this.country,
        this.qrNumber,
        this.city,
        this.ipAddress,
        this.loginDateTime,
        this.state,
        this.qrImageUrl});

  GetLoginDetailsModel.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
    country = json['country'];
    qrNumber = json['qrNumber'];
    city = json['city'];
    ipAddress = json['ipAddress'];
    loginDateTime = json['loginDateTime'];
    state = json['state'];
    qrImageUrl = json['qrImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    data['qrNumber'] = this.qrNumber;
    data['city'] = this.city;
    data['ipAddress'] = this.ipAddress;
    data['loginDateTime'] = this.loginDateTime;
    data['state'] = this.state;
    data['qrImageUrl'] = this.qrImageUrl;
    return data;
  }
}

