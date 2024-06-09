import 'package:intl/intl.dart';

class PointHistory {
  final String id;
  final dynamic point;
  final dynamic desc;
  final dynamic type;
  final dynamic created;

  PointHistory({
    required this.id,
    required this.point,
    required this.desc,
    required this.type,
    required this.created,
  });

  factory PointHistory.fromJson(Map<String, dynamic> json) {
    String point_new = '';
    if (json['type'].toString() == 'PLUS') {
      point_new = '+';
    } else {
      point_new = '-';

    }

    return PointHistory(
      id: json['id'].toString(),
      point:point_new + json['point'].toString(),
      desc: json['desc'].toString(),
      type: json['type'].toString(),
      created: DateFormat('dd MMM yyyy HH:mm')
          .format(DateTime.parse(json['created_at'].toString())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'point': point,
      'desc': desc,
      'type': type,
      'created': created,
    };
  }
}

class PointHistoryResponse {
  final List<PointHistory> data;

  PointHistoryResponse({required this.data});

  factory PointHistoryResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<PointHistory> products =
        dataList.map((item) => PointHistory.fromJson(item)).toList();

    return PointHistoryResponse(data: products);
  }
}
