class User{
  String _id;
  String name;
  String phone;

  User(this._id,this.name,this.phone);

  factory User.fromJson(Map<String,dynamic> data){
    return User(data['data']['_id'],data['data']['name'],data['data']['phone']);
  }
}