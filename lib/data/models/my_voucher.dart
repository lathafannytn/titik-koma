class MyVoucher {
  final String id;
  final String uuid;
  final String name;
  final String desc;
  final dynamic percentage;
  final dynamic end_date;

  MyVoucher({
    required this.id,
    required this.uuid,
    required this.name,
    required this.desc,
    required this.percentage,
    required this.end_date,
  });

  factory MyVoucher.fromJson(Map<String, dynamic> json) {
    return MyVoucher(
      id: json['voucher']['id'].toString(),
      uuid: json['voucher']['uuid'],
      name: json['voucher']['name'],
      desc: json['voucher']['desc'],
      percentage: json['voucher']['percentage'],
      end_date: json['voucher']['end_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'description': desc,
      'percentage': percentage,
      'end_date': end_date,
    };
  }
}

class MyVoucherResponse {
  final String status;
  final String message;
  final List<MyVoucher> data;

  MyVoucherResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory MyVoucherResponse.fromJson(Map<String, dynamic> json) {
    var myVoucherListJson = json['data'] as List;
    List<MyVoucher> myVoucherList = myVoucherListJson.map((voucherJson) {
      return MyVoucher.fromJson(voucherJson);
    }).toList();

    return MyVoucherResponse(
      data: myVoucherList,
      message: json['msg'],
      status: json['status'],
    );
  }
}
