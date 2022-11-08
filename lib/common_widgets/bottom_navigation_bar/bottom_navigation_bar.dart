import 'package:flutter/material.dart';
import 'package:lamp/theme/color_helper.dart';

class Lamp_BottomNavigationItem {
  Lamp_BottomNavigationItem({
    this.page,
    this.icon,
    this.title,
    this.unreadMessagesCount = 0,
  });

  final String? title;
  final Widget? page;
  final String? icon;
  final int unreadMessagesCount;
}

class Lamp_BottomNavigationPage extends StatefulWidget {
  const Lamp_BottomNavigationPage({
    this.selectedItemColor,
    this.unSelectedItemColor = const Color.fromRGBO(227, 233, 239, 1),
    this.items,
    this.widgetKey,
    this.showTitle = false,
    this.logEvent,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBarType = BottomNavigationBarType.fixed,
    this.showTitleFromSide = false,
    this.initialSelection = 0,
  });

  final Color? selectedItemColor;
  final Color? unSelectedItemColor;
  final Color? backgroundColor;
  final List<Lamp_BottomNavigationItem>? items;
  final Key? widgetKey;
  final bool showTitle;
  final bool showTitleFromSide;
  final Function? logEvent;
  final BottomNavigationBarType bottomNavigationBarType;
  final int initialSelection;

  @override
  _Lamp_BottomNavigationPageState createState() => _Lamp_BottomNavigationPageState();
}

class _Lamp_BottomNavigationPageState extends State<Lamp_BottomNavigationPage> {
  late int _selectedIndex = widget.initialSelection;

  void _onItemTapped(int index) {
    if (widget.logEvent != null) {
      widget.logEvent!();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isIconNotEmpty(String? icon) => icon != null && icon.isNotEmpty;

  List<BottomNavigationBarItem>? _getBottomNavigationBarItems() {
    final List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[];
    for (int i = 0; i < widget.items!.length; i++) {
      final BottomNavigationBarItem bottomItem = BottomNavigationBarItem(
          label: widget.showTitle ? widget.items![i].title : '',
          icon: isIconNotEmpty(widget.items![i].icon!)
              ? Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedIndex != i ? Colors.transparent : ColorHelper.lampGreen.color,
                  ),
                  child: Image.asset(widget.items![i].icon!, color: widget.selectedItemColor, width: i == 1 ? 24 : 20))
              : const SizedBox());
      _items.add(bottomItem);
    }
    return _items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.items![_selectedIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: widget.backgroundColor,
        key: widget.widgetKey!,
        items: _getBottomNavigationBarItems()!,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: widget.selectedItemColor,
        unselectedItemColor: widget.unSelectedItemColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
