class GifModel {
  int? id;
  String? keyword;
  String? gifUrl;

  GifModel({this.id, this.keyword, this.gifUrl});

  GifModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
    gifUrl = json['gifUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyword'] = this.keyword;
    data['gifUrl'] = this.gifUrl;
    return data;
  }
}
