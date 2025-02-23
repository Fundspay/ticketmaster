import 'package:json_annotation/json_annotation.dart';
import 'package:ticketmaster/src/features/event/domain/models/event_model.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'event_id')
  final String eventId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final EventModel event;

  TicketModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.createdAt,
    required this.updatedAt,
    required this.event,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
