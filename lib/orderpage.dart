import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dincan/orderlistmodel.dart';
import 'package:flutter_dincan/orderpagedetail.dart';
import 'package:flutter_dincan/toast_utils.dart';
import 'package:flutter_dincan/utils/color.dart';
import 'package:flutter_dincan/utils/noti.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_getuuid/flutter_getuuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'api/Api.dart';
import 'api/service.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<OrderList> data = List();
  @override
  netFetch() async {
    /// 获取手机的UUID
    ColorUtil.uuid = await FlutterGetuuid.platformUid;
    print(ColorUtil.uuid);
    initData(false);
    /// 获取手机的型号如“iPhone7”
  }
  void initState() {
    //添加监听者
    eventBus.on<InitDataInEvent>().listen((event){
      print('进来了通知');
      initData(false);
    });
    netFetch();
    /*rootBundle.loadString('assets/orderlist.json').then((value) {
      OrderListModel shouYeModel = OrderListModel.fromJson(json.decode(value));
      setState(() {
        data = shouYeModel.data;
      });
    });*/
    // TODO: implement initState
    super.initState();
  }
  int page = 0;
  bool isHaveMore = false;
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  initData(bool isLoad){
    getRequest(Api.OrderList+"?openid=${ColorUtil.uuid}&page="+page.toString()+"&size=10").then((val){
      OrderListModel shouYeModel = OrderListModel.fromJson(json.decode(val));
        if(shouYeModel.data.length<10){
          isHaveMore = false;
        }else{
          isHaveMore = true;
        }
        setState(() {
          if(isLoad){
            ToastUtils.showToast("上拉加载完成");
            data.addAll(shouYeModel.data);
          }else{
            data = shouYeModel.data;
            if(data.length==0){
              ToastUtils.showToast("暂无数据");
            }
          }
        });

    });
  }
  @override
  Widget build(BuildContext context) {
    print('jinlaile1');
    return Scaffold(
      backgroundColor: Color(0xffF4F4F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 12.0,
        actions: <Widget>[
          IconButton(icon: Image.asset('images/refresh.png'),
              onPressed: (){
                initData(false);
              })
        ],
        /*leading: IconButton(
          icon: Image.asset('images/back.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setHeight(60),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),*/
        title: Text('订单',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: EasyRefresh(
        child: ListView.builder(
          itemBuilder: (context,index){
            return getListItem(data[index]);
          },
          scrollDirection: Axis.vertical,
          itemCount: data.length,
        ),
        loadMore: () async {
          if(isHaveMore){
            page++;
            await initData(true);
          }else{
            ToastUtils.showToast('没有更多了');
          }

        },
        refreshFooter: ClassicsFooter(
            key:_footerKey,
            bgColor:Colors.white,
            textColor: Colors.blue,
            moreInfoColor: Colors.blue,
            showMore: true,
            noMoreText: '',
            moreInfo: '加载中',
            loadReadyText:'上拉加载....'
        ),
      ),

    );
  }

  Widget getListItem(OrderList data) {
    String createTime = data.createTime.toString()+'000000';
    createTime  = DateTime.fromMicrosecondsSinceEpoch(int.parse(createTime)).toLocal().toString();
    return Container(
      margin: EdgeInsets.fromLTRB(20.0,20,20,10),
      padding: EdgeInsets.fromLTRB(10, ScreenUtil().setHeight(20), 10, ScreenUtil().setHeight(20)),
      height: ScreenUtil().setHeight(320.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white, width: 0.5), // 边色与边宽度
        color: Colors.white, // 底色
        //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
        borderRadius: BorderRadius.circular(10.0), //3像素圆角

      ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return new OrderPageDetail(data.orderId,data.buyerOpenid);
          }));
        },
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Text(ColorUtil.addressName),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text(createTime)
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffE6E6E6),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Text(data.buyerName),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'x1',textAlign: TextAlign.center,
                      ),
                    ),
                    Text('￥${data.orderAmount}')
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffE6E6E6),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Text('合计'),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text('￥${data.orderAmount}')
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffE6E6E6),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Text('取餐码'),
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Text(data.mealCode)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
