class CatObj {
  String _id;
  String title;
  String image;

  CatObj(this._id, this.title, this.image);

  CatObj.fromJson(Map<String, dynamic> json)
    : _id = json['_id'],
      title = json['title'],
      image = json['image'];

  get id {
    return _id;
  }
}