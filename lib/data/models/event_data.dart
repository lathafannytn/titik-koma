import 'dart:convert';
import 'dart:typed_data';

class EventData {
  final String id;
  final String uuid;
  final String name;
  final String desc;
  final dynamic start_date;
  final dynamic end_date;
  final dynamic location;
  final dynamic max_person;
  final dynamic long;
  final dynamic lat;
  final dynamic imgUrl;
  final dynamic qrCode;

  EventData(
      {required this.id,
      required this.uuid,
      required this.name,
      required this.desc,
      required this.start_date,
      required this.end_date,
      required this.imgUrl,
      required this.location,
      required this.long,
      required this.lat,
      required this.max_person,
      this.qrCode});

  factory EventData.fromJson(Map<String, dynamic> json) {
    String imageUrl = '';
    Uint8List? bytes;
    if (json.containsKey('media') && json['media'].isNotEmpty) {
      print(json['media'][0]['original_url']);
      imageUrl = json['media'][0]['original_url'];
    }
    if (json.containsKey('qr_code_base64')) {
      bytes = base64Decode(json['qr_code_base64']);
    }

    return EventData(
      id: json['id'].toString(),
      uuid: json['uuid'],
      name: json['name'],
      desc: json['desc'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      location: json['location'],
      long: json['long'],
      lat: json['lat'],
      max_person: json['max_person'],
      imgUrl: imageUrl,
      qrCode: bytes ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'description': desc,
      'start_date': start_date,
      'end_date': end_date,
      'location': location,
      'long': long,
      'lat': lat,
    };
  }
}

class EventDataResponse {
  final String status;
  final String message;
  final List<EventData> data;

  EventDataResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EventDataResponse.fromJson(Map<String, dynamic> json) {
    var eventListJson = json['data'] as List;
    List<EventData> eventList = eventListJson.map((eventJson) {
      return EventData.fromJson(eventJson);
    }).toList();

    return EventDataResponse(
      data: eventList,
      message: json['msg'],
      status: json['status'],
    );
  }
}

class EventDetailDataResponse {
  final String status;
  final String message;
  final EventData data;

  EventDetailDataResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EventDetailDataResponse.fromJson(Map<String, dynamic> json) {
    return EventDetailDataResponse(
      data: EventData.fromJson(json["data"]),
      message: json['msg'],
      status: json['status'],
    );
  }
}

class EventStoreResponse {
  final String status;
  final String message;

  EventStoreResponse({required this.status, required this.message});

  factory EventStoreResponse.fromJson(Map<String, dynamic> json) {
    return EventStoreResponse(message: json['msg'], status: json['status']);
  }
}
