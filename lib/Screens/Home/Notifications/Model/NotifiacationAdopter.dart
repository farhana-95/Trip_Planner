import 'package:hive/hive.dart';
import 'package:trip_planner/Screens/Home/Notifications/Model/NotificationListModel.dart';

// class NotificationAdopter extends TypeAdapter<NotificationListModel> {
//   @override
//   final typeId = 0;
//
//   @override
//   NotificationListModel read(BinaryReader reader) {
//     return NotificationListModel(reader.read(), tripname: '', location: '', startdate: '', enddate: '', startdateTime: '');
//   }
//
//   @override
//   void write(BinaryWriter writer, NotificationListModel obj) {
//     writer.write(obj.tripname);
//   }
// }


class NotificationAdopter extends TypeAdapter<NotificationListModel> {
  @override
  final int typeId = 1;

  @override
  NotificationListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationListModel(
      tripid: fields[0] as String,
      tripname: fields[1] as String,
      location: fields[2] as String,
      startdate: fields[3] as String,
      enddate: fields[4] as String,
      startdateTime: fields[5] as String,

    );
  }

  @override
  void write(BinaryWriter writer, NotificationListModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tripid)
      ..writeByte(1)
      ..write(obj.tripname)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.startdate)
      ..writeByte(4)
      ..write(obj.enddate)
      ..writeByte(5)
      ..write(obj.startdateTime);

  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NotificationAdopter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
