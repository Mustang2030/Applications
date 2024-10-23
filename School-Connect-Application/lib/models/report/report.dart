import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  @JsonKey(name: "reportId")
  int? reportId;

  @JsonKey(name: "workDone")
  String? workDone;

  @JsonKey(name: "date")
  DateTime? date;

  Report({
    this.reportId,
    this.workDone,
    this.date,
  });

  factory Report.fromMap(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  //Getters and setters
  // int get reportId => _reportId;
  // set reportId(int value) {
  //   _reportId = value;
  // }

  // String get workDone => _workDone;
  // set workDone(String value) {
  //   _workDone = value;
  // }

  // DateTime get date => _date;
  // set date(DateTime value) {
  //   _date = value;
  // }

  // Map<String, dynamic> toMap() {
  //   return {'reportId': reportId, 'workDone': workDone, 'date': date};
  // }

  // factory Report.fromMap(Map<String, dynamic> map) {
  //   return Report(
  //     reportId: map['reportId'],
  //     workDone: map['workDone'],
  //     date: DateTime.parse(map['date']),
  //   );
  // }
}
