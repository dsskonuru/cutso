import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(explicitToJson: true)
class PostMenu {
  @JsonKey(name: "success")
  String? success;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "restaurants")
  List<Restaurant>? restaurants;
  @JsonKey(name: "ordertypes")
  List<OrderType>? orderTypes;
  @JsonKey(name: "categories")
  List<Category>? categories;
  @JsonKey(name: "parentcategories")
  List<ParentCategory>? parentCategories;
  @JsonKey(name: "items")
  List<Item>? items;
  @JsonKey(name: "discounts")
  List<Discount>? discounts;
  @JsonKey(name: "taxes")
  List<Tax>? taxes;
  @JsonKey(name: "http_code")
  int? httpCode;
  // @JsonKey(name: "variations")
  // List<Variation>? variations;
  // @JsonKey(name: "addongroups")
  // List<AddOnGroup>? addOnGroups;
  // @JsonKey(name: "attributes")
  // List<Attribute>? attributes;

  PostMenu(
    this.success,
    this.message,
    this.restaurants,
    this.orderTypes,
    this.categories,
    this.parentCategories,
    this.items,
    this.discounts,
    this.taxes,
    this.httpCode,
    // this.variations,
    // this.addOnGroups,
    // this.attributes,
  );

  factory PostMenu.fromJson(Map<String, dynamic> json) =>
      _$PostMenuFromJson(json);
  Map<String, dynamic> toJson() => _$PostMenuToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }

  List<String?> getItems(String parentCategoryId) {
    List<Category> _categories = this
        .categories!
        .where((category) => category.parentId == parentCategoryId)
        .toList();
    List<String?> _categoryIds =
        _categories.map((category) => category.id).toList();
    List<Item> _items = this
        .items!
        .where((item) => _categoryIds.contains(item.categoryId))
        .toList();
    return _items.map((e) => e.name).toList();
    // .categories!0
    // .where((category) => category.parentId == parentCategory.id).map((e) => e.id);
  }

  List<String?> getParentCategoryIds() {
    return this.parentCategories!.map((e) => e.id).toList();
  }

  List<String?> getCategoryIds() {
    return this.categories!.map((e) => e.id).toList();
  }
}

@JsonSerializable(explicitToJson: true)
class OrderType {
  @JsonKey(name: "ordertypeid")
  int? orderTypeId;
  @JsonKey(name: "ordertype")
  String? orderType;

  OrderType(this.orderTypeId, this.orderType);

  factory OrderType.fromJson(Map<String, dynamic> json) =>
      _$OrderTypeFromJson(json);
  Map<String, dynamic> toJson() => _$OrderTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Restaurant {
  @JsonKey(name: "restaurantid", required: true)
  String? restaurantid;
  @JsonKey(name: "active")
  String? active;
  @JsonKey(name: "details", required: true)
  RestaurantDetails? details;

  Restaurant(this.restaurantid, this.active, this.details);

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RestaurantDetails {
  @JsonKey(name: "restaurantname", required: true)
  String? restaurantname;
  @JsonKey(name: "menusharingcode")
  String? menusharingcode;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "contact")
  String? contact;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "landmark")
  String? landmark;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "minimumorderamount")
  String? minimumorderamount;
  @JsonKey(name: "minimumdeliverytime")
  String? minimumdeliverytime;
  @JsonKey(name: "deliverycharge")
  String? deliverycharge;
  // @JsonKey(name: "currency")
  // String? currency;
  // @JsonKey(name: "cuisines")
  // String? cuisines;
  // @JsonKey(name: "restaurantstatus")
  // String? restaurantstatus;
  // @JsonKey(name: "acceptonlinepayment")
  // String? acceptonlinepayment;
  // @JsonKey(name: "deliveryhoursfrom1 ")
  // String? deliveryhoursfrom1;
  // @JsonKey(name: "deliveryhoursto1")
  // String? deliveryhoursto1;
  // @JsonKey(name: "deliveryhoursfrom2")
  // String? deliveryhoursfrom2;
  // @JsonKey(name: "deliveryhoursto2")
  // String? deliveryhoursto2;
  // @JsonKey(name: "custom_payment_type")
  // String? custom_payment_type;
  // @JsonKey(name: "calculatetaxonpacking")
  // String? calculateTaxOnPacking;
  // @JsonKey(name: "calculatetaxondelivery")
  // String? calculateTaxOnDelivery;

  RestaurantDetails(
    this.restaurantname,
    this.address,
    this.city,
    this.state,
    this.landmark,
    this.latitude,
    this.longitude,
    this.contact,
    this.minimumorderamount,
    this.minimumdeliverytime,
    this.deliverycharge,
    this.menusharingcode,
  );

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Category {
  @JsonKey(name: "categoryid", required: true)
  String? id;
  @JsonKey(name: "parent_category_id", required: true)
  String? parentId;
  @JsonKey(name: "active")
  String? active;
  @JsonKey(name: "categoryname", required: true)
  String? name;
  @JsonKey(name: "categorytimings")
  String? timings;
  @JsonKey(name: "category_image_url")
  String? imageUrl;
  // @JsonKey(name: "categoryrank")
  // String? rank;

  Category(
    this.id,
    this.parentId,
    this.active,
    this.name,
    this.timings,
    this.imageUrl,
    // this.rank,
  );

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ParentCategory {
  @JsonKey(name: "name", required: true)
  String? name;
  @JsonKey(name: "online_display_name")
  String? displayName;
  @JsonKey(name: "image_url")
  String? imageUrl;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "status")
  String? status;
  // @JsonKey(name: "rank")
  // String? rank;

  ParentCategory(
    this.name,
    this.displayName,
    this.imageUrl,
    this.id,
    this.status,
    // this.rank,
  );

  factory ParentCategory.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ParentCategoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Item {
  @JsonKey(name: "itemid")
  String? id;
  @JsonKey(name: "itemname")
  String? name;
  @JsonKey(name: "item_categoryid")
  String? categoryId;
  @JsonKey(name: "item_ordertype")
  String? orderType;
  @JsonKey(name: "item_packingcharges")
  String? packingCharges;
  @JsonKey(name: "itemdescription")
  String? description;
  @JsonKey(name: "minimumpreparationtime")
  String? minimumPreparationTime;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "active")
  String? active;
  @JsonKey(name: "item_image_url")
  String? imageUrl;
  // @JsonKey(name: "itemallowvariation")
  // String? allowVariation;
  // @JsonKey(name: "itemrank")
  // String? rank;
  // @JsonKey(name: "itemAllowAddon")
  // String? itemAllowAddon;
  // @JsonKey(name: "itemaddonbasedon")
  // String? itemAddonBasedon;
  // @JsonKey(name: "item_favorite")
  // String? favorite;
  // @JsonKey(name: "variation")
  // String? variation;
  // @JsonKey(name: "addon")
  // String? addon;
  // @JsonKey(name: "item_attributeid")
  // String? attributeId;

  Item(
    this.id,
    this.name,
    this.categoryId,
    this.orderType,
    this.packingCharges,
    this.description,
    this.minimumPreparationTime,
    this.price,
    this.active,
    this.imageUrl,
    // this.itemallowvariation,
    // this.rank,
    // this.itemallowaddon,
    // this.itemaddonbasedon,
    // this.item_favorite,
    // this.variation,
    // this.addon,
    // this.item_attributeid,
  );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tax {
  @JsonKey(name: "taxid")
  String? id;
  @JsonKey(name: "taxname")
  String? name;
  @JsonKey(name: "tax")
  String? tax;
  @JsonKey(name: "taxtype") // 1 = Percentage, 2 = Fixed
  String? type;
  @JsonKey(name: "active")
  String? active;
  @JsonKey(name: "description")
  String? description;
// @JsonKey(name: "tax_ordertype") // Applicable order types
// String? taxOrderTypes;
// @JsonKey(name: "tax_coreortotal") // 1 = Add on Total, 2 = Add on Core
// String? coreOrTotal;
// @JsonKey(name: "tax_taxtype") // 1 = forward tax, 2 = backward tax
// String? taxType;

  Tax(
    this.id,
    this.name,
    this.description,
    this.tax,
    this.type,
    this.active,
  );

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
  Map<String, dynamic> toJson() => _$TaxToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Discount {
  @JsonKey(name: "discountid")
  String? id;
  @JsonKey(name: "discountname")
  String? name;
  @JsonKey(name: "discount")
  String? value;
  @JsonKey(name: "discounttype") // 1 = Percentage, 2 = Fixed, 3 = BOGO
  String? type;
  // @JsonKey(name: "discountordertype")
  // String? orderType;
  // @JsonKey(name: "discountapplicableon") // 1 = Desktop, 2 = Online, 3 = Zomato
  // String? applicableOn;
  @JsonKey(name: "discountdays") // Value : Sun,Mon,Tue,Wed,Thu,Fri,Sat OR all
  String? days;
  @JsonKey(name: "discountontotal") // 1 = Add on Total, 2 = Add on Core
  String? onTotal;
  @JsonKey(name: "discountstarts")
  String? startDate;
  @JsonKey(name: "discountends")
  String? endDate;
  @JsonKey(name: "discounttimefrom")
  String? startTime;
  @JsonKey(name: "discounttimeto")
  String? endTime;
  @JsonKey(name: "discountminamount") // to be applicable
  String? minAmount;
  @JsonKey(name: "discountmaxamount")
  String? maxAmount;
  @JsonKey(name: "discounthascoupon")
  String? hasCoupon;
  @JsonKey(name: "discountcategoryitemids") // Category item ids comma separated
  String? categoryItemIds;
  @JsonKey(name: "active")
  String? active;
  @JsonKey(name: "discountmaxlimit")
  String? maxLimit;
  // @JsonKey(name: "discountorder")
  // String? order;

  Discount(
    this.id,
    this.name,
    this.value,
    this.type,
    this.hasCoupon,
    this.active,
    this.categoryItemIds,
    this.days,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.minAmount,
    this.maxAmount,
    this.maxLimit,
    this.onTotal,
    // this.order,
  );

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}
