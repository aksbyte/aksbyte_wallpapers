import 'dart:convert';
import 'package:aksbyte_wallpapers/model/photos_model.dart';
import 'package:http/http.dart' as http;
import '../model/category_model.dart';
import 'dart:math';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpaperList = [];
  static List<PhotosModel> categoryModelList = [];

  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
      "Authorization":
          "JKazj5mjZRslVSoeTqtkGtptu5anY3mkE32LvPuOJOM8vND1V7byYZrX"
    }).then((value) {
      //print(value.body);
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        trendingWallpapers.add(PhotosModel.fromAPI2App(element));
      });
    });
    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {
          "Authorization":
              "JKazj5mjZRslVSoeTqtkGtptu5anY3mkE32LvPuOJOM8vND1V7byYZrX"
        }).then((value) {
      //print(value.body);
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpaperList.clear();
      photos.forEach((element) {
        searchWallpaperList.add(PhotosModel.fromAPI2App(element));
      });
    });
    return searchWallpaperList;
  }

 /* static List<CategoryModel> getCategoriesList() {
    List categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    categoryModelList.clear();
    categoryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
          (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      categoryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return categoryModelList;
  }*/

  static Future<List<CategoryModel>> getCategoriesList() async {
    List<String> categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
      "Sky",
      "Beach",
      "Dark",
      "Beautiful",
      "Forest",
      "Abstract",
      "Technology",
      "Space",
      "Landscape",
    ];
    List<CategoryModel> categoryModelList = [];

    final random = Random();

    for (String catName in categoryName) {
      List<PhotosModel> wallpapers = await searchWallpapers(catName);
      PhotosModel photoModel = wallpapers[random.nextInt(wallpapers.length)];
      categoryModelList.add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    }

    return categoryModelList;
  }

}
