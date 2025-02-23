import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/hall/data/model/hall_hive_model.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_hive_model.dart';

part 'seat_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.seatTableId)class SeatHiveModel extends Equatable  {
  @HiveField(0)
  final String seatId;

  @HiveField(1)
  final HallHiveModel hallId;

  @HiveField(2)
  final ShowHiveModel showtimeId;

  @HiveField(3)
  final int seatColumn;

  @HiveField(4)
  final int seatRow;

  @HiveField(5)
  final String seatName;

  @HiveField(6)
  final bool seatStatus;

  const SeatHiveModel({
    required this.seatId,
    required this.hallId,
    required this.showtimeId,
    required this.seatColumn,
    required this.seatRow,
    required this.seatName,
    required this.seatStatus,
  });

  factory SeatHiveModel.fromEntity(SeatEntity entity) {
    return SeatHiveModel(
      seatId: entity.seatId ?? '',
      hallId: HallHiveModel.fromEntity(entity.hallId),
      showtimeId: ShowHiveModel.fromEntity(entity.showtimeId),
      seatColumn: entity.seatColumn ?? 0,
      seatRow: entity.seatRow ?? 0,
      seatName: entity.seatName ?? '',
      seatStatus: entity.seatStatus ?? false,
    );
  }

  SeatEntity toEntity() {
    return SeatEntity(
      seatId: seatId,
      hallId: hallId.toEntity(),
      showtimeId: showtimeId.toEntity(),
      seatColumn: seatColumn,
      seatRow: seatRow,
      seatName: seatName,
      seatStatus: seatStatus,
    );
  }

//to json
  Map<String, dynamic> toJson() {
    return {
      '_id': seatId,
      'hallId': hallId.toJson(),
      'showtimeId': showtimeId.toJson(),
      'seatColumn': seatColumn,
      'seatRow': seatRow,
      'seatName': seatName,
      'seatStatus': seatStatus,
    };
  }
//from json
  factory SeatHiveModel.fromJson(Map<String, dynamic> json) {
  return SeatHiveModel(
    seatId: json['_id'] ?? '',
    hallId: HallHiveModel.fromJson(json['hallId']),
    showtimeId: ShowHiveModel.fromJson(json['showtimeId']),
    seatColumn: json['seatColumn'] ?? 0,
    seatRow: json['seatRow'] ?? 0,
    seatName: json['seatName'] ?? '',
    seatStatus: json['seatStatus'] ?? false,
  );
}

  @override
  // TODO: implement props
  List<Object?> get props => [showtimeId ,showtimeId , seatColumn, seatRow , seatName , seatStatus , seatId];

}
