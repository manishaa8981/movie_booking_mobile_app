import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_api_model.dart';
import 'package:movie_ticket_booking/features/seat/data/model/seat_api_model.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';

part 'hall_api_model.g.dart';

@JsonSerializable()
class HallApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? hallId;
  final String hall_name;
  final int price;
  final int capacity;
  final List<ShowApiModel> shows;
  final List<SeatApiModel> seats;

  const HallApiModel({
    this.hallId,
    required this.hall_name,
    required this.price,
    required this.capacity,
    required this.shows,
    required this.seats,
  });

  /// ✅ Convert API JSON to `HallApiModel`
  factory HallApiModel.fromJson(Map<String, dynamic> json) =>
      _$HallApiModelFromJson(json);

  /// ✅ Convert `HallApiModel` to JSON
  Map<String, dynamic> toJson() => _$HallApiModelToJson(this);

  /// ✅ Convert `HallApiModel` to Domain Entity (`HallEntity`)
  HallEntity toEntity() => HallEntity(
        hallId: hallId,
        hall_name: hall_name,
        price: price,
        capacity: capacity,
        shows: ShowApiModel.toEntityList(shows),
        seats: SeatApiModel.toEntityList(seats),
      );

  /// ✅ Convert `HallEntity` to `HallApiModel`
  static HallApiModel fromEntity(HallEntity entity) => HallApiModel(
        hallId: entity.hallId,
        hall_name: entity.hall_name,
        price: entity.price,
        capacity: entity.capacity,
        shows: ShowApiModel.fromEntityList(entity.shows),
        seats: SeatApiModel.fromEntityList(entity.seats),
      );

  /// ✅ Convert List of API Models to List of Entities
  static List<HallEntity> toEntityList(List<HallApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// ✅ Convert List of Entities to List of API Models
  static List<HallApiModel> fromEntityList(List<HallEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  List<Object?> get props => [hallId, hall_name, price, capacity, shows, seats];
}
