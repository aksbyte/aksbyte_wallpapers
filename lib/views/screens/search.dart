import 'package:aksbyte_wallpapers/controller/api_operation.dart';
import 'package:aksbyte_wallpapers/views/screens/full_screen.dart';
import 'package:aksbyte_wallpapers/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aksbyte_wallpapers/views/widgets/search_bar.dart'
    as CustomSearchBar;
import '../../model/photos_model.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults = [];

  GetSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetSearchResults();
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
                        itemCount: searchResults.length,
                        itemBuilder: ((context, index) => GridTile(
                              child: Hero(
                                tag: searchResults[index].imgSrc,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                              imgUrl: searchResults[index].imgSrc,
                                            )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: screenHeight * 0.39,
                                    width: screenWidth * 0.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        searchResults[index].imgSrc,
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
