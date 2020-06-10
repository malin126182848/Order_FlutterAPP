import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dincan/api/Api.dart';
import 'package:flutter_dincan/shouyemodel.dart';
import 'package:flutter_dincan/sureorderpage.dart';
import 'package:flutter_dincan/toast_utils.dart';
import 'package:flutter_dincan/utils/color.dart';
import 'package:flutter_dincan/utils/noti.dart';
import 'package:flutter_getuuid/flutter_getuuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/service.dart';
import 'home_category_panel.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Timer _timer;
  bool _isSelectedTimeOut = true;
  ScrollController _scrollController = ScrollController();
  AutoScrollController _controller = AutoScrollController();
  var _keys = {};
  List<Data> _categorys = List();
  Map<String,List<Foods>> gouwuche = Map();
  Data _selectedCategory;
  List<Widget> list = [];
  Items qitaItem = Items('打包');
  List<Items> items = List();
  /*@override
  void deactivate() {
    if(ColorUtil.isZhiFu&&!ColorUtil.zhiFuSuccess){
      showCard();
      ColorUtil.isZhiFu = false;
    }
    // TODO: implement deactivate
    super.deactivate();
  }*/


//定义一个跳转到目标界面的“内部”方法，使用异步请求的方式（等数据传递回来之后，再显示传递的数据）
  _navigateToXiaoJieJie(BuildContext context) async{
    final result=await Navigator.push(context, MaterialPageRoute(//等待数据传回来
        builder: (context)=>SureOrderPage()
    ));
    if(!ColorUtil.zhiFuSuccess){
      showCard();
      ColorUtil.isZhiFu = false;
    }else{
      setState(() {
        gouwuche = Map();
      });
    }
  }
  SharedPreferences prefs;
  _getState() async {
    prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('name');
    if(username!=null&&username!=''){
      setState(() {
        ColorUtil.addressName = username;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _getState();
    eventBus.on<WeiLingEvent>().listen((event){
      Navigator.pop(context);
      _simpleDialog();
    });
    eventBus.on<DingDanEvent>().listen((event){
      if(event.text==1){
        if(isShowCrad){
          isShowCrad = false;
          _overlayEntry.remove();
        }
      }else{
        if(gouwuche_zongjia>0){
          showCard();
        }
      }
    });
    myBottoms = List();
    for(var s in strs){
      Items it =  new Items(s);
      MyBotton myBotton = new MyBotton(
          it
      );
      items.add(it);
      list.add(myBotton);
      myBottoms.add(myBotton);
    }
    overlayState = Overlay.of(context);
    getRequest(Api.ListUrl).then((val){
      ShouYeModel shouYeModel = ShouYeModel.fromJson(json.decode(val));
      setState(() {
        _categorys = shouYeModel.data;
        _selectedCategory = _categorys[0];
         /*for(var t in data){
          foods.addAll(t.foods);
        }*/
      });
    });
    /*rootBundle.loadString('assets/test.json').then((value) {
      ShouYeModel shouYeModel = ShouYeModel.fromJson(json.decode(value));
      setState(() {
        _categorys = shouYeModel.data;
        _selectedCategory = _categorys[0];
      });
    });*/
    /*setState(() {
      _categorys = categorys;
      _selectedCategory = _categorys[0];
    });*/
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  String barcode = '';
  Future _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
      var code = json.decode(barcode);
      setState(() {
        try{
          ColorUtil.address = code['address'];
          ColorUtil.addressName = code['name'];
          prefs.setString('name', ColorUtil.addressName);
          return this.barcode = code['address'];
        }catch(e){

        }

      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          return this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          return this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() => this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false, //设置没有返回按钮
        titleSpacing: 12.0,
        title: Text(ColorUtil.addressName,style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          IconButton(icon: Image.asset('images/erweima.png'),
              onPressed: (){
                  _scan();
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(Icons.school),
              Text('桌位号：'+ColorUtil.address),
              Expanded(
                flex: 6,
                child: Container(),
              ),
              Icon(Icons.school),
              Text('店内点单'),
              SizedBox(width: 10,),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: ListView(
                    shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    controller: _scrollController,
                    children: _leftListViewItems(),
                  ),
                ),
                Expanded(
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        List widgetIndexs = [];
                        _keys.forEach((index, key) {
                          var itemRect = getRectFromKey(index, key);

                          if (itemRect != null &&
                              itemRect['offsetY'] > itemRect['height']) {
                            widgetIndexs.add(itemRect);
                          }
                        });

                        if (widgetIndexs.length > 0) {
                          int widgetIndex = widgetIndexs[0]['index'];
                          if ((widgetIndexs[0]['offsetY'] - widgetIndexs[0]['height']) >
                              height / 2.2) {
                            widgetIndex -= 1;
                          }
                          if (widgetIndex != _selectedCategory.type) {
                            _leftAnimateToIndex(widgetIndex);
                          }
                        }

                        return true;
                      },
                      child: ListView(
                        shrinkWrap: true,
                        cacheExtent: height * 3,
                        controller: _controller,
                        // physics: ClampingScrollPhysics(),
                        children: _categorys.map<Widget>((f) {
                          _keys[f.type] = new GlobalKey();
                          return AutoScrollTag(
                            key: ValueKey(f.type),
                            controller: _controller,
                            index: f.type,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: getXiao(f),
                              key: _keys[f.type],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  _leftAnimateToIndex(int index) {
    if (_selectedCategory.type != index && _isSelectedTimeOut) {
      setState(() {
        _selectedCategory = _categorys[index];
      });
      _scrollController.position.moveTo(index * 50.0 - 50.0);
    }
  }

  _rightAnimateToIndex(Data f) {
    setState(() {
      _isSelectedTimeOut = false;
      _selectedCategory = f;
    });
    _controller.scrollToIndex(f.type,
        duration: Duration(milliseconds: 200),
        preferPosition: AutoScrollPosition.begin);

    _timer = Timer(Duration(milliseconds: 2000), () {
      setState(() {
        _isSelectedTimeOut = true;
      });
    });
  }

  getRectFromKey(int index, GlobalKey globalKey) {
    RenderBox renderBox = globalKey?.currentContext?.findRenderObject();

    if (renderBox != null) {
      var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
      return {
        'index': index,
        'height': renderBox.size.height,
        'offsetX': offset.dx,
        'offsetY': offset.dy
      };
    } else {
      return null;
    }
  }



  List<Widget> _leftListViewItems() {
    return _categorys.map((f) {
      return GestureDetector(
        child: Container(
          color: f.type == _selectedCategory.type
              ? Colors.white
              : Colors.transparent,
          height: 50.0,
          child: Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 25.0,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: f.type == _selectedCategory.type
                      ? ColorUtil.getColor('primary')
                      : Colors.transparent,
                  width: 4.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Text(
              f.name,
              style: TextStyle(
                color: f.type == _selectedCategory.type
                    ? ColorUtil.getColor('primary')
                    : null,
                fontSize:
                    f.type == _selectedCategory.type ? 14.0 : 12.0,
                fontWeight: f.type== _selectedCategory.type
                    ? FontWeight.w600
                    : null,
              ),
            ),
          ),
        ),
        onTap: () {
          _rightAnimateToIndex(f);
        },
      );
    }).toList();
  }


  Widget getXiao(Data category){
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
  OverlayState overlayState;
  OverlayEntry _overlayEntry;
  bool isShowCrad = false;
  List<MyBotton> myBottoms = [];
  List<String>  strs = ['窝蛋','咸鱼','咸鸭蛋','鸡扒','滑鸡','牛肉','腊味'];
  Widget _goodsItem(context, Foods goodsList, index) {
    return InkWell(
      onTap: () {
        if(isShowCrad){
          isShowCrad = false;
          _overlayEntry.remove();
        }
        _modelBottomSheet(goodsList);
 /*       showModalBottomSheet<void>(
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
                          if(gouwuche.containsKey(goodsList.id)){
                            gouwuche[goodsList.id].add(goodsList);
                          }else{
                            List<Foods> l1 = List();
                            l1.add(goodsList);
                            gouwuche[goodsList.id] = l1;
                          }

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
            });*/
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
                  //Text('月销量:222',style: TextStyle(fontSize: 10),),
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
                  //Text('月销量:${goodsList.sales}',style: TextStyle(fontSize: 10),),
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
  int gouwuche_totol = 0;
  double gouwuche_zongjia = 0;
  void showCard() {
    int totol = 0;
    double zongjia = 0;
    for(var s in gouwuche.keys){
      totol = totol+gouwuche[s].length;
      if(gouwuche[s].length!=0){
        zongjia = zongjia+(gouwuche[s].length*gouwuche[s][0].price);
      }
    }
    setState(() {
      gouwuche_totol = totol;
      gouwuche_zongjia = zongjia;
    });
    if(_overlayEntry==null){
      _overlayEntry = OverlayEntry(builder:(BuildContext context){
        return new Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            right: 20,
            left: 20,
            height: 80,
            child: new SafeArea(
                child: new Material(
                  child: InkWell(
                    onTap: (){
                      if(!isShow){
                        _simpleDialog();
                      }
                    },
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Color(0xff343940),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: new Row(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          Stack(
                            alignment: Alignment(0.7,-0.7),
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                decoration: new BoxDecoration(
                                  border: new Border.all(color: Color(0xFFFFFF00), width: 0.5), // 边色与边宽度
                                  color: Color(0xFF9E9E9E), // 底色
// shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                                  shape: BoxShape.circle, // 默认值也是矩形
                                  //borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                                ),
                                child: Icon(Icons.shopping_cart),
                              ),
                              Positioned(
                                right: 2,
                                top: 3,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  decoration: new BoxDecoration(
                                    border: new Border.all(color: Color(0xFFFFFF00), width: 0.5), // 边色与边宽度
                                    color: Color(0xFF9E9E9E), // 底色
// shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                                    shape: BoxShape.circle, // 默认值也是矩形
                                    //borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                                  ),
                                  child: Text(gouwuche_totol.toString()),
                                )
                              )

                            ],
                          ),
                          SizedBox(width: 10,),
                          Text('￥${gouwuche_zongjia.toString()}',style: TextStyle(color: Colors.white),),
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                              ),

                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: (){
                                  if(isShow){
                                    Navigator.pop(context);
                                    return;
                                  }
                                  if(gouwuche_zongjia==0){
                                    ToastUtils.showToast("还未选择商品");
                                    return;
                                  }
                                  if(ColorUtil.address==''){
                                    ToastUtils.showToast("还未扫码选择座位号");
                                    return;
                                  }
                                  if(isShow){
                                    Navigator.pop(context);
                                  }
                                  _overlayEntry.remove();
                                  isShowCrad = false;
                                  ColorUtil.map = gouwuche;
                                  ColorUtil.total = gouwuche_zongjia;
                                  ColorUtil.zhiFuSuccess = false;
                                  ColorUtil.isZhiFu = true;
                                  _navigateToXiaoJieJie(context);
                                  /*Navigator.push(context, MaterialPageRoute(builder: (_) {
                                    return new SureOrderPage();
                                  }));*/
                                },
                                child: Text('选好了'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
      });
    }
    isShowCrad = true;
    overlayState.insert(_overlayEntry);
  }

  bool isShow = false;
  _simpleDialog() async{
    var result = await showDialog(
        context: context,
        builder: (context){
          isShow = true;
          return SimpleDialog(
              title: Row(
                children: <Widget>[
                  SizedBox(width: 6,),
                  Text('购物车'),
                  Expanded(flex: 2,child: SizedBox(),),
                  InkWell(
                    onTap: (){
                      setState(() {
                        gouwuche = new Map();
                      });
                      Navigator.pop(context);
                    },
                    child: Text('清空购物车'),
                  ),
                  SizedBox(width: 6,),
                ],
              ),
            children: getv1(),
          );
        }
    );
    isShow = false;
    int totol = 0;
    double zongjia = 0;
    for(var s in gouwuche.keys){
      totol = totol+gouwuche[s].length;
      if(gouwuche[s].length!=0){
        zongjia = zongjia+(gouwuche[s].length*gouwuche[s][0].price);
      }
    }
    setState(() {
      gouwuche_totol = totol;
      gouwuche_zongjia = zongjia;
    });
  }
  List<Widget> getv1(){
    List<Widget>  wt1 = List();
    for(var s in gouwuche.keys){
      if(gouwuche[s].length!=0){
        Widget w = DialogItem(gouwuche[s]);
        wt1.add(w);
        wt1.add(Divider());
      }
    }
    return wt1;
  }
  _modelBottomSheet(Foods goodsList) async{
    var result = await showModalBottomSheet(
        context: context,
        builder: (context){
          qitaItem.select = false;
          for(var s in myBottoms){
            s.item.select = false;
          }
          return Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            margin: EdgeInsets.only(left: 10,right: 10,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _goodsItem1(context, goodsList, 0),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    /*if(gouwuche.containsKey(goodsList.id)){
                      gouwuche[goodsList.id].add(goodsList);
                    }else{
                      List<Foods> l1 = List();
                      l1.add(goodsList);
                      gouwuche[goodsList.id] = l1;
                    }

                    showCard();
                    Navigator.pop(context);*/
                  },
                  child: Text('其他'),
                ),
                //Text('其他'),
                MyBotton(qitaItem),
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
                      ColorUtil.phone = '';
                      if(gouwuche.containsKey(goodsList.id)){
                        gouwuche[goodsList.id].add(goodsList);
                      }else{
                        List<Foods> l1 = List();
                        l1.add(goodsList);
                        gouwuche[goodsList.id] = l1;
                      }
                      if(qitaItem.select){
                        ColorUtil.userName = '打包';
                      }
                      for(var b in items){
                        if(b.select){
                          ColorUtil.phone=ColorUtil.phone+b.name+'|';
                        }
                      }
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
        }
    );

    if(!isShowCrad&&gouwuche.keys.toList().length>0){
      showCard();
    }
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}


class DialogItem extends StatefulWidget {
  List<Foods> foods1;

  DialogItem(this.foods1);

  @override
  _DialogItemState createState() => _DialogItemState(foods1);
}

class _DialogItemState extends State<DialogItem> {
  List<Foods> foods1;
  _DialogItemState(this.foods1);
  String name = '';
  double prices ;
  Foods foods;
  @override
  void initState() {
    setState(() {
      name= foods1[0].name;
      prices = foods1[0].price;
      foods = foods1[0];
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 10,),
        Text(name),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Text((prices*foods1.length).toString()),
        SizedBox(width: 15,),
        InkWell(
          onTap: (){
            if(foods1.length==0){
            }else{
              setState(() {
                foods1.removeLast();
                if(foods1.length==0){
                  eventBus.fire(new WeiLingEvent('aa'));
                }
              });
            }

          },
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.black, width: 0.5), // 边色与边宽度
              color: Colors.white, // 底色
// shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
              shape: BoxShape.circle, // 默认值也是矩形
              //borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            ),
            child: Text('-'),
          ),
        ),
        SizedBox(width: 5,),
        Text(foods1.length.toString()),
        SizedBox(width: 5,),
        InkWell(
          onTap: (){
            setState(() {
              foods1.add(foods);
            });
          },
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              border: new Border.all(color: Color(0xFFFFFF00), width: 0.5), // 边色与边宽度
              color: Colors.green, // 底色
// shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
              shape: BoxShape.circle, // 默认值也是矩形
              //borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            ),
            child: Text('+'),
          ),
        ),
        SizedBox(width: 5,),
      ],
    );
  }
}

