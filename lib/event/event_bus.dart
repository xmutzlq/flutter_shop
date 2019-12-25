import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class GoodsListSortByPriceEvent {
  String priceSortType;
  GoodsListSortByPriceEvent(this.priceSortType);
}

class ArrowIconUpdateEvent {
  bool isUp;
  ArrowIconUpdateEvent(this.isUp);
}

class FilterCommitEvent {
  FilterCommitEvent();
}

class TabBarChangeEvent {
  int index;
  TabBarChangeEvent(this.index);
}

class SpecsChangeEvent {
  SpecsChangeEvent();
}