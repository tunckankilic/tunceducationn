import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// TabNavigator, sekme gezinimini ve geçmişini yöneten bir ChangeNotifier sınıfıdır.
class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    // Başlangıç sayfasını _navigationStack'e ekler.
    _navigationStack.add(_initialPage);
  }

  final TabItem _initialPage;

  // Sekme geçmişini saklayan liste.
  final List<TabItem> _navigationStack = [];

  // Şu anki sayfayı döndüren bir getter.
  TabItem get currentPage => _navigationStack.last;

  // Yeni bir sekme sayfasını geçmişe eklemek için kullanılır.
  push(TabItem page) {
    _navigationStack.add(page);
    notifyListeners();
  }

  // Bir önceki sayfayı geçmişten kaldırmak için kullanılır.
  pop() {
    if (_navigationStack.length > 1) _navigationStack.removeLast();
    notifyListeners();
  }

  // Geçmişi başlangıç sayfasına döndürmek için kullanılır.
  popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initialPage);
    notifyListeners();
  }

  // Belirli bir sayfaya kadar geçmişi temizlemek için kullanılır.
  popTo(TabItem page) {
    _navigationStack.remove(page);
    notifyListeners();
  }

  // Belirli bir sayfaya kadar geçmişi temizlemek için kullanılır.
  popUntil(TabItem? page) {
    if (page == null) return popToRoot();
    if (_navigationStack.length > 1) {
      _navigationStack.removeRange(1, _navigationStack.indexOf(page) + 1);
      notifyListeners();
    }
  }

  // Belirli bir sayfaya gitmek ve geçmişi temizlemek için kullanılır.
  pushAndRemoveUntil(TabItem page) {
    _navigationStack
      ..clear()
      ..add(page);
    notifyListeners();
  }
}

// TabNavigator'ın InheritedNotifier sınıfını genişleten bir sınıf.
class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required this.navigator,
    required Widget child,
    Key? key,
  }) : super(notifier: navigator, key: key, child: child);

  final TabNavigator navigator;

  // Belirli bir BuildContext içindeki TabNavigatorProvider'ı bulmak için kullanılır.
  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

// Her bir sekme öğesini temsil eden sınıf.
class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();

  final Widget child;
  final String id;

  @override
  List<dynamic> get props => [id];
}
