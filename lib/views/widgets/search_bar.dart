import 'package:aksbyte_wallpapers/views/screens/search.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
   SearchBar({ super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (query){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(query: _searchController.text)));
              },
              decoration: InputDecoration(
                hintText: "Search wallpapers",
                hintMaxLines: 1,
                prefixIcon: const Icon(
                  Icons.photo,
                ),
                suffixIcon: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(query: _searchController.text)));
                    },
                    child: const Icon(Icons.search)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
