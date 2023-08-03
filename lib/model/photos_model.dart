class PhotosModel{
  String imgSrc;
  String PhotosName;

  PhotosModel ({
    required this.imgSrc,
    required this.PhotosName,
});
  static PhotosModel fromAPI2App(Map<String, dynamic> photoMap){
    return PhotosModel(PhotosName: photoMap["photographer"], imgSrc: (photoMap["src"])["portrait"]);
  }
}