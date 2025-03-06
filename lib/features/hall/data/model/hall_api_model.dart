import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/seat/data/model/seat_api_model.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_api_model.dart';

part 'hall_api_model.g.dart';

@JsonSerializable()
class HallApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? hallId;
  final String hall_name;
  final int price;
  final int capacity;

  @JsonKey(name: 'showtimes')
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

  /// Factory method for an empty `HallApiModel`
  factory HallApiModel.empty() => const HallApiModel(
        hallId: "N/A",
        hall_name: "Unknown Hall",
        price: 0,
        capacity: 0,
        shows: [],
        seats: [],
      );

  factory HallApiModel.fromJson(Map<String, dynamic> json) {
    return HallApiModel(
      hallId: json['_id'] as String?,
      hall_name: json['hall_name'] as String? ?? "Unknown Hall",
      price: json['price'] as int? ?? 0,
      capacity: json['capacity'] as int? ?? 0,

      /// Fix: Handle both String and Map for `showtimes`
      shows: (json['showtimes'] as List<dynamic>?)
              ?.map((e) => e is String
                  ? ShowApiModel.empty() // If it's a string, use an empty model
                  : ShowApiModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],

      /// Fix: Handle both String and Map for seats
      seats: (json['seats'] as List<dynamic>?)
              ?.map((e) => e is String
                  ? SeatApiModel.empty() // If it's a string, use an empty model
                  : SeatApiModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Convert `HallApiModel` to JSON
  Map<String, dynamic> toJson() => _$HallApiModelToJson(this);

  /// Convert `HallApiModel` to Domain Entity (`HallEntity`)
  HallEntity toEntity() => HallEntity(
        hallId: hallId,
        hall_name: hall_name,
        price: price,
        capacity: capacity,
        shows: shows.map((show) => show.toEntity()).toList(),
        seats: seats.map((seat) => seat.toEntity()).toList(),
      );

  /// Convert `HallEntity` to `HallApiModel`
  static HallApiModel fromEntity(HallEntity entity) => HallApiModel(
        hallId: entity.hallId,
        hall_name: entity.hall_name,
        price: entity.price,
        capacity: entity.capacity,
        shows:
            entity.shows.map((show) => ShowApiModel.fromEntity(show)).toList(),
        seats:
            entity.seats.map((seat) => SeatApiModel.fromEntity(seat)).toList(),
      );

  /// Convert List of API Models to List of Entities
  static List<HallEntity> toEntityList(List<HallApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// Convert List of Entities to List of API Models
  static List<HallApiModel> fromEntityList(List<HallEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  List<Object?> get props => [hallId, hall_name, price, capacity, shows, seats];
}
