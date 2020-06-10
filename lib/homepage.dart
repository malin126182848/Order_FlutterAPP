import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dincan/shouyemodel.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Data> data = List();
  List<Foods> foods = List();
  var _scrollController = new ScrollController();
  @override
  void initState() {
    rootBundle.loadString('assets/test.json').then((value) {
      ShouYeModel shouYeModel = ShouYeModel.fromJson(json.decode(value));
      setState(() {
        data = shouYeModel.data;
        for(var t in data){
          foods.addAll(t.foods);
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(180),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
              ),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _leftInkWell(index, data[index]);
                  }),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return _goodsItem(context, foods[index], index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _leftInkWell(int index, Data val) {
    bool isClick = false;
    return InkWell(
      onTap: () {
        //val.setClickIndex(index, context);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: const EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 0.8) : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          val.name,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  Widget _goodsItem(context, Foods goodsList, index) {
    return InkWell(
      onTap: () {
        /*Application.router
            .navigateTo(context, '/detail?id=${goodsList[index].goodsId}');*/
        print('点击了');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(goodsList, index),
            Column(
              children: <Widget>[
                _goodsName(goodsList, index),
                _goodsPrice(goodsList, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _goodsImage(Foods goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(goodsList.icon),
    );
  }

  Widget _goodsName(Foods goodsList, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      alignment: Alignment.centerLeft,
      child: Text(
        goodsList.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(26),
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _goodsPrice(Foods goodsList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.only(right: 30.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '价格￥${goodsList.price}',
            style: TextStyle(color: Colors.pink),
          ),
          Text(
            '￥${goodsList.price}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}
