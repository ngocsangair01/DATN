class AddressRequest {
  AddressRequest({
    this.detailAddress,
    this.idProvince,
  });

  String? detailAddress;
  int? idProvince;

  factory AddressRequest.fromJson(Map<String, dynamic> json) {
    return AddressRequest(
      detailAddress: json["detailAddress"],
      idProvince: json["idProvince"],
    );
  }

  Map<String, dynamic> toJson() => {
        "detailAddress": detailAddress,
        "idProvince": idProvince,
      };
}
