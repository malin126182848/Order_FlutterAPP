import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class UserLoggedInEvent {
  String text;
  UserLoggedInEvent(String text){
    this.text = text;
  }
}

class InitDataInEvent {
  String text;
  InitDataInEvent(String text){
    this.text = text;
  }
}
class WeiLingEvent {
  String text;
  WeiLingEvent(String text){
    this.text = text;
  }
}
class DingDanEvent {
  int text;
  DingDanEvent(int text){
    this.text = text;
  }
}