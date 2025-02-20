import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/hall/data/model/hall_api_model.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_api_model.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';

part 'seat_api_model.g.dart';

@JsonSerializable()
class SeatApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? seatId;
  final HallApiModel hall;
  final ShowApiModel show;
  final int? seatColumn;
  final int? seatRow;
  final String? seatName;
  final bool? seatStatus; // Changed from Bool to bool

  const SeatApiModel({
    this.seatId,
    required this.hall,
    required this.show,
    this.seatColumn,
    this.seatRow,
    this.seatName,
    this.seatStatus,
  });

  /// ✅ Provide an empty instance
  static SeatApiModel empty() {
    return SeatApiModel(
      seatId: '',
      hall: HallApiModel.empty(),  // ✅ Handles missing Hall data
      show: ShowApiModel.empty(),  // ✅ Handles missing Show data
      seatColumn: 0,
      seatRow: 0,
      seatName: '',
      seatStatus: false,
    );
  }

  /// ✅ Convert API JSON to `SeatApiModel`
  factory SeatApiModel.fromJson(Map<String, dynamic> json) {
    return SeatApiModel(
      seatId: json['_id'] as String?,
      hall: json['hall'] is String
          ? HallApiModel.empty() // Handles case when hall is just an ID
          : HallApiModel.fromJson(json['hall'] as Map<String, dynamic>),
      show: json['show'] is String
          ? ShowApiModel.empty() // Handles case when show is just an ID
          : ShowApiModel.fromJson(json['show'] as Map<String, dynamic>),
      seatColumn: json['seatColumn'] as int?,
      seatRow: json['seatRow'] as int?,
      seatName: json['seatName'] as String?,
      seatStatus: json['seatStatus'] as bool?,
    );
  }

  /// ✅ Convert `SeatApiModel` to JSON
  Map<String, dynamic> toJson() => _$SeatApiModelToJson(this);

  /// ✅ Convert `SeatApiModel` to Domain Entity (`SeatEntity`)
  SeatEntity toEntity() => SeatEntity(
        seatId: seatId,
        hall: hall.toEntity(),
        show: show.toEntity(),
        seatColumn: seatColumn,
        seatRow: seatRow,
        seatName: seatName,
        seatStatus: seatStatus,
      );

  /// ✅ Convert `SeatEntity` to `SeatApiModel`
  static SeatApiModel fromEntity(SeatEntity entity) => SeatApiModel(
        seatId: entity.seatId,
        hall: HallApiModel.fromEntity(entity.hall),
        show: ShowApiModel.fromEntity(entity.show),
        seatColumn: entity.seatColumn,
        seatRow: entity.seatRow,
        seatName: entity.seatName,
        seatStatus: entity.seatStatus,
      );

  /// ✅ Convert List of API Models to List of Entities
  static List<SeatEntity> toEntityList(List<SeatApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// ✅ Convert List of Entities to List of API Models
  static List<SeatApiModel> fromEntityList(List<SeatEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  List<Object?> get props => [
        seatId,
        hall,
        show,
        seatColumn,
        seatRow,
        seatName,
        seatStatus,
      ];
}
