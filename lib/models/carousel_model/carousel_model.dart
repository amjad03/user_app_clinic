class CarouselModel {
  CarouselModel({ required this.image});

  // final String id;
  final String image;

  CarouselModel.fromJson(Map<String, Object?> json)
      : this( image: json['image']! as String);

  Map<String, Object?> toJson() {
    return {
      // 'title': id,
      'image': image,
    };
  }
}