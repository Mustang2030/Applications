import 'package:json_annotation/json_annotation.dart';
import 'package:scs/models/principal/principal.dart';
import 'package:scs/models/school/school.dart';
import 'package:scs/models/teacher/teacher.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  @JsonKey(name: "announcementId")
  int? announcementId;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "recipients")
  List<String>? recipients;

  @JsonKey(name: "content")
  String? content;

  @JsonKey(name: "sendEmail")
  bool? sendEmail;

  @JsonKey(name: "sendSMS")
  bool? sendSMS;

  @JsonKey(name: "viewedRecipients")
  List<String>? viewedRecipients;

  @JsonKey(name: "scheduleForLater")
  bool? scheduleForLater;

  @JsonKey(name: "dateCreated")
  DateTime? dateCreated;

  @JsonKey(name: "timeToPost")
  DateTime? timeToPost;

  //Foreign Keys
  @JsonKey(name: "teacherID")
  int? teacherID;

  @JsonKey(name: "principalID")
  int? principalID;

  @JsonKey(name: "schoolID")
  int? schoolID;

  //Navigation Properties
  @JsonKey(name: "principalAnnouncementNP")
  Principal? principalAnnouncementNP;

  @JsonKey(name: "teacherAnnouncementNP")
  Teacher? teacherAnnouncementNP;

  @JsonKey(name: "announcementSchoolNP")
  School? announcementSchoolNP;

  // Constructor
  Announcement({
    this.announcementId,
    this.title,
    this.recipients,
    this.content,
    this.sendEmail,
    this.sendSMS,
    this.viewedRecipients,
    this.scheduleForLater,
    this.dateCreated,
    this.timeToPost,
    this.principalID,
    this.schoolID,
    this.teacherID,
    this.principalAnnouncementNP,
    this.teacherAnnouncementNP,
    this.announcementSchoolNP,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  // Getters and Setters

  // int get announcementId => _announcementId;
  // set announcementId(int value) {
  //   _announcementId = value;
  // }

  // String get title => _title;
  // set title(String value) {
  //   _title = value;
  // }

  // List<String> get recipients => _recipients;
  // set recipients(List<String> value) {
  //   _recipients = value;
  // }

  // String get content => _content;
  // set content(String value) {
  //   _content = value;
  // }

  // bool get sendEmail => _sendEmail;
  // set sendEmail(bool value) {
  //   _sendEmail = value;
  // }

  // bool get sendSMS => _sendSMS;
  // set sendSMS(bool value) {
  //   _sendSMS = value;
  // }

  // List<String> get viewedRecipients => _viewedRecipients;
  // set viewedRecipients(List<String> value) {
  //   _viewedRecipients = value;
  // }

  // bool get scheduleForLater => _scheduleForLater;
  // set scheduleForLater(bool value) {
  //   _scheduleForLater = value;
  // }

  // DateTime get dateCreated => _dateCreated;
  // set dateCreated(DateTime value) {
  //   _dateCreated = value;
  // }

  // DateTime get timeToPost => _timeToPost;
  // set timeToPost(DateTime value) {
  //   _timeToPost = value;
  // }

  // Convert Announcement to a Map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'announcementId': announcementId,
  //     'title': title,
  //     'recipients': recipients,
  //     'content': content,
  //     'sendEmail': sendEmail,
  //     'sendSMS': sendSMS,
  //     'viewedRecipients': viewedRecipients,
  //     'scheduleForLater': scheduleForLater,
  //     'dateCreated': dateCreated.toIso8601String(),
  //     'timeToPost': timeToPost.toIso8601String(),
  //   };
  // }

  // // Announcement Object from a map
  // factory Announcement.fromMap(Map<String, dynamic> map) {
  //   return Announcement(
  //     announcementId: map['announcementId'],
  //     title: map['title'],
  //     recipients: List<String>.from(map['recipients']),
  //     content: map['content'],
  //     sendEmail: map['sendEmail'],
  //     sendSMS: map['sendSMS'],
  //     viewedRecipients: List<String>.from(map['viewedRecipients']),
  //     scheduleForLater: map['scheduleForLater'],
  //     dateCreated: DateTime.parse(map['dateCreated']),
  //     timeToPost: DateTime.parse(map['timeToPost']),
  //   );
  // }
}
