// To parse this JSON data, do
//
//     final nearbyPlaces = nearbyPlacesFromJson(jsonString);
//@dart=2.9
import 'dart:convert';

NearbyPlaces nearbyPlacesFromJson(String str) => NearbyPlaces.fromJson(json.decode(str));

String nearbyPlacesToJson(NearbyPlaces data) => json.encode(data.toJson());

class NearbyPlaces {
    NearbyPlaces({
        this.type,
        this.features,
    });

    String type;
    List<Feature> features;

    factory NearbyPlaces.fromJson(Map<String, dynamic> json) => NearbyPlaces(
        type: json["type"],
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
    };
}

class Feature {
    Feature({
        this.type,
        this.id,
        this.geometry,
        this.properties,
    });

    FeatureType type;
    int id;
    GeometryClass geometry;
    Properties properties;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: featureTypeValues.map[json["type"]],
        id: json["id"],
        geometry: GeometryClass.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "type": featureTypeValues.reverse[type],
        "id": id,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
    };
}

class GeometryClass {
    GeometryClass({
        this.type,
        this.coordinates,
    });

    GeometryType type;
    List<double> coordinates;

    factory GeometryClass.fromJson(Map<String, dynamic> json) => GeometryClass(
        type: geometryTypeValues.map[json["type"]],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({
    "Point": GeometryType.POINT
});

class Properties {
    Properties({
        this.underground,
        this.extrude,
        this.height,
        this.iso31662,
        this.minHeight,
        this.iso31661,
        this.type,
        this.tilequery,
    });

    String underground;
    String extrude;
    int height;
    Iso31662 iso31662;
    int minHeight;
    Iso31661 iso31661;
    LayerEnum type;
    Tilequery tilequery;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        underground: json["underground"],
        extrude: json["extrude"],
        height: json["height"],
        iso31662: iso31662Values.map[json["iso_3166_2"]],
        minHeight: json["min_height"],
        iso31661: iso31661Values.map[json["iso_3166_1"]],
        type: layerEnumValues.map[json["type"]],
        tilequery: Tilequery.fromJson(json["tilequery"]),
    );

    Map<String, dynamic> toJson() => {
        "underground": underground,
        "extrude": extrude,
        "height": height,
        "iso_3166_2": iso31662Values.reverse[iso31662],
        "min_height": minHeight,
        "iso_3166_1": iso31661Values.reverse[iso31661],
        "type": layerEnumValues.reverse[type],
        "tilequery": tilequery.toJson(),
    };
}

enum Iso31661 { US }

final iso31661Values = EnumValues({
    "US": Iso31661.US
});

enum Iso31662 { US_CA }

final iso31662Values = EnumValues({
    "US-CA": Iso31662.US_CA
});

class Tilequery {
    Tilequery({
        this.distance,
        this.geometry,
        this.layer,
    });

    double distance;
    GeometryEnum geometry;
    LayerEnum layer;

    factory Tilequery.fromJson(Map<String, dynamic> json) => Tilequery(
        distance: json["distance"].toDouble(),
        geometry: geometryEnumValues.map[json["geometry"]],
        layer: layerEnumValues.map[json["layer"]],
    );

    Map<String, dynamic> toJson() => {
        "distance": distance,
        "geometry": geometryEnumValues.reverse[geometry],
        "layer": layerEnumValues.reverse[layer],
    };
}

enum GeometryEnum { POLYGON }

final geometryEnumValues = EnumValues({
    "polygon": GeometryEnum.POLYGON
});

enum LayerEnum { BUILDING }

final layerEnumValues = EnumValues({
    "building": LayerEnum.BUILDING
});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({
    "Feature": FeatureType.FEATURE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
