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
  final HallHiveModel hall;

  @HiveField(2)
  final ShowHiveModel show;

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
    required this.hall,
    required this.show,
    required this.seatColumn,
    required this.seatRow,
    required this.seatName,
    required this.seatStatus,
  });

  factory SeatHiveModel.fromEntity(SeatEntity entity) {
    return SeatHiveModel(
      seatId: entity.seatId ?? '',
      hall: HallHiveModel.fromEntity(entity.hall),
      show: ShowHiveModel.fromEntity(entity.show),
      seatColumn: entity.seatColumn ?? 0,
      seatRow: entity.seatRow ?? 0,
      seatName: entity.seatName ?? '',
      seatStatus: entity.seatStatus ?? false,
    );
  }

  SeatEntity toEntity() {
    return SeatEntity(
      seatId: seatId,
      hall: hall.toEntity(),
      show: show.toEntity(),
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
      'hall': hall.toJson(),
      'show': show.toJson(),
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
    hall: HallHiveModel.fromJson(json['hall']),
    show: ShowHiveModel.fromJson(json['show']),
    seatColumn: json['seatColumn'] ?? 0,
    seatRow: json['seatRow'] ?? 0,
    seatName: json['seatName'] ?? '',
    seatStatus: json['seatStatus'] ?? false,
  );
}

  @override
  // TODO: implement props
  List<Object?> get props => [hall ,show , seatColumn, seatRow , seatName , seatStatus , seatId];

}
