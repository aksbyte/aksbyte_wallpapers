import 'package:aksbyte_wallpapers/controller/api_operation.dart';
import 'package:aksbyte_wallpapers/views/screens/full_screen.dart';
import 'package:aksbyte_wallpapers/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aksbyte_wallpapers/views/widgets/search_bar.dart'
    as CustomSearchBar;

import '../../model/photos_model.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;

  CategoryScreen({super.key, required this.catName, required this.catImgUrl});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotosModel> categoryResults = [];

  getCatResultWallpapers() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);
    setState(() {});
  }

  @override
  void initState() {
    getCatResultWallpapers();
    super.initState();
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
            Stack(
              children: [
                Image.network(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,widget.catImgUrl),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black26,
                ),
                 Positioned.fill(
                   child: Align(
                     alignment: Alignment.center,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         const Text(
                           "Category",
                           style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.w300,
                               fontSize: 15),
                         ),
                         Text(
                           widget.catName,
                           style: const TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.w600,
                               fontSize: 25),
                         ),
                       ],
                     ),
                   ),
                 )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: screenHeight * 0.83,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: screenHeight * 0.39,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: categoryResults.length,
                        itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreen(
                                              imgUrl: categoryResults[index]
                                                  .imgSrc)));
                                },
                                child: Hero(
                                  tag: categoryResults[index].imgSrc,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: screenHeight * 0.39,
                                    width: screenWidth * 0.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        categoryResults[index].imgSrc,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
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
