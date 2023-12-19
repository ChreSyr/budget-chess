// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampToDateTimeConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampToDateTimeConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? datetime) {
    return datetime != null ? Timestamp.fromDate(datetime) : null;
  }
}
