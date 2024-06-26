class Package {
  int? id;
  double? width;
  double? height;
  double? length;
  double? weight;
  String? name;

  Package({this.id, this.width, this.height, this.length,this.weight, this.name});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    length = json['length'];
    weight = json['weight'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['width'] = this.width;
    data['height'] = this.height;
    data['length'] = this.length;
    data['name'] = this.name;
    data['weight'] = this.weight;
    return data;
  }
}