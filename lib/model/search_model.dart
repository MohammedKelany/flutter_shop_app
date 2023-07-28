class SearchModel {
  final bool? status;
  final dynamic message;
  final Data? data;

  SearchModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'],
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null;
}

class Data {
  final int? currentPage;
  final List<ProductData>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Data.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] as int?,
        data = (json['data'] as List?)
            ?.map(
                (dynamic e) => ProductData.fromJson(e as Map<String, dynamic>))
            .toList(),
        firstPageUrl = json['first_page_url'] as String?,
        from = json['from'] as int?,
        lastPage = json['last_page'] as int?,
        lastPageUrl = json['last_page_url'] as String?,
        nextPageUrl = json['next_page_url'],
        path = json['path'] as String?,
        perPage = json['per_page'] as int?,
        prevPageUrl = json['prev_page_url'],
        to = json['to'] as int?,
        total = json['total'] as int?;
}

class ProductData {
  final int? id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String? image;
  final String? name;
  final String? description;
  final List<String>? images;
  final bool? inFavorites;
  final bool? inCart;

  ProductData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        price = json['price'] as dynamic,
        oldPrice = json['old_price'] as dynamic,
        discount = json['discount'] as dynamic,
        image = json['image'] as String?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        images =
            (json['images'] as List?)?.map((dynamic e) => e as String).toList(),
        inFavorites = json['in_favorites'] as bool?,
        inCart = json['in_cart'] as bool?;
}
