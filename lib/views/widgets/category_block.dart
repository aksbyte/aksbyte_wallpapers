import 'package:flutter/material.dart';
import '../screens/category.dart';
import 'package:shimmer/shimmer.dart';

class CategoryBlock extends StatefulWidget {
  String categoryName;
  String categoryImgSrc;

  CategoryBlock(
      {super.key, required this.categoryName, required this.categoryImgSrc});

  @override
  State<CategoryBlock> createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(widget.categoryImgSrc), context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                    catName: widget.categoryName, catImgUrl: widget.categoryImgSrc)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),

        // list size is here

        child: Stack(
          children: [
            Container(
              height: 80,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.categoryImgSrc,
                height: 80,
                width: 140,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    // Image is fully loaded, show the actual image.
                    return child;
                  } else {
                    // Image is still loading, show the shimmer effect.
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 80,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.categoryName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        // Adjust the offset to control the shadow position
                        blurRadius: 3, // Adjust the blur radius to control the shadow intensity
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )

      ),
    );
  }
}
