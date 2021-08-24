import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class AnnouncementCard extends StatefulWidget {
  const AnnouncementCard({
    Key? key,
    required this.titleText,
    required this.previewDescriptionText,
    required this.expandedDescriptionText,
    required this.imageUrl,
    required this.expandedImageUrl,
    this.onExpansionChanged,
  }) : super(key: key);

  final String titleText;
  final String previewDescriptionText;
  final String expandedDescriptionText;
  final String imageUrl;
  final String? expandedImageUrl;

  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard>
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
    if(widget.expandedImageUrl != '' && widget.expandedDescriptionText != '') {
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
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),   // TODO Card padding
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: grey,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTileTheme.merge(
                child: GestureDetector(
                  onTap: _handleTap,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
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
                                  width: MediaQuery.of(context).size.width * 0.15,
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
                                      style: GoogleFonts.poppins(
                                        color: white,
                                        fontSize: 35,  //45
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
                          padding: EdgeInsets.fromLTRB(19, 10, 17, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: grey,
                                  ),
                                  child: Text(
                                    widget.previewDescriptionText,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: GoogleFonts.poppins(
                                      color: white,
                                      fontSize: 16, //16.5
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
            ]),
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
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
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
                      child: widget.expandedImageUrl!.length == 0 || widget.expandedImageUrl == null ? Container() : Image.network(widget.expandedImageUrl!),

                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Text(widget.expandedDescriptionText,
                            style: GoogleFonts.poppins(
                                color: white,
                                fontSize: 16))), //16.5
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
