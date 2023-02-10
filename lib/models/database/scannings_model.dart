class ScanningsModel {
  ScanningsModel({required this.title, required this.desc, required this.price, required this.duration});

  final String title;
  final String desc;
  final String price;
  final String duration;

  ScanningsModel.fromJson(Map<String, Object?> json)
      : this( title: json['title']! as String, desc: json['desc']! as String, price: json['price']! as String, duration: json['duration']! as String);

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'desc': desc,
      'price' : price,
      'duration' : duration
    };
  }
}