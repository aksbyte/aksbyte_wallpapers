import 'package:aksbyte_wallpapers/controller/api_operation.dart';
import 'package:aksbyte_wallpapers/model/category_model.dart';
import 'package:aksbyte_wallpapers/views/screens/full_screen.dart';
import 'package:aksbyte_wallpapers/views/widgets/category_block.dart';
import 'package:aksbyte_wallpapers/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aksbyte_wallpapers/views/widgets/search_bar.dart'
    as CustomSearchBar;
import 'package:shimmer/shimmer.dart';

import '../../model/photos_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<PhotosModel> trendingWallList = [];
  late List<CategoryModel> catModList = [];

  getCatDetails() async {
    catModList = await ApiOperations.getCategoriesList();
    setState(() {});
  }

  getTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpapers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTrendingWallpapers();
    getCatDetails();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(word1: "AksByte", word2: "Wallpapers"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomSearchBar.SearchBar(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: catModList.length,
                    itemBuilder: ((context, index) => CategoryBlock(
                        categoryImgSrc: catModList[index].catImgUrl,
                        categoryName: catModList[index].catName))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: screenHeight * 0.83,
              child: Column(
                children: [
                  Expanded(
                    child:
                    GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: screenHeight * 0.39,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: trendingWallList.length,
                      itemBuilder: ((context, index) {
                        final imgUrl = trendingWallList[index].imgSrc;
                        return GridTile(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreen(imgUrl: imgUrl),
                                ),
                              );
                            },
                            child: Hero(
                              tag: imgUrl,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,

                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.yellow.shade100,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          height: screenHeight * 0.39,
                                          width: screenWidth * 0.4,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
