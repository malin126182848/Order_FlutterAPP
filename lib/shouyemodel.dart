class ShouYeModel {
  int code;
  String msg;
  List<Data> data;

  ShouYeModel({this.code, this.msg, this.data});

  ShouYeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String name;
  int type;
  List<Foods> foods;

  Data({this.name, this.type, this.foods});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    if (json['foods'] != null) {
      foods = new List<Foods>();
      json['foods'].forEach((v) {
        foods.add(new Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.foods != null) {
      data['foods'] = this.foods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  String id;
  String name;
  double price;
  int sales;
  String description;
  String icon;

  Foods({this.id, this.name, this.price, this.description, this.icon, this.sales});

  Foods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    icon = json['icon'];
    sales = json['sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['sales'] = this.sales;
    return data;
  }
}