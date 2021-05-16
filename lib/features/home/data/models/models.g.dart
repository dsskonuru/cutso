// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMenu _$PostMenuFromJson(Map<String, dynamic> json) {
  return PostMenu(
    json['success'] as String?,
    json['message'] as String?,
    (json['restaurants'] as List<dynamic>?)
        ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['ordertypes'] as List<dynamic>?)
        ?.map((e) => OrderType.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['categories'] as List<dynamic>?)
        ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['parentcategories'] as List<dynamic>?)
        ?.map((e) => ParentCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['items'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['discounts'] as List<dynamic>?)
        ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['taxes'] as List<dynamic>?)
        ?.map((e) => Tax.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['http_code'] as int?,
  );
}

Map<String, dynamic> _$PostMenuToJson(PostMenu instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'restaurants': instance.restaurants?.map((e) => e.toJson()).toList(),
      'ordertypes': instance.orderTypes?.map((e) => e.toJson()).toList(),
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
      'parentcategories':
          instance.parentCategories?.map((e) => e.toJson()).toList(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'discounts': instance.discounts?.map((e) => e.toJson()).toList(),
      'taxes': instance.taxes?.map((e) => e.toJson()).toList(),
      'http_code': instance.httpCode,
    };

OrderType _$OrderTypeFromJson(Map<String, dynamic> json) {
  return OrderType(
    json['ordertypeid'] as int?,
    json['ordertype'] as String?,
  );
}

Map<String, dynamic> _$OrderTypeToJson(OrderType instance) => <String, dynamic>{
      'ordertypeid': instance.orderTypeId,
      'ordertype': instance.orderType,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['restaurantid', 'details']);
  return Restaurant(
    json['restaurantid'] as String?,
    json['active'] as String?,
    json['details'] == null
        ? null
        : RestaurantDetails.fromJson(json['details'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'restaurantid': instance.restaurantid,
      'active': instance.active,
      'details': instance.details?.toJson(),
    };

RestaurantDetails _$RestaurantDetailsFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['restaurantname']);
  return RestaurantDetails(
    json['restaurantname'] as String?,
    json['address'] as String?,
    json['city'] as String?,
    json['state'] as String?,
    json['landmark'] as String?,
    json['latitude'] as String?,
    json['longitude'] as String?,
    json['contact'] as String?,
    json['minimumorderamount'] as String?,
    json['minimumdeliverytime'] as String?,
    json['deliverycharge'] as String?,
    json['menusharingcode'] as String?,
  );
}

Map<String, dynamic> _$RestaurantDetailsToJson(RestaurantDetails instance) =>
    <String, dynamic>{
      'restaurantname': instance.restaurantname,
      'menusharingcode': instance.menusharingcode,
      'address': instance.address,
      'contact': instance.contact,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'landmark': instance.landmark,
      'city': instance.city,
      'state': instance.state,
      'minimumorderamount': instance.minimumorderamount,
      'minimumdeliverytime': instance.minimumdeliverytime,
      'deliverycharge': instance.deliverycharge,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['categoryid', 'parent_category_id', 'categoryname']);
  return Category(
    json['categoryid'] as String?,
    json['parent_category_id'] as String?,
    json['active'] as String?,
    json['categoryname'] as String?,
    json['categorytimings'] as String?,
    json['category_image_url'] as String?,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'categoryid': instance.id,
      'parent_category_id': instance.parentId,
      'active': instance.active,
      'categoryname': instance.name,
      'categorytimings': instance.timings,
      'category_image_url': instance.imageUrl,
    };

ParentCategory _$ParentCategoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['name']);
  return ParentCategory(
    json['name'] as String?,
    json['online_display_name'] as String?,
    json['image_url'] as String?,
    json['id'] as String?,
    json['status'] as String?,
  );
}

Map<String, dynamic> _$ParentCategoryToJson(ParentCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'online_display_name': instance.displayName,
      'image_url': instance.imageUrl,
      'id': instance.id,
      'status': instance.status,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['itemid'] as String?,
    json['itemname'] as String?,
    json['item_categoryid'] as String?,
    json['item_ordertype'] as String?,
    json['item_packingcharges'] as String?,
    json['itemdescription'] as String?,
    json['minimumpreparationtime'] as String?,
    json['price'] as String?,
    json['active'] as String?,
    json['item_image_url'] as String?,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'itemid': instance.id,
      'itemname': instance.name,
      'item_categoryid': instance.categoryId,
      'item_ordertype': instance.orderType,
      'item_packingcharges': instance.packingCharges,
      'itemdescription': instance.description,
      'minimumpreparationtime': instance.minimumPreparationTime,
      'price': instance.price,
      'active': instance.active,
      'item_image_url': instance.imageUrl,
    };

Tax _$TaxFromJson(Map<String, dynamic> json) {
  return Tax(
    json['taxid'] as String?,
    json['taxname'] as String?,
    json['description'] as String?,
    json['tax'] as String?,
    json['taxtype'] as String?,
    json['active'] as String?,
  );
}

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'taxid': instance.id,
      'taxname': instance.name,
      'tax': instance.tax,
      'taxtype': instance.type,
      'active': instance.active,
      'description': instance.description,
    };

Discount _$DiscountFromJson(Map<String, dynamic> json) {
  return Discount(
    json['discountid'] as String?,
    json['discountname'] as String?,
    json['discount'] as String?,
    json['discounttype'] as String?,
    json['discounthascoupon'] as String?,
    json['active'] as String?,
    json['discountcategoryitemids'] as String?,
    json['discountdays'] as String?,
    json['discountstarts'] as String?,
    json['discountends'] as String?,
    json['discounttimefrom'] as String?,
    json['discounttimeto'] as String?,
    json['discountminamount'] as String?,
    json['discountmaxamount'] as String?,
    json['discountmaxlimit'] as String?,
    json['discountontotal'] as String?,
  );
}

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'discountid': instance.id,
      'discountname': instance.name,
      'discount': instance.value,
      'discounttype': instance.type,
      'discountdays': instance.days,
      'discountontotal': instance.onTotal,
      'discountstarts': instance.startDate,
      'discountends': instance.endDate,
      'discounttimefrom': instance.startTime,
      'discounttimeto': instance.endTime,
      'discountminamount': instance.minAmount,
      'discountmaxamount': instance.maxAmount,
      'discounthascoupon': instance.hasCoupon,
      'discountcategoryitemids': instance.categoryItemIds,
      'active': instance.active,
      'discountmaxlimit': instance.maxLimit,
    };
