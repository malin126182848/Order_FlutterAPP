import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dincan/utils/color.dart';
import 'package:flutter_dincan/utils/noti.dart';
import 'package:flutter_getuuid/flutter_getuuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'category_page.dart';
import 'mypage.dart';
import 'orderpage.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {  var currentIndex = 0;
var currentPage;
//数组存储底部导航栏按钮
final List<BottomNavigationBarItem> bottomTabs = [
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.home),
    title: Text('首页'),
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.shopping_cart),
    title: Text('订单'),
  ),
];
/*BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.profile_circled),
    title: Text('会员中心'),
  ),*/

  //数组存储导航栏对应的路由页面
  final List<Widget> tabBodies = [
    CategoryPage(),
    OrderPage(),
    //MyPage(),
  ];

  //定义目前的下标和对应的页面
//  int _currentIndex = 0;

//  var _currentPage;

  @override
  void initState() {
    eventBus.on<UserLoggedInEvent>().listen((event){
      print('进来了通知');
      setState(() {
        currentIndex = 1;
        currentPage = tabBodies[1];
      });
    });
    super.initState();
    currentPage = tabBodies[currentIndex];
  }
  netFetch() async {
  /// 获取手机的UUID
  ColorUtil.uuid = await FlutterGetuuid.platformUid;
  /// 获取手机的型号如“iPhone7”
}
  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)在这里全局适配
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: bottomTabs,
      onTap: (index) {
        eventBus.fire(new DingDanEvent(index));
        setState(() {
          currentIndex = index;
          currentPage = tabBodies[index];
        });
      },
    ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
