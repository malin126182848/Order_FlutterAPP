class OrderListModel {
  int code;
  String msg;
  List<OrderList> data;

  OrderListModel({this.code, this.msg, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<OrderList>();
      json['data'].forEach((v) {
        data.add(new OrderList.fromJson(v));
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

class OrderList {
  String orderId;
  String buyerName;
  String buyerPhone;
  String buyerAddress;
  String buyerOpenid;
  String mealCode;
  Object orderAmount;
  int orderStatus;
  int payStatus;
  int createTime;
  int updateTime;

  OrderList(
      {this.orderId,
        this.buyerName,
        this.buyerPhone,
        this.buyerAddress,
        this.buyerOpenid,
        this.mealCode,
        this.orderAmount,
        this.orderStatus,
        this.payStatus,
        this.createTime,
        this.updateTime});

  OrderList.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    buyerName = json['buyerName'];
    buyerPhone = json['buyerPhone'];
    buyerAddress = json['buyerAddress'];
    buyerOpenid = json['buyerOpenid'];
    orderAmount = json['orderAmount'];
    orderStatus = json['orderStatus'];
    payStatus = json['payStatus'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    mealCode = json['mealCode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['buyerName'] = this.buyerName;
    data['buyerPhone'] = this.buyerPhone;
    data['buyerAddress'] = this.buyerAddress;
    data['buyerOpenid'] = this.buyerOpenid;
    data['orderAmount'] = this.orderAmount;
    data['orderStatus'] = this.orderStatus;
    data['payStatus'] = this.payStatus;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['mealCode'] = this.mealCode;
    return data;
  }
}