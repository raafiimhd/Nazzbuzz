// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppPlaylistAdapter extends TypeAdapter<AppPlaylist> {
  @override
  final int typeId = 1;

  @override
  AppPlaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppPlaylist(
      playlistName: fields[0] as String,
    )..items = (fields[1] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, AppPlaylist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
