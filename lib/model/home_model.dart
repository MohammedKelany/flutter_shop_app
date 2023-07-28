class HomeModel {
  final bool? status;
  final dynamic message;
  final HomeDataModel? data;

  HomeModel({
    this.status,
    this.message,
    this.data,
  });

  HomeModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'],
        data = (json['data'] as Map<String, dynamic>?) != null
            ? HomeDataModel.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': message, 'data': data?.toJson()};
}

class HomeDataModel {
  final List<Banners>? banners;
  final List<Products>? products;
  final String? ad;

  HomeDataModel({
    this.banners,
    this.products,
    this.ad,
  });

  HomeDataModel.fromJson(Map<String, dynamic> json)
      : banners = (json['banners'] as List?)
            ?.map((dynamic e) => Banners.fromJson(e as Map<String, dynamic>))
            .toList(),
        products = (json['products'] as List?)
            ?.map((dynamic e) => Products.fromJson(e as Map<String, dynamic>))
            .toList(),
        ad = json['ad'] as String?;

  Map<String, dynamic> toJson() => {
        'banners': banners?.map((e) => e.toJson()).toList(),
        'products': products?.map((e) => e.toJson()).toList(),
        'ad': ad
      };
}

class Banners {
  final int? id;
  final String? image;
  final dynamic category;
  final dynamic product;

  Banners({
    this.id,
    this.image,
    this.category,
    this.product,
  });

  Banners.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        image = json['image'] as String?,
        category = json['category'],
        product = json['product'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'image': image, 'category': category, 'product': product};
}

class Products {
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

  Products({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  Products.fromJson(Map<String, dynamic> json)
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'old_price': oldPrice,
        'discount': discount,
        'image': image,
        'name': name,
        'description': description,
        'images': images,
        'in_favorites': inFavorites,
        'in_cart': inCart
      };
}
