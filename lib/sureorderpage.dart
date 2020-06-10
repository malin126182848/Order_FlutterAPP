import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dincan/api/Api.dart';
import 'package:flutter_dincan/api/service.dart';
import 'package:flutter_dincan/shouyemodel.dart';
import 'package:flutter_dincan/toast_utils.dart';
import 'package:flutter_dincan/utils/color.dart';
import 'package:flutter_dincan/utils/noti.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SureOrderPage extends StatefulWidget {
  @override
  _SureOrderPageState createState() => _SureOrderPageState();
}

class _SureOrderPageState extends State<SureOrderPage> {
  int groupValue=1;
  int groupCouponValue=0;
  void updateGroupValue(int v){
    setState(() {
      groupValue=v;
    });
  }
  void updateCouponValue(int v){
    setState(() {
      groupCouponValue=v;
    });
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
        title: Text('提交订单',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0,10,0,10),
                    padding: EdgeInsets.fromLTRB(10, ScreenUtil().setHeight(20), 10, ScreenUtil().setHeight(20)),
                    height: ScreenUtil().setHeight(220.0),
                    decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.white, width: 0.5), // 边色与边宽度
                      color: Colors.white, // 底色
                      //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                      borderRadius: BorderRadius.circular(10.0), //3像素圆角

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Text('就餐方式',style:TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                  flex: 6,
                                  child: Container(),
                                ),
                                Text('店内用餐',style:TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Text('备注',style:TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: '请输入您的口味要求',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                            itemCount: ColorUtil.map.keys.toList().length,
                            itemBuilder: (context, index) {
                              return _listItem(index, ColorUtil.map[ColorUtil.map.keys.toList()[index]]);
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
                              Text('总计：￥${ColorUtil.total.toString()}',style:TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,

                    ),
                    child: ListTile(
                      title: Text(
                        '支付方式',
                        textAlign: TextAlign.left,
                        style:TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: ScreenUtil().setWidth(50),),
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Color(0xffCCCCCC)
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20),),
                        Text('微信',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Expanded(
                          flex: 4,
                          child: Text('',textAlign: TextAlign.right,),
                        ),
                        Expanded(
                          flex: 1,
                          child: Radio(
                              value: 2,
                              groupValue: groupValue,//当value和groupValue一致的时候则选中
                              activeColor: Colors.red,
                              onChanged: (T){
                                updateGroupValue(T);
                              }
                          ),
                        )

                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: ScreenUtil().setWidth(50),),
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Color(0xffCCCCCC)
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20),),
                        Text('会员卡(余额：￥0)',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Expanded(
                          flex: 4,
                          child: Text('',textAlign: TextAlign.right,),
                        ),
                        Expanded(
                          flex: 1,
                          child: Radio(
                              value: 3,
                              groupValue: groupValue,//当value和groupValue一致的时候则选中
                              activeColor: Colors.red,
                              onChanged: (T){
                                updateGroupValue(T);
                              }
                          ),
                        )

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text('找回已有会员卡'),
                  )
                ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 5,),
                  Text('付款'),
                  Expanded(
                    flex: 5,
                    child: Container(),
                  ),
                  Text('￥${ColorUtil.total}'),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      List<Map<String,Object>> list = List();
                      for(var s in ColorUtil.map.keys){
                        Map<String,Object> m = {
                          "productId": ColorUtil.map[s][0].id,
                          "productQuantity": ColorUtil.map[s].length //购买数量
                        };
                        list.add(m);
                      }
                      print('name:'+ColorUtil.userName);
                      print('name1:'+ColorUtil.phone);
                      if(ColorUtil.userName==''){
                        ColorUtil.userName = '店内吃';
                      }
                      if(ColorUtil.phone==''){
                        ColorUtil.phone = '18876437651';
                      }
                      Map<String,String> map = {
                        "name": ColorUtil.userName,
                        "phone": ColorUtil.phone,
                        "address": ColorUtil.address,//座位号，0表示外带
                        "openid": ColorUtil.uuid ,//uuid号，首次启动app生成
                        "items":list.toString()
                      };
                      print(map.toString());
                      post1(Api.SureOrder,params: map).then((val){
                        print(val);
                        var result = json.decode(val);
                        print(result['msg']);
                        if(result['code']==0){
                          ToastUtils.showToast('成功');
                          ColorUtil.zhiFuSuccess = true;
                          eventBus.fire(new UserLoggedInEvent('ss'));
                          eventBus.fire(new InitDataInEvent('ss'));
                          Navigator.pop(context);
                        }else{
                          ToastUtils.showToast('失败');
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      alignment: Alignment.center,
                      color: Colors.green,
                      child: Text('确认支付'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listItem(int index, List<Foods> map) {
    if(map.length==0){
      return SizedBox();
    }
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Text(map[0].name,style:TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            flex: 6,
            child: Text(
              'x${map.length.toString()}',textAlign: TextAlign.center,
            ),
          ),
          Text('￥${(map[0].price*map.length).toString()}',style:TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
