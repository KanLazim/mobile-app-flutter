import 'package:cloud_firestore/cloud_firestore.dart';

final class RequestModel {
  final String? name;
  final String? bloodType;
  final double? unitAmount;
  final String? ugency;
  final String? city;
  final String? district;
  final String? hospital;
  final String? title;
  final String? description;
  final Timestamp? timestamp;
  final bool? isFind;
  final String? requestOwner;
  final String? docId;
  RequestModel({
    this.name,
    this.bloodType,
    this.unitAmount,
    this.ugency,
    this.city,
    this.district,
    this.hospital,
    this.title,
    this.description,
    this.timestamp,
    this.isFind,
    this.requestOwner,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bloodType': bloodType,
      'unitAmount': unitAmount,
      'ugency': ugency,
      'city': city,
      'district': district,
      'hospital': hospital,
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'isFind': isFind,
      'requestOwner': requestOwner,
      'docId': docId,
    };
  }

  factory RequestModel.fromMap({required Map<String, dynamic> map, String? docId}) {
    return RequestModel(
      name: map['name'] != null ? map['name'] as String : null,
      bloodType: map['bloodType'] != null ? map['bloodType'] as String : null,
      unitAmount: map['unitAmount'] != null ? map['unitAmount'] as double : null,
      ugency: map['ugency'] != null ? map['ugency'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      hospital: map['hospital'] != null ? map['hospital'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as Timestamp : null,
      isFind: map['isFind'] != null ? map['isFind'] as bool : null,
      requestOwner: map['requestOwner'] != null ? map['requestOwner'] as String : null,
      docId: docId,
    );
  }
}
