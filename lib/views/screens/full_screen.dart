import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreen extends StatelessWidget {
  String imgUrl;
   FullScreen({super.key, required this.imgUrl});


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
      /*  appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light
          ),
        ),*/
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}
