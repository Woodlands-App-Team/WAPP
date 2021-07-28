import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'constants.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class EventCard extends StatefulWidget {
  const EventCard({
    Key? key,
    required this.titleText,
    required this.descriptionText,
    required this.imageUrl,
    required this.month,
    required this.date,
    this.expandedImageUrl,
    this.onExpansionChanged,
  }) : super(key: key);

  final String titleText;
  final String descriptionText;
  final String imageUrl;
  final String month;
  final String date;
  final String? expandedImageUrl;

  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  late AnimationController _controller;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);

    _isExpanded = false;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: app_dark_blue,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTileTheme.merge(
            child: GestureDetector(
              onTap: _handleTap,
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(widget.imageUrl),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: AutoSizeText(
                                      widget.titleText,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: app_white,
                                        fontSize: 45,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: app_dark_blue,
                                ),
                                child: Text(
                                  widget.descriptionText,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: app_white,
                                    fontSize: 16.5,
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0x00FF0000),
                                ),
                                child: Align(
                                  alignment: Alignment(0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: Alignment(0, -2),
                                        child: AutoSizeText(
                                          widget.month,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: app_white,
                                            fontSize: 23,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0, 0),
                                        child: AutoSizeText(
                                          widget.date,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: app_white,
                                            fontSize: 45,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed;

    final Widget result = Offstage(
      offstage: closed,
      child: GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: TickerMode(
          enabled: !closed,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                        child: Divider(
                            height: 5,
                            thickness: 2.5,
                            indent: 20,
                            endIndent: 20)),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Image.network(widget.expandedImageUrl!),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Text(widget.descriptionText,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: app_white,
                                fontSize: 16.5))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
