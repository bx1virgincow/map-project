class DataModel {
  int id;
  String name;
  String x_cord;
  String y_cord;
  String description;
  bool completed;
  bool incomplete;

  DataModel(
      {required this.id,
      required this.name,
      required this.x_cord,
      required this.y_cord,
      required this.description,
      required this.completed,
      required this.incomplete});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      x_cord: json['x_cord'],
      y_cord: json['y_cord'],
      description: json['description'],
      completed: json['completed'],
      incomplete: json['incomplete'],
    );
  }

  factory DataModel.fromString(int id, String name, String x_cord,
      String y_cord, String description, bool completed, bool incomplete) {
    return DataModel(
      id: id,
      name: name,
      x_cord: x_cord,
      y_cord: y_cord,
      description: description,
      completed: completed,
      incomplete: incomplete,
    );
  }

  factory DataModel.fromMap(Map<String, dynamic> mapItems, param1) {
    return DataModel(
      id: mapItems['id'],
      name: mapItems['name'],
      x_cord: mapItems['x_cord'],
      y_cord: mapItems['y_cord'],
      description: mapItems['description'],
      completed: mapItems['completed'],
      incomplete: mapItems['incomplete'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['coordinateName'] = coordinateName;
  //   data['coordinate'] = coo,rdinate;
  //   data['description'] = description;
  //   return data;
  // }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'x_cord': x_cord,
        'y_cord': y_cord,
        'description': description,
        'completed': completed,
        'incomplete': incomplete,
      };
}
