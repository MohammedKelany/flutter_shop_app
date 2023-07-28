import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/change_favorite_model.dart';
import 'package:shop_app/model/favorite_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/model/user_model.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/catch_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/view/categories_view.dart';
import 'package:shop_app/view/favorites_view.dart';
import 'package:shop_app/view/home_view.dart';
import 'package:shop_app/view/settings_view.dart';
import 'package:shop_app/view/widgets/shared_components.dart';

import '../shared/network/end_points.dart';

class ShopController extends GetxController {
  @override
  ShopController() {
    getProducts();
    getCategories();
    getFavorites();
    getProfile();
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_border,
      ),
      label: "Favorites",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;

  int changeCurrentIndex(int index) {
    currentIndex = index;
    update();
    return currentIndex;
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getProducts() {
    DioHelper.getData(
      url: HOME,
      authorization: CatchHelper.getData(key: "token"),
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products?.forEach(
          (element) {
            favorites.addAll(
              {
                element.id!: element.inFavorites!,
              },
            );
          },
        );
        update();
      },
    ).catchError(
      (onError) {},
    );
  }

  CategoryModel? categoryModel;

  void getCategories() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then(
      (value) {
        categoryModel = CategoryModel.fromJson(value.data);
        update();
      },
    ).catchError(
      (onError) {},
    );
  }

  FavoriteModel? favoritesModel;

  void getFavorites() {
    DioHelper.getData(
      url: FAVORITES,
      authorization: CatchHelper.getData(key: 'token'),
    ).then(
      (value) {
        favoritesModel = FavoriteModel.fromJson(value.data);
        update();
      },
    ).catchError(
      (err) {},
    );
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorite(int id) {
    favorites[id] = !favorites[id]!;
    update();
    DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id": id,
      },
      authorization: CatchHelper.getData(key: "token"),
    ).then(
      (value) {
        changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
        if (!changeFavoritesModel!.status!) {
          favorites[id] = !favorites[id]!;
          getToast(
            text: changeFavoritesModel!.message!,
            state: ToastStates.ERROR,
          );
        } else if (changeFavoritesModel!.status!) {
          getFavorites();
          getToast(
            text: changeFavoritesModel!.message!,
            state: ToastStates.SUCCESS,
          );
        } else {
          favorites[id] = !favorites[id]!;
        }
        update();
      },
    ).catchError(
      (onError) {
        favorites[id] = !favorites[id]!;
        update();
      },
    );
  }

  SearchModel? searchModel;
  bool isLoading = false;

  void searchProducts(String text) {
    isLoading = true;
    update();
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      authorization: CatchHelper.getData(key: "token"),
    ).then((value) {
      isLoading = false;
      searchModel = SearchModel.fromJson(value.data);
      update();
    }).catchError((onError) {
      isLoading = false;
      update();
    });
  }

  UserModel? userProfile;

  void getProfile() {
    DioHelper.getData(
      url: PROFILE,
      authorization: token,
    ).then(
      (value) {
        userProfile = UserModel.fromJson(value.data);
        update();
      },
    ).catchError(
      (onError) {},
    );
  }

  bool updateLoading = false;

  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    updateLoading = true;
    update();
    DioHelper.putData(url: UPDATE_PROFILE, authorization: token, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": "123456",
      "image":
          "https://student.valuxapps.com/storage/uploads/users/NbQnVaNTEZ_1664723164.jpeg"
    }).then(
      (value) {
        updateLoading = false;
        userProfile = UserModel.fromJson(value.data);
        if (userProfile!.status!) {
          getToast(
            text: userProfile!.message!.toString(),
            state: ToastStates.SUCCESS,
          );
        } else {
          getToast(
            text: userProfile!.message!.toString(),
            state: ToastStates.ERROR,
          );
        }

        update();
      },
    ).catchError(
      (onError) {
        updateLoading = false;
        getToast(
          text: userProfile!.message!.toString(),
          state: ToastStates.ERROR,
        );
        update();
        getToast(text: "Updating Failed", state: ToastStates.ERROR);
      },
    );
  }

  void userLogout() {
    isLoading = true;
    update();
    DioHelper.postData(
      url: LOGOUT,
      data: {
        "fcm_token": token,
      },
      authorization: token,
    ).then((value) {
      isLoading = false;
      getToast(
        text: userProfile!.message!.toString(),
        state: ToastStates.SUCCESS,
      );
      homeModel = null;
      userProfile = null;
      categoryModel = null;
      favoritesModel = null;
      update();
    });
  }

  void userRegister() {
    isLoading = true;
    update();
    DioHelper.postData(
      url: LOGOUT,
      data: {
        "fcm_token": token,
      },
      authorization: token,
    ).then((value) {
      isLoading = false;
      getToast(
        text: userProfile!.message!.toString(),
        state: ToastStates.SUCCESS,
      );
      homeModel = null;
      userProfile = null;
      categoryModel = null;
      favoritesModel = null;
      update();
    });
  }
}
