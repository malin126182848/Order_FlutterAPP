import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dincan/orderdetailmodel.dart';
import 'package:flutter_dincan/utils/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'api/Api.dart';
import 'api/service.dart';

class OrderPageDetail extends StatefulWidget {
  String id;
  String openid;

  OrderPageDetail(this.id, this.openid);

  @override
  _OrderPageDetailState createState() => _OrderPageDetailState(id,openid);
}

class _OrderPageDetailState extends State<OrderPageDetail> {
  String id;
  String openid;

  _OrderPageDetailState(this.id, this.openid);
  OrderDetail orderDetail;
  String  time;

  netFetch() async {
    getRequest(Api.OrderDetail+'?openid=$openid&orderId=$id').then((val) {
      OrderDetailModel shouYeModel = OrderDetailModel.fromJson(
          json.decode(val));
      String createTime = shouYeModel.data.createTime.toString() + '000000';
      createTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(createTime))
          .toLocal()
          .toString();
      setState(() {
        orderDetail = shouYeModel.data;
        time = createTime;
      });
    });
  }

  @override
  void initState() {
    getRequest(Api.OrderDetail+'?openid=$openid&orderId=$id').then((val){
      OrderDetailModel shouYeModel = OrderDetailModel.fromJson(json.decode(val));
      String createTime = shouYeModel.data.createTime.toString()+'000000';
      createTime  = DateTime.fromMicrosecondsSinceEpoch(int.parse(createTime)).toLocal().toString();
      setState(() {
        orderDetail = shouYeModel.data;
        time = createTime;
      });
    });
    netFetch();
    /*rootBundle.loadString('assets/orderdetail.json').then((value) {
      OrderDetailModel shouYeModel = OrderDetailModel.fromJson(json.decode(value));
      String createTime = shouYeModel.data.createTime.toString()+'000';
      createTime  = DateTime.fromMicrosecondsSinceEpoch(int.parse(createTime)).toLocal().toString();
      setState(() {
        orderDetail = shouYeModel.data;
        time = createTime;
      });
    });*/
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Image.asset('images/back.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setHeight(60),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        titleSpacing: 12.0,
        title: Text('订单详情',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            alignment: Alignment.center,
            color: Colors.green,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Icon(Icons.update),
                    Text('   下单成功'),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text('取餐号：${orderDetail.mealCode}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
                SizedBox(height: 20,),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0,0,0,10),
            padding: EdgeInsets.fromLTRB(10, ScreenUtil().setHeight(20), 10, ScreenUtil().setHeight(20)),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white, width: 0.5), // 边色与边宽度
              color: Colors.white, // 底色
              //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
              borderRadius: BorderRadius.circular(10.0), //3像素圆角

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Text('商品详情',style:TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                ListView.builder(
                    shrinkWrap: true, //解决无限高度问题
                    physics: new NeverScrollableScrollPhysics(), //禁用滑动事件
                    itemCount: orderDetail.orderDetailList.length,
                    itemBuilder: (context, index) {
                      return _listItem(index, orderDetail.orderDetailList[index]);
                    }),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Text(''),
                      Expanded(
                        flex: 6,
                        child: Container(),
                      ),
                      Text('总计：￥${orderDetail.orderAmount.toString()}',style:TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20.0,0,20,0),
            padding: EdgeInsets.fromLTRB(10, ScreenUtil().setHeight(20), 10, ScreenUtil().setHeight(20)),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white, width: 0.5), // 边色与边宽度
              color: Colors.white, // 底色
              //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
              borderRadius: BorderRadius.circular(10.0), //3像素圆角

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15,),
                Text('订单信息',style:TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 15,),
                Row(
                  children: <Widget>[
                    Text('就餐方式',style:TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text(orderDetail.buyerName,style:TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: <Widget>[
                    Text('商家名称',style:TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text(ColorUtil.addressName,style:TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: <Widget>[
                    Text('下单时间',style:TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text(time,style:TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: <Widget>[
                    Text('订单号',style:TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text(orderDetail.orderId,style:TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: <Widget>[
                    Text('备注',style:TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text('实付：￥${orderDetail.orderAmount.toString()}',style:TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItem(int index, OrderDetailList map) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Text(map.productName,style:TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            flex: 6,
            child: Text(
              'x${map.productQuantity.toString()}',textAlign: TextAlign.center,
            ),
          ),
          Text('￥${(map.productPrice*map.productQuantity).toString()}',style:TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
