import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/seat/data/model/seat_hive_model.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_hive_model.dart';

part 'hall_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.hallTableId)
class HallHiveModel extends Equatable {
  @HiveField(0)
  final String hallId;

  @HiveField(1)
  final String hall_name;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final int capacity;

  @HiveField(4)
  final List<ShowHiveModel> shows;

  @HiveField(5)
  final List<SeatHiveModel> seats;

  const HallHiveModel({
    required this.hallId,
    required this.hall_name,
    required this.price,
    required this.capacity,
    required this.shows,
    required this.seats,
  });

  /// Convert API JSON to Hive Model
  factory HallHiveModel.fromJson(Map<String, dynamic> json) {
    return HallHiveModel(
      hallId: json['_id'] ?? '',
      hall_name: json['hall_name'] ?? '',
      price: json['price'] ?? 0,
      capacity: json['capacity'] ?? 0,
      shows: (json['shows'] as List)
          .map((e) => ShowHiveModel.fromJson(e))
          .toList(),
      seats: (json['seats'] as List)
          .map((e) => SeatHiveModel.fromJson(e))
          .toList(),
    );
  }

  /// Convert Hive Model to API JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': hallId,
      'hall_name': hall_name,
      'price': price,
      'capacity': capacity,
      'shows': shows.map((e) => e.toJson()).toList(),
      'seats': seats.map((e) => e.toJson()).toList(),
    };
  }

  /// Convert Hive Model to Domain Entity
  HallEntity toEntity() {
    return HallEntity(
      hallId: hallId,
      hall_name: hall_name,
      price: price,
      capacity: capacity,
      shows: shows.map((e) => e.toEntity()).toList(),
      seats: seats.map((e) => e.toEntity()).toList(),
    );
  }

  /// Convert Domain Entity to Hive Model
  static HallHiveModel fromEntity(HallEntity entity) {
    return HallHiveModel(
      hallId: entity.hallId ?? '',
      hall_name: entity.hall_name,
      price: entity.price,
      capacity: entity.capacity,
      shows: entity.shows.map((e) => ShowHiveModel.fromEntity(e)).toList(),
      seats: entity.seats.map((e) => SeatHiveModel.fromEntity(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [hallId, hall_name, price, capacity, shows, seats];
}
