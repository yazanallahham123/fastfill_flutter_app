import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_body.g.dart';

@JsonSerializable()
class NotificationBody extends Equatable{
   final int? id;
   final String? typeId;
   final String? date;
   final String? time;
   final String? title;
   final String? content;
   final String? notes;
   final String? imageURL;
   final int? userId;
   final String? price;
   final String? liters;
   final String? material;
   final String? address;

   NotificationBody({this.id, this.typeId, this.date, this.time, this.title, this.content, this.notes,
      this.imageURL, this.userId, this.price, this.liters, this.material, this.address});

   factory NotificationBody.fromJson(Map<String, dynamic> json) =>
       _$NotificationBodyFromJson(json);

   Map<String, dynamic> toJson() => _$NotificationBodyToJson(this);

   @override
   List<Object?> get props =>
       [this.id, this.typeId, this.date, this.time, this.title, this.content, this.notes,
          this.imageURL, this.userId, this.price, this.liters, this.material, this.address];
}
