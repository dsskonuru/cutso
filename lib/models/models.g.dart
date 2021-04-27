// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['categoryid', 'parent_category_id', 'categoryname']);
  return CategoryModel(
    json['categoryid'] as String,
    json['parent_category_id'] as String,
    json['active'] as String,
    json['categoryrank'] as String,
    json['categoryname'] as String,
    json['categorytimings'] as String,
    json['category_image_url'] as String,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'categoryid': instance.id,
      'parent_category_id': instance.parentId,
      'active': instance.active,
      'categoryrank': instance.rank,
      'categoryname': instance.name,
      'categorytimings': instance.timings,
      'category_image_url': instance.imageUrl,
    };

ParentCategoryModel _$ParentCategoryModelFromJson(Map<String, dynamic> json) {
  return ParentCategoryModel(
    json['name'] as String,
    json['online_display_name'] as String,
    json['rank'] as int,
    json['image_url'] as String,
    json['id'] as int,
    json['status'] as int,
  );
}

Map<String, dynamic> _$ParentCategoryModelToJson(
        ParentCategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'online_display_name': instance.online_display_name,
      'rank': instance.rank,
      'image_url': instance.image_url,
      'id': instance.id,
      'status': instance.status,
    };

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
    json['itemid'] as int,
    json['itemallowvariation'] as int,
    json['itemrank'] as int,
    json['item_categoryid'] as int,
    json['item_ordertype'] as String,
    (json['item_packingcharges'] as num).toDouble(),
    json['itemallowaddon'] as int,
    json['itemaddonbasedon'] as int,
    json['item_favorite'] as int,
    json['variation'] as String,
    json['addon'] as String,
    json['itemname'] as String,
    json['item_attributeid'] as String,
    json['itemdescription'] as String,
    json['minimumpreparationtime'] as String,
    (json['price'] as num).toDouble(),
    json['active'] as int,
    json['item_image_url'] as String,
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'itemid': instance.itemid,
      'itemallowvariation': instance.itemallowvariation,
      'itemrank': instance.itemrank,
      'item_categoryid': instance.item_categoryid,
      'item_ordertype': instance.item_ordertype,
      'item_packingcharges': instance.item_packingcharges,
      'itemallowaddon': instance.itemallowaddon,
      'itemaddonbasedon': instance.itemaddonbasedon,
      'item_favorite': instance.item_favorite,
      'variation': instance.variation,
      'addon': instance.addon,
      'itemname': instance.itemname,
      'item_attributeid': instance.item_attributeid,
      'itemdescription': instance.itemdescription,
      'minimumpreparationtime': instance.minimumpreparationtime,
      'price': instance.price,
      'active': instance.active,
      'item_image_url': instance.item_image_url,
    };
