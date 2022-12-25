import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String areaName;
  final String latitude;
  final String longitude;
  bool? isCompleted;
  bool? isPending;

  Data({
    required this.areaName,
    required this.latitude,
    required this.longitude,
    this.isCompleted,
    this.isPending,
  }) {
    isCompleted = isCompleted ?? false;
    isPending = isPending ?? false;
  }

  Data copyWith({
    String? areaName,
    String? latitude,
    String? longitude,
    bool? isCompleted,
    bool? isPending,
  }) {
    return Data(
        areaName: areaName ?? this.areaName,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isCompleted: isCompleted ?? this.isCompleted,
        isPending: isPending ?? this.isPending);
  }

  Map<String, dynamic> toMap() {
    return {
      'areaName': areaName,
      'latitude': latitude,
      'longitude': longitude,
      'isCompleted': isCompleted,
      'isPending': isPending
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      areaName: map['areaName'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      isCompleted: map['isCompleted'],
      isPending: map['isPending'],
    );
  }

  @override
  List<Object?> get props => [
        areaName,
        latitude,
        longitude,
        isCompleted,
        isPending,
      ];
}
