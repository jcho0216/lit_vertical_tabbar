library lit_vertical_tabbar;

import 'package:flutter/material.dart';
import 'package:lit_vertical_tabbar/lit_element_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class LitVerticalTabBar extends StatefulWidget {
  const LitVerticalTabBar({
    Key? key,
    this.moveTabToLastIndexOnScrollEnd = true,
    this.tabAlignment,
    this.isScrollable = true,
    required this.children,
    this.divider,
    this.physics,
    this.padding,
    this.backgroundColor,
    this.onTabChanged,
  }) : super(key: key);

  /// whether to move the tab to the last one on scroll end
  final bool moveTabToLastIndexOnScrollEnd;

  final TabAlignment? tabAlignment;
  final bool isScrollable;
  final Function(int)? onTabChanged;

  final List<LitElementModel> children;
  final Widget? divider;

  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  final Color? backgroundColor;

  @override
  State<StatefulWidget> createState() => _LitVerticalTabBarState();
}

class _LitVerticalTabBarState extends State<LitVerticalTabBar> with SingleTickerProviderStateMixin {
  late final AutoScrollController _autoScrollController;
  late final TabController _tabController;

  bool _pauseNotification = false;

  final _listViewKey = GlobalKey<_LitVerticalTabBarState>();
  final Map<int, dynamic> _dividerKeys = {};

  @override
  void initState() {
    _autoScrollController = AutoScrollController();
    _tabController = TabController(length: widget.children.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /// get Rect information from GlobalKey
  Rect? _getRectFromKey(GlobalKey<_LitVerticalTabBarState> globalKey) {
    final object = globalKey.currentContext?.findRenderObject();

    final translation = object?.getTransformTo(null).getTranslation();
    final size = object?.semanticBounds.size;

    if (translation != null && size != null) {
      return Rect.fromLTWH(translation.x, translation.y, size.width, size.height);
    } else {
      return null;
    }
  }

  /// get visible items out of rect
  List<int> _getVisibleItemsIndex() {
    Rect? listViewRect = _getRectFromKey(_listViewKey);
    List<int> visibleItems = [];

    if (listViewRect == null) return visibleItems;

    _dividerKeys.forEach((index, key) {
      Rect? dividerRect = _getRectFromKey(key);

      if (dividerRect == null) return;

      /// if the dividers has passed the list view rect onScroll it is considered as "not visible"
      if (listViewRect.top > dividerRect.bottom) return;

      visibleItems.add(index);
    });

    return visibleItems;
  }

  /// handle notification onScroll
  bool _onScrollNotification(ScrollNotification notification) {
    /// ignore horizontal scrolls
    if (notification.metrics.axis == Axis.horizontal) return true;

    if (_pauseNotification) return true;

    final int lastTabIndex = _tabController.length - 1;
    final List<int> visibleItems = _getVisibleItemsIndex();

    final isLast = _autoScrollController.position.pixels >= _autoScrollController.position.maxScrollExtent;

    if (widget.moveTabToLastIndexOnScrollEnd && isLast) {
      _tabController.animateTo(lastTabIndex);
    } else if (visibleItems.isNotEmpty) {
      if (_tabController.index != visibleItems.first) {
        _tabController.animateTo(visibleItems.first);
      }
    }

    return true;
  }

  /// animate to view on TabBar index change
  void onTabChange(int index) async {
    _pauseNotification = true;

    _tabController.animateTo(index);
    await _autoScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);

    _pauseNotification = false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: Column(
        children: [
          TabBar(
            tabAlignment: widget.tabAlignment ?? TabAlignment.start,
            isScrollable: widget.isScrollable,
            controller: _tabController,
            tabs: widget.children.map((e) => Tab(text: e.tabName)).toList(),
            onTap: onTabChange,
          ),
          Expanded(
            child: Container(
              color: widget.backgroundColor,
              child: ListView.separated(
                padding: widget.padding ?? EdgeInsets.zero,
                controller: _autoScrollController,
                physics: widget.physics,
                key: _listViewKey,
                itemBuilder: (context, index) {
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: _autoScrollController,
                    index: index,
                    child: widget.children[index].child,
                  );
                },
                separatorBuilder: (context, index) {
                  _dividerKeys[index] = GlobalKey<_LitVerticalTabBarState>();

                  return SizedBox(
                    key: _dividerKeys[index],
                    child: widget.divider ?? const SizedBox(),
                  );
                },
                itemCount: widget.children.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
