class OrderDetailModel {
  int code;
  String msg;
  OrderDetail data;

  OrderDetailModel({this.code, this.msg, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new OrderDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class OrderDetail {
  String orderId;
  String buyerName;
  String buyerPhone;
  String buyerAddress;
  String buyerOpenid;
  String mealCode;
  double orderAmount;
  int orderStatus;
  int payStatus;
  int createTime;
  int updateTime;
  List<OrderDetailList> orderDetailList;

  OrderDetail(
      {this.orderId,
        this.buyerName,
        this.buyerPhone,
        this.buyerAddress,
        this.buyerOpenid,
        this.orderAmount,
        this.orderStatus,
        this.payStatus,
        this.mealCode,
        this.createTime,
        this.updateTime,
        this.orderDetailList});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    buyerName = json['buyerName'];
    buyerPhone = json['buyerPhone'];
    buyerAddress = json['buyerAddress'];
    buyerOpenid = json['buyerOpenid'];
    orderAmount = json['orderAmount'];
    orderStatus = json['orderStatus'];
    mealCode = json['mealCode'].toString();
    payStatus = json['payStatus'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    if (json['orderDetailList'] != null) {
      orderDetailList = new List<OrderDetailList>();
      json['orderDetailList'].forEach((v) {
        orderDetailList.add(new OrderDetailList.fromJson(v));
      });
    }
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
    data['mealCode'] = this.mealCode;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    if (this.orderDetailList != null) {
      data['orderDetailList'] =
          this.orderDetailList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetailList {
  String detailId;
  String orderId;
  String productId;
  String productName;
  double productPrice;
  int productQuantity;
  String productIcon;

  OrderDetailList(
      {this.detailId,
        this.orderId,
        this.productId,
        this.productName,
        this.productPrice,
        this.productQuantity,
        this.productIcon});

  OrderDetailList.fromJson(Map<String, dynamic> json) {
    detailId = json['detailId'];
    orderId = json['orderId'];
    productId = json['productId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productQuantity = json['productQuantity'];
    productIcon = json['productIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detailId'] = this.detailId;
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productQuantity'] = this.productQuantity;
    data['productIcon'] = this.productIcon;
    return data;
  }
}