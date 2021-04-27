import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(explicitToJson:true)
class CategoryModel {
  @JsonKey(name: "categoryid",required: true)
  String id;
  
  @JsonKey(name: "parent_category_id", required: true)
  String parentId;
  
  String active;
  
  @JsonKey(name: "categoryrank")
  String rank;
  
  @JsonKey(name: "categoryname", required: true)
  String name;
  
  @JsonKey(name: "categorytimings",)
  String timings;
  
  @JsonKey(name: "category_image_url")
  String imageUrl;

  CategoryModel(
    this.id,
    this.parentId,
    this.active,
    this.rank,
    this.name,
    this.timings,
    this.imageUrl,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class ParentCategoryModel {
  String name;
  String online_display_name;
  int rank;
  String image_url;
  int id;
  int status;

  ParentCategoryModel(
    this.name,
    this.online_display_name,
    this.rank,
    this.image_url,
    this.id,
    this.status,
  );

  factory ParentCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParentCategoryModelToJson(this);
}

@JsonSerializable()
class ItemModel {
  int itemid;
  int itemallowvariation;
  int itemrank;
  int item_categoryid;
  String item_ordertype;
  double item_packingcharges;
  int itemallowaddon;
  int itemaddonbasedon;
  int item_favorite;
  String variation;
  String addon;
  String itemname;
  String item_attributeid;
  String itemdescription;
  String minimumpreparationtime;
  double price;
  int active;
  String item_image_url;

  ItemModel(
    this.itemid,
    this.itemallowvariation,
    this.itemrank,
    this.item_categoryid,
    this.item_ordertype,
    this.item_packingcharges,
    this.itemallowaddon,
    this.itemaddonbasedon,
    this.item_favorite,
    this.variation,
    this.addon,
    this.itemname,
    this.item_attributeid,
    this.itemdescription,
    this.minimumpreparationtime,
    this.price,
    this.active,
    this.item_image_url,
  );

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
