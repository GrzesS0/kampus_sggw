import 'package:kampus_sggw/models/map_item.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'map_items.g.dart';

@JsonSerializable()
class MapItems {
  List<MapItem> mapItems;
  MapItems(
    this.mapItems,
  );
  List<MapItem> filter(List<MapItemType> types) =>
      mapItems.where((element) => types.contains(element.type));
  factory MapItems.fromJson(Map<String, dynamic> json) =>
      _$MapItemsFromJson(json);

  static Future<String> getJsonSting() {
    return rootBundle.loadString('assets/json/map_items.json');
  }
}