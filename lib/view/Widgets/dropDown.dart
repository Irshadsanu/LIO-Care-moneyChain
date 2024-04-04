library awesome_dropdown;

// import 'package:awesome_dropdown/src/custom_scrollbar.dart';
// import 'package:awesome_dropdown/src/remove_over_scroll.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../constants/my_colors.dart';

class AwesomeDropDown extends StatefulWidget {
  /// background [Color] of dropdown, icon, and overLay,
  final Color dropDownBGColor, dropDownIconBGColor, dropDownOverlayBGColor;

  /// this radius will be used to set the border of drop down
  final double dropDownBorderRadius;

  /// user can set any Icon or Image here because it accept any widget
  final Widget dropDownIcon;

  /// The list of items the user can select
  /// If the list of items is null then an empty list will be shown
  final List<String> dropDownList;

  /// this variable is used to close the drop down is user touch outside or by back pressed
  bool isBackPressedOrTouchedOutSide;

  /// this func is used to maintain the open and close state of drop down
  Function? dropStateChanged;

  /// this func is used for select any item from the list
  Function? onDropDownItemClick;

  /// this radius is used to custom the top borders of drop down
  /// user can set drop down style as Rectangular, Oval, Rounded Borders and any other
  /// it helps user to make customize design of drop down
  double dropDownTopBorderRadius;

  /// this radius is used to custom the bottom borders of drop down
  /// user can set drop down style as Rectangular, Oval, Rounded Borders and any other
  /// it helps user to make customize design of drop down
  double dropDownBottomBorderRadius;

  /// thi variable is used to detect panDown event of scaffold body
  bool isPanDown;

  /// user can provide any elevation as per his choice
  double elevation;

  /// A placeholder text that is displayed by the dropdown
  ///
  /// If the [hint] is null
  /// this will displayed the First index of List
  String selectedItem;

  /// TextStyle for the hint.
  TextStyle selectedItemTextStyle;

  ///TextStyle for the value of list in drop down.
  TextStyle dropDownListTextStyle;
  double padding;

  /// user can define how many items of list would be shown when drop down opens, by default we set it's value to '4'
  int numOfListItemToShow;

  AwesomeDropDown({
    required this.dropDownList,
    this.isPanDown: false,
    this.dropDownBGColor: Colors.white,
    this.dropDownIconBGColor: Colors.transparent,
    this.dropDownOverlayBGColor: Colors.white,
    this.dropDownBorderRadius: 0,
    this.dropDownIcon: const Icon(Icons.arrow_drop_down),
    this.onDropDownItemClick,
    this.isBackPressedOrTouchedOutSide: false,
    this.dropStateChanged,
    this.dropDownBottomBorderRadius: 50,
    this.dropDownTopBorderRadius: 50,
    this.selectedItem: '',
    this.selectedItemTextStyle: const TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
    this.dropDownListTextStyle: const TextStyle(
        color: Colors.grey, fontSize: 15, backgroundColor: Colors.transparent),
    this.elevation: 0,
    this.padding: 8,
    this.numOfListItemToShow: 4,
  });

  @override
  _AwesomeDropDownState createState() {
    return _AwesomeDropDownState();
  }
}

class _AwesomeDropDownState extends State<AwesomeDropDown>
    with WidgetsBindingObserver {
  late GlobalKey _gestureDetectorGlobalKey;
  double _gestureDetectorHeight = 0.0,
      _gestureDetectorWidth = 0.0,
      _gestureDetectorXPosition = 0.0,
      _gestureDetectorYPosition = 0.0;
  static OverlayEntry? _floatingDropdown;
  bool _isDropdownOpened = false, _isFirstTime = true;
  double _listItemHeight = 0.0;
  double initialTopBorderRadius = 30.0;
  double initialBottomBorderRadius = 30.0;

  @override
  void initState() {
    _gestureDetectorGlobalKey = GlobalKey();
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isBackPressedOrTouchedOutSide != null &&
        widget.isBackPressedOrTouchedOutSide &&
        _isDropdownOpened) {
      _openAndCloseDrawer();
      widget.isBackPressedOrTouchedOutSide = false;
    }
    if (widget.isPanDown) {
      Future.delayed(const Duration(milliseconds: 100), () {
        widget.isPanDown = false;
      });
    }

    /// we don't want to restrict user to wrap his scaffold by [WillPopScope] so we wrap our custom widget by it
    return WillPopScope(
      onWillPop: () {
        if (_isDropdownOpened) {
          setState(() {});
          _openAndCloseDrawer();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: GestureDetector(
        key: _gestureDetectorGlobalKey,
        onTap: () {
          if (_isFirstTime || (widget.isPanDown != null && !widget.isPanDown)) {
            setState(() {
              if (widget.isPanDown) {
                widget.isPanDown = false;
              }
              _isFirstTime = false;
              _openAndCloseDrawer();
            });
          } else {
            widget.isPanDown = false;
          }
        },
        child: Card(
          elevation: widget.elevation,
          color: widget.dropDownBGColor,
          margin: const EdgeInsets.only(
              top: 10.0, left: 5.0, right: 5.0, bottom: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.dropDownTopBorderRadius),
              topRight: Radius.circular(widget.dropDownTopBorderRadius),
              bottomRight: Radius.circular(widget.dropDownBottomBorderRadius),
              bottomLeft: Radius.circular(widget.dropDownBottomBorderRadius),
            ),
          ),
          child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            padding: EdgeInsets.all(widget.padding),
            height: 50,
            child: Row(
              children: <Widget>[
                widget.selectedItem == "Google Pay"
                    ? CircleAvatar(
                        backgroundColor: clF3F3F3,
                        child: Center(
                          child: Image.asset("assets/google-pay.png"),
                        ),
                      )
                    :  widget.selectedItem == "Paytm"?CircleAvatar(
                  backgroundColor: clF3F3F3,
                  child: Center(
                    child: Image.asset("assets/Group-Copy.png"),
                  ),
                ):widget.selectedItem == "UPI Transaction"?CircleAvatar(
                  backgroundColor: clF3F3F3,
                  child: Center(
                    child: Image.asset("assets/bharat-interface-for-money-bhim-logo-vector 1.png"),
                  ),
                ):const SizedBox(),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.selectedItem == ''
                          ? widget.dropDownList[0]
                          : widget.selectedItem,
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor > 1.5
                              ? 1.5
                              : MediaQuery.of(context).textScaleFactor,
                      style: widget.selectedItem == ''?TextStyle(color:cl5F5F5F.withOpacity(.7),fontSize: 17):widget.selectedItemTextStyle,
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      color: (widget.dropDownIconBGColor != null)
                          ? widget.dropDownIconBGColor
                          : Colors.transparent,
                      child: widget.dropDownIcon,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeTextScaleFactor() {
    if (_isDropdownOpened) {
      _openAndCloseDrawer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void findDropdownData() {
    RenderBox renderBox = _gestureDetectorGlobalKey.currentContext!
        .findRenderObject() as RenderBox;
    _gestureDetectorHeight = renderBox.size.height;
    _gestureDetectorWidth = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    _gestureDetectorXPosition = offset.dx;
    _gestureDetectorYPosition = offset.dy;
  }

  /// Create the floating dropdown overlay
  OverlayEntry _createFloatingDropdown(int numOfListItemToShow) {
    int numOfListItem = numOfListItemToShow != null &&
            numOfListItemToShow <= 10 &&
            numOfListItemToShow <= widget.dropDownList.length
        ? numOfListItemToShow
        : 4;
    double overlayHeight = _listItemHeight * widget.dropDownList.length + 15,
        fourItemsHeight = numOfListItem * _listItemHeight + 15;
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: _gestureDetectorXPosition * 1.05,
        width: _gestureDetectorWidth * 0.990,
        top: _gestureDetectorYPosition + _gestureDetectorHeight,
        height: (_listItemHeight == 0.0)
            ? 0.1
            : (overlayHeight > fourItemsHeight)
                ? fourItemsHeight + MediaQuery.of(context).padding.top
                : overlayHeight + MediaQuery.of(context).padding.top,
        child: Container(
          margin: const EdgeInsets.only(left: 4.0, right: 3.0, bottom: 10.0),
          transform: Matrix4.translationValues(
              0, -MediaQuery.of(context).padding.top, 0),
          child: SafeArea(
            child: DropDownOverlay(
              itemHeight: _gestureDetectorHeight,
              dropDownList:
                  (widget.dropDownList != null) ? widget.dropDownList : [],
              overlayBGColor: (widget.dropDownOverlayBGColor != null)
                  ? widget.dropDownOverlayBGColor
                  : widget.dropDownBGColor,
              dropDownItemClick: _dropDownItemClickListener,
              dropDownBorderRadius: widget.dropDownBottomBorderRadius,
              dropDownListTextStyle: widget.dropDownListTextStyle,
              onOverlayOpen: (listItemHeight) {
                setState(() {
                  if (listItemHeight != null &&
                      listItemHeight > 0 &&
                      _listItemHeight != listItemHeight) {
                    _listItemHeight = listItemHeight;
                    _openAndCloseDrawer();
                    _openAndCloseDrawer();
                  }
                });
              },
            ),
          ),
        ),
      );
    });
  }

  /// it flip flop the open and close state
  void _openAndCloseDrawer() {
    if (_isDropdownOpened) {
      _floatingDropdown!.remove();
      _dropDownStateChanged(false);
      widget.dropDownBottomBorderRadius = initialBottomBorderRadius;
      widget.dropDownTopBorderRadius = initialTopBorderRadius;
    } else {
      findDropdownData();
      _floatingDropdown = _createFloatingDropdown(widget.numOfListItemToShow);
      Overlay.of(context)!.insert(_floatingDropdown!);
      initialTopBorderRadius = widget.dropDownTopBorderRadius;
      initialBottomBorderRadius = widget.dropDownBottomBorderRadius;
      widget.dropDownBottomBorderRadius = 0.0;
      widget.dropDownTopBorderRadius = 30.0;
      _dropDownStateChanged(true);
    }
    _isDropdownOpened = !_isDropdownOpened;
  }

  /// it detect if the drop down state changed?
  void _dropDownStateChanged(bool state) {
    if (widget.dropStateChanged != null) {
      widget.dropStateChanged!(state);
    }
  }

  /// this changes the whole drop down width when orientation changes from portrait to landscape or vise versa
  @override
  void didChangeMetrics() {
    Orientation _orientation = MediaQuery.of(context).orientation;
    if (_isDropdownOpened) {
      _openAndCloseDrawer();
      _openAndCloseDrawer();
    }
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _orientation = MediaQuery.of(context).orientation;
      if (_isDropdownOpened) {
        _openAndCloseDrawer();
        _openAndCloseDrawer();
      }
    });
    super.didChangeMetrics();
  }

  /// it detects the user click and display the new selected value
  void _dropDownItemClickListener(String selItem) {
    setState(() {
      widget.selectedItem = selItem;
      _openAndCloseDrawer();
    });
    if (widget.onDropDownItemClick != null) {
      widget.onDropDownItemClick!(selItem);
    }
  }
}

/// Widget that builds the dropdown overlay.
///
/// This Widget is responsible to create the dropdown
/// overlay menu every time is open.
/// This menu has a [dropDownItemClick] callback, used to
/// pass upwards the on value changed event, from his children
/// to the [AwesomeDropDown].
class DropDownOverlay extends StatelessWidget {
  final Function dropDownItemClick;
  final List<String> dropDownList;
  final double itemHeight;
  final Color overlayBGColor;
  final double dropDownBorderRadius;
  final Function onOverlayOpen;
  final TextStyle dropDownListTextStyle;

  DropDownOverlay(
      {Key? key,
      this.itemHeight = 0.0,
      required this.dropDownList,
      this.overlayBGColor: Colors.white,
      required this.dropDownItemClick,
      this.dropDownBorderRadius = 30.0,
      this.dropDownListTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
          backgroundColor: Colors.transparent),
      required this.onOverlayOpen})
      : super(key: key);

  GlobalKey _listItemKey = GlobalKey();

  double getListItemHeight() {
    RenderBox renderBox =
        _listItemKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (onOverlayOpen != null) {
        onOverlayOpen(getListItemHeight());
      }
    });
    ScrollController _scrollController = ScrollController();

    /// Create the overlay-ed body of the dropdown.
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 1, bottom: 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)),
      ),
      color: overlayBGColor,
      child: Container(
        transform: Matrix4.translationValues(0, -2.5, 0),
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.white,
          //       blurRadius: 0,
          //       spreadRadius: 0,
          //       offset: Offset(1, 3))
          // ],
          color: overlayBGColor,
        ),
        child: CustomScrollbar(
            scrollbarThickness: 1.0,
            isAlwaysShown: true,
            controller: _scrollController,
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var x in dropDownList)
                      Container(
                          key: _listItemKey = GlobalKey(),
                          color: Colors.transparent,
                          width: double.maxFinite,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.black12,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Row(
                                  children: [
                                    x == "Google Pay"
                                        ? CircleAvatar(
                                            backgroundColor: clF3F3F3,
                                            child: Center(
                                                child: Image.asset(
                                                    "assets/google-pay.png")),
                                          )
                                        : x == "Paytm"
                                            ? CircleAvatar(
                                                backgroundColor: clF3F3F3,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/Group-Copy.png")),
                                              )
                                            : x == "UPI Transaction"
                                                ? CircleAvatar(
                                                    backgroundColor: clF3F3F3,
                                                    child: Center(
                                                        child: Image.asset(
                                                            "assets/bharat-interface-for-money-bhim-logo-vector 1.png")),
                                                  )
                                                : SizedBox(),
                                    Text(
                                      x,
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      textScaleFactor: MediaQuery.of(context)
                                                  .textScaleFactor >
                                              1.5
                                          ? 1.5
                                          : MediaQuery.of(context)
                                              .textScaleFactor,
                                      style: dropDownListTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (dropDownItemClick != null) {
                                  dropDownItemClick(x);
                                }
                              },
                            ),
                          )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

// this file is used to add custom scroll bar,
// in case user wants to show a larger list in drop down overlay
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

class CustomScrollbar extends StatefulWidget {
  const CustomScrollbar({
    Key? key,
    required this.child,
    required this.controller,
    this.isAlwaysShown = false,
    this.scrollbarThickness: 2.0,
  }) : super(key: key);

  final Widget child;

  final ScrollController controller;

  final bool isAlwaysShown;

  final scrollbarThickness;

  @override
  _CustomScrollbarState createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar>
    with TickerProviderStateMixin {
  ScrollbarPainter? _materialPainter;
  TextDirection? _textDirection;
  Color? _themeColor;
  bool? _useCupertinoScrollbar;
  late AnimationController _fadeoutAnimationController;
  late Animation<double>? _fadeoutOpacityAnimation;
  Timer? _fadeoutTimer;

  @override
  void initState() {
    super.initState();
    _fadeoutAnimationController = AnimationController(
      vsync: this,
      duration: _kScrollbarFadeDuration,
    );
    _fadeoutOpacityAnimation = CurvedAnimation(
      parent: _fadeoutAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert((() {
      _useCupertinoScrollbar = null;
      return true;
    })());
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // On iOS, stop all local animations. CupertinoScrollbar has its own
        // animations.
        _fadeoutTimer?.cancel();
        _fadeoutTimer = null;
        _fadeoutAnimationController.reset();
        _useCupertinoScrollbar = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        _themeColor = theme.highlightColor.withOpacity(1.0);
        _textDirection = Directionality.of(context);
        _materialPainter = _buildMaterialScrollbarPainter();
        _useCupertinoScrollbar = false;
        WidgetsBinding.instance!.addPostFrameCallback((Duration duration) {
          if (widget.isAlwaysShown) {
            assert(widget.controller != null);
            // Wait one frame and cause an empty scroll event.  This allows the
            // thumb to show immediately when isAlwaysShown is true.  A scroll
            // event is required in order to paint the thumb.
            widget.controller.position.didUpdateScrollPositionBy(0);
          }
        });
        break;
    }
    assert(_useCupertinoScrollbar != null);
  }

  @override
  void didUpdateWidget(CustomScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAlwaysShown != oldWidget.isAlwaysShown) {
      assert(widget.controller != null);
      if (widget.isAlwaysShown == false) {
        _fadeoutAnimationController.reverse();
      } else {
        _fadeoutAnimationController.animateTo(1.0);
      }
    }
  }

  ScrollbarPainter _buildMaterialScrollbarPainter() {
    return ScrollbarPainter(
      color: _themeColor!,
      textDirection: _textDirection,
      thickness: widget.scrollbarThickness,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation!,
      padding: MediaQuery.of(context).padding,
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      return false;
    }

    // iOS sub-delegates to the CupertinoScrollbar instead and doesn't handle
    // scroll notifications here.
    if (!_useCupertinoScrollbar! &&
        (notification is ScrollUpdateNotification ||
            notification is OverscrollNotification)) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward) {
        _fadeoutAnimationController.forward();
      }

      _materialPainter!.update(
        notification.metrics,
        notification.metrics.axisDirection,
      );
      if (!widget.isAlwaysShown) {
        _fadeoutTimer?.cancel();
        _fadeoutTimer = Timer(_kScrollbarTimeToFade, () {
          _fadeoutAnimationController.reverse();
          _fadeoutTimer = null;
        });
      }
    }
    return false;
  }

  @override
  void dispose() {
    _fadeoutAnimationController.dispose();
    _fadeoutTimer?.cancel();
    _materialPainter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_useCupertinoScrollbar!) {
      return CupertinoScrollbar(
        child: widget.child,
        thumbVisibility: widget.isAlwaysShown,
        controller: widget.controller,
      );
    }
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: RepaintBoundary(
        child: CustomPaint(
          foregroundPainter: _materialPainter,
          child: RepaintBoundary(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}