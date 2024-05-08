class Status {
  String? createdAt;
  String? name;

  Status({this.createdAt, this.name});

  Status.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}