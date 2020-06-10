import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dincan/shouyemodel.dart';
import 'package:flutter_dincan/sureorderpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*class HomeCategoryPanel extends StatefulWidget {
  Data category;
  HomeCategoryPanel(this.category);
  @override
  _HomeCategoryPanelState createState() => _HomeCategoryPanelState(category);
}

class _HomeCategoryPanelState extends State<HomeCategoryPanel> {
  Data category;
  OverlayState overlayState;
  OverlayEntry _overlayEntry;
  bool isShowCrad = false;
  _HomeCategoryPanelState(this.category);
  @override
  Widget build(BuildContext context) {
    overlayState = Overlay.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Column(
          children: category.foods.map<Widget>((f) {
            return _goodsItem(context,f,1);
          }).toList(),
        )
      ],
    );
  }
  List<MyBotton> myBottoms = [];
  List<String>  strs = ['窝蛋','咸鱼','咸鸭蛋','鸡扒','滑鸡','牛肉','腊味'];
  Widget _goodsItem(context, Foods goodsList, index) {
    return InkWell(
      onTap: () {
        if(isShowCrad){
          print('jinlaile');
          _overlayEntry.remove();
          isShowCrad =false;
        }
        showModalBottomSheet<void>(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            builder: (BuildContext context) {
              List<Widget> list = [];
              for(var s in strs){
                MyBotton myBotton = new MyBotton(
                    new Items(s)
                );
                list.add(myBotton);
                myBottoms.add(myBotton);
              }
              return Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _goodsItem1(context, goodsList, index),
                    SizedBox(height: 10,),
                    Text('其他'),
                    MyBotton(Items('打包')),
                    Text('加料'),
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: list,
                      spacing: 8.0,
                      runSpacing: 4.0,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: ScreenUtil().setWidth(750),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                            side: BorderSide(color: Colors.red)
                        ),
                        color: Colors.green,
                        elevation:0,
                        highlightElevation:0,
                        disabledElevation:0,
                        onPressed: (){
                          *//*Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return new SureOrderPage();
                          }));*//*
                          showCard();
                          Navigator.pop(context);
                        },
                        child: Text('加入购物车'),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              );
            });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _goodsImage(goodsList, index),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  _goodsName(goodsList, index),
                  Text('月销量:222',style: TextStyle(fontSize: 10),),
                  _goodsPrice(goodsList, index),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _goodsItem1(context, Foods goodsList, index) {
    return InkWell(
      onTap: () {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _goodsImage(goodsList, index),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  _goodsName(goodsList, index),
                  Text('月销量:222',style: TextStyle(fontSize: 10),),
                  _goodsPrice(goodsList, index),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
  Widget _goodsImage(Foods goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(180),
      height: ScreenUtil().setHeight(180),
      child: Image.network(goodsList.icon,fit: BoxFit.fill,),
    );
  }

  Widget _goodsName(Foods goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      alignment: Alignment.centerLeft,
      child: Text(
        goodsList.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _goodsPrice(Foods goodsList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '￥${goodsList.price}',
            style: TextStyle(color: Colors.pink),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: new BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Text('选规格',textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15)),
          ),
        ],
      ),
    );
  }

  void showCard() {
    if(_overlayEntry==null){
      _overlayEntry = OverlayEntry(builder:(BuildContext context){
        return new Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            right: 20,
            left: 20,
            height: 80,
            child: new SafeArea(
                child: new Material(
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Color(0xff343940),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: new Row(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text('￥48',style: TextStyle(color: Colors.white),),
                        Expanded(
                          flex: 4,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.green,
                            alignment: Alignment.center,
                            child: Text('选好了'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
      });
    }
    isShowCrad  = true;
    overlayState.insert(_overlayEntry);
  }
}*/

class HomeCategoryPanel extends StatelessWidget {
  Data category;
  OverlayState overlayState;
  OverlayEntry _overlayEntry;
  bool isShowCrad = false;
  HomeCategoryPanel(this.category);
  @override
  Widget build(BuildContext context) {
    overlayState = Overlay.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Column(
          children: category.foods.map<Widget>((f) {
            return _goodsItem(context,f,1);
          }).toList(),
        )
      ],
    );
  }
  List<MyBotton> myBottoms = [];
  List<String>  strs = ['窝蛋','咸鱼','咸鸭蛋','鸡扒','滑鸡','牛肉','腊味'];
  Widget _goodsItem(context, Foods goodsList, index) {
    return InkWell(
      onTap: () {
        if(isShowCrad){
          print('jinlaile');
          isShowCrad = false;
          _overlayEntry.remove();
        }
        showModalBottomSheet<void>(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            builder: (BuildContext context) {
              List<Widget> list = [];
              for(var s in strs){
                MyBotton myBotton = new MyBotton(
                    new Items(s)
                );
                list.add(myBotton);
                myBottoms.add(myBotton);
              }
              return Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _goodsItem1(context, goodsList, index),
                    SizedBox(height: 10,),
                    Text('其他'),
                    MyBotton(Items('打包')),
                    Text('加料'),
                    Wrap(
                        alignment: WrapAlignment.start,
                        children: list,
                        spacing: 8.0,
                        runSpacing: 4.0,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: ScreenUtil().setWidth(750),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                            side: BorderSide(color: Colors.red)
                        ),
                        color: Colors.green,
                        elevation:0,
                        highlightElevation:0,
                        disabledElevation:0,
                        onPressed: (){
                         /* Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return new SureOrderPage();
                          }));*/
                          showCard();
                          Navigator.pop(context);
                        },
                        child: Text('加入购物车'),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              );
            });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _goodsImage(goodsList, index),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  _goodsName(goodsList, index),
                  Text('月销量:222',style: TextStyle(fontSize: 10),),
                  _goodsPrice(goodsList, index),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _goodsItem1(context, Foods goodsList, index) {
    return InkWell(
      onTap: () {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _goodsImage(goodsList, index),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  _goodsName(goodsList, index),
                  Text('月销量:222',style: TextStyle(fontSize: 10),),
                  _goodsPrice(goodsList, index),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
  Widget _goodsImage(Foods goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(180),
      height: ScreenUtil().setHeight(180),
      child: Image.network(goodsList.icon,fit: BoxFit.fill,),
    );
  }

  Widget _goodsName(Foods goodsList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      alignment: Alignment.centerLeft,
      child: Text(
        goodsList.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _goodsPrice(Foods goodsList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '￥${goodsList.price}',
            style: TextStyle(color: Colors.pink),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: new BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Text('选规格',textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15)),
          ),
        ],
      ),
    );
  }

  void showCard() {
    if(_overlayEntry==null){
      _overlayEntry = OverlayEntry(builder:(BuildContext context){
        return new Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            right: 20,
            left: 20,
            height: 80,
            child: new SafeArea(
                child: new Material(
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Color(0xff343940),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: new Row(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text('￥48',style: TextStyle(color: Colors.white),),
                        Expanded(
                          flex: 4,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.green,
                            alignment: Alignment.center,
                            child: Text('选好了'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
      });
    }
    isShowCrad = true;
    overlayState.insert(_overlayEntry);
  }
  /*Widget typePanel(Foods f) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  f.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('更多'),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          height: 0.55,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[100],
                width: 0.55,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          //垂直子Widget之间间距
          mainAxisSpacing: 10.0,
          //一行的 Widget 数量
          crossAxisCount: 3,
          //子Widget宽高比例
          childAspectRatio: 0.8,
          //GridView内边距
          padding: EdgeInsets.all(10.0),
          children: f['sunTypes'].map<Widget>((item) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  width: 60.0,
                  height: 60.0,
                  imageUrl: item['image'],
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  item['name'],
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }*/
}


class MyBotton extends StatefulWidget {
  Items item;
  _MyBottonState state;


  MyBotton(this.item);

  @override
  _MyBottonState createState(){
    _MyBottonState st =  _MyBottonState(item);
    state = st;
    return st;
  }
}

class _MyBottonState extends State<MyBotton> {
  Items item;


  _MyBottonState(this.item);
  bool getSelect(){
    return item.select;
  }
  setSelect(bool isShow){
    setState(() {
      item.select = isShow;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(160),
      child: RaisedButton(
        child: Text(item.name),
        color: item.select?Colors.blue:Color(0xffF4F4F4),
        onPressed: (){
          /*if(isSelect){
              state.selectStr.remove(text);
            }else{
              state.selectStr.add(text);
            }
             state.getList();
             */
          setState(() {
            item.select = !item.select;
          });
        },
      ),
    );
  }
}

class Items {
  String name;
  String id;
  int type;
  bool select = false;


  Items(this.name);

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
