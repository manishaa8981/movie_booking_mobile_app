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
  final int seatColumn;
  final int seatRow;
  final String seatName;
  final bool seatStatus;

  const SeatApiModel({
    this.seatId,
    required this.hall,
    required this.show,
    required this.seatColumn,
    required this.seatRow,
    required this.seatName,
    required this.seatStatus,
  });

  /// ✅ Convert API JSON to `SeatApiModel`
  factory SeatApiModel.fromJson(Map<String, dynamic> json) =>
      _$SeatApiModelFromJson(json);

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
        seatColumn: entity.seatColumn ?? 0,
        seatRow: entity.seatRow ?? 0,
        seatName: entity.seatName ?? '',
        seatStatus: entity.seatStatus ?? false,
      );

  /// ✅ Convert List of API Models to List of Entities
  static List<SeatEntity> toEntityList(List<SeatApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// ✅ Convert List of Entities to List of API Models
  static List<SeatApiModel> fromEntityList(List<SeatEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  List<Object?> get props =>
      [seatId, hall, show, seatColumn, seatRow, seatName, seatStatus];
}
