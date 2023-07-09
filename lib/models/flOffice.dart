
class FLOffice {
  int officeId;
  String officeName;
  String officeAddress;
  String officeCity;
  // String officePhones;
  int networkId;
  //String officeImage;

  FLOffice({
    required this.officeId,
    required this.officeName,
    required this.officeAddress,
    required this.officeCity,
    // required this.officePhones,
    required this.networkId,
    //required this.officeImage
  });

  FLOffice.empty()
      : officeId = -1,
        officeName = '',
        officeAddress = '',
        officeCity = '',
        networkId = -1;

  factory FLOffice.fromJson(Map<String, dynamic> json) {
    return FLOffice(
      officeId: int.parse(json['id'].toString()),
      officeName: json['officeName'] as String,
      officeAddress: json['officeAddress'] as String,
      officeCity: json['city'] as String,
      //officePhones: json['LineOfBusiness'] as String,
      networkId: int.parse(json['networkId'].toString()),
      //officeImage: '',
    );
  }
}
