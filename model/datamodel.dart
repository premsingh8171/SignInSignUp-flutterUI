
import 'dart:convert';

Datamodel datamodelFromJson(String str) => Datamodel.fromJson(json.decode(str));

String datamodelToJson(Datamodel data) => json.encode(data.toJson());

class Datamodel {
    Datamodel({
        required this.data,
        required this.name,
        required this.id,
    });

    Data data;
    String name;
    String id;

    factory Datamodel.fromJson(Map<dynamic, dynamic> json) => Datamodel(
        data: Data.fromJson(json["data"]),
        name: json["name"],
        id: json["id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "name": name,
        "id": id,
    };
}

class Data {
    Data({
        required this.color,
        required this.capacity,
    });

    String color;
    String capacity;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        color: json["color"],
        capacity: json["capacity"],
    );

    Map<dynamic, dynamic> toJson() => {
        "color": color,
        "capacity": capacity,
    };
}
