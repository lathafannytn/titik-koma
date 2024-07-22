class Voucher {
  final String id;
  final String uuid;
  final String name;
  final String desc;
  final dynamic percentage;
  final dynamic end_date;
  final dynamic code;

  Voucher({
    required this.id,
    required this.uuid,
    required this.name,
    required this.desc,
    required this.percentage,
    required this.end_date,
    required this.code,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'].toString(),
      uuid: json['uuid'],
      name: json['name'],
      desc: json['desc'],
      percentage: json['percentage'],
      end_date: json['end_date'],
      code: json['code_voucher'],

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

class VoucherResponse {
  final String status;
  final String message;
  final List<Voucher> data;

  VoucherResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory VoucherResponse.fromJson(Map<String, dynamic> json) {
    var VoucherListJson = json['data'] as List;
    List<Voucher> VoucherList = VoucherListJson.map((voucherJson) {
      return Voucher.fromJson(voucherJson);
    }).toList();

    return VoucherResponse(
      data: VoucherList,
      message: json['msg'],
      status: json['status'],
    );
  }
}
