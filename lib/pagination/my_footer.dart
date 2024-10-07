/*
 *   Author: Jpeng
 *   Email: peng8350@gmail.com
 *   createTime:2018-05-14 17:39
 */

part of '../mymo.dart';


/// direction that icon should place to the text
enum IconPosition { left, right, top, bottom }

/// wrap child in outside,mostly use in add background color and padding
typedef OuterBuilder = Widget Function(Widget child);

///the most common indicator,combine with a text and a icon
///
/// See also:
///
/// [MyClassicFooter]
class MyClassicHeader extends RefreshIndicator {
  /// a builder for re wrap child,If you need to change the boxExtent or background,padding etc.you need outerBuilder to reWrap child
  /// example:
  /// ```dart
  /// outerBuilder:(child){
  ///    return Container(
  ///       color:Colors.red,
  ///       child:child
  ///    );
  /// }
  /// ````
  /// In this example,it will help to add backgroundColor in indicator
  final OuterBuilder? outerBuilder;
  final String? releaseText,
      idleText,
      refreshingText,
      completeText,
      failedText,
      canTwoLevelText;
  final Widget? releaseIcon,
      idleIcon,
      refreshingIcon,
      completeIcon,
      failedIcon,
      canTwoLevelIcon,
      twoLevelView;

  /// icon and text middle margin
  final double spacing;
  final IconPosition iconPos;

  final TextStyle textStyle;

  const MyClassicHeader({
    Key? key,
    RefreshStyle refreshStyle = RefreshStyle.Follow,
    double height = 60.0,
    Duration completeDuration = const Duration(milliseconds: 600),
    this.outerBuilder,
    this.textStyle = const TextStyle(color: Colors.grey),
    this.releaseText,
    this.refreshingText,
    this.canTwoLevelIcon,
    this.twoLevelView,
    this.canTwoLevelText,
    this.completeText,
    this.failedText,
    this.idleText,
    this.iconPos = IconPosition.left,
    this.spacing = 15.0,
    this.refreshingIcon,
    this.failedIcon = const Icon(Icons.error, color: Colors.grey),
    this.completeIcon = const Icon(Icons.done, color: Colors.grey),
    this.idleIcon = const Icon(Icons.arrow_downward, color: Colors.grey),
    this.releaseIcon = const Icon(Icons.refresh, color: Colors.grey),
  }) : super(
          key: key,
          refreshStyle: refreshStyle,
          completeDuration: completeDuration,
          height: height,
        );

  @override
  State createState() {
    // TODO: implement createState
    return _MyClassicHeaderState();
  }
}

class _MyClassicHeaderState extends RefreshIndicatorState<MyClassicHeader> {
  Widget _buildText(mode) {
    RefreshString strings =
        MyRefreshLocalizations.of(context)?.currentLocalization ??
            EnRefreshString();
    return Text(
        mode == RefreshStatus.canRefresh
            ? widget.releaseText ?? strings.canRefreshText!
            : mode == RefreshStatus.completed
                ? widget.completeText ?? strings.refreshCompleteText!
                : mode == RefreshStatus.failed
                    ? widget.failedText ?? strings.refreshFailedText!
                    : mode == RefreshStatus.refreshing
                        ? widget.refreshingText ?? strings.refreshingText!
                        : mode == RefreshStatus.idle
                            ? widget.idleText ?? strings.idleRefreshText!
                            : mode == RefreshStatus.canTwoLevel
                                ? widget.canTwoLevelText ??
                                    strings.canTwoLevelText!
                                : "",
        style: widget.textStyle);
  }

  Widget _buildIcon(mode) {
    Widget? icon = mode == RefreshStatus.canRefresh
        ? widget.releaseIcon
        : mode == RefreshStatus.idle
            ? widget.idleIcon
            : mode == RefreshStatus.completed
                ? widget.completeIcon
                : mode == RefreshStatus.failed
                    ? widget.failedIcon
                    : mode == RefreshStatus.canTwoLevel
                        ? widget.canTwoLevelIcon
                        : mode == RefreshStatus.canTwoLevel
                            ? widget.canTwoLevelIcon
                            : mode == RefreshStatus.refreshing
                                ? widget.refreshingIcon ??
                                    SizedBox(
                                      width: 25.0,
                                      height: 25.0,
                                      child: defaultTargetPlatform ==
                                              TargetPlatform.iOS
                                          ? const CupertinoActivityIndicator()
                                          : const CircularProgressIndicator(
                                              strokeWidth: 2.0),
                                    )
                                : widget.twoLevelView;
    return icon ?? Container();
  }

  @override
  bool needReverseAll() {
    // TODO: implement needReverseAll
    return false;
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus? mode) {
    // TODO: implement buildContent
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[iconWidget, textWidget];
    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction: widget.iconPos == IconPosition.bottom ||
              widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!(container)
        : SizedBox(
            height: widget.height,
            child: Center(child: container),
          );
  }
}

///the most common indicator,combine with a text and a icon
///
// See also:
//
// [MyClassicHeader]
class MyClassicFooter extends LoadIndicator {
  final String? idleText, loadingText, noDataText, failedText, canLoadingText;

  /// a builder for re wrap child,If you need to change the boxExtent or background,padding etc.you need outerBuilder to reWrap child
  /// example:
  /// ```dart
  /// outerBuilder:(child){
  ///    return Container(
  ///       color:Colors.red,
  ///       child:child
  ///    );
  /// }
  /// ````
  /// In this example,it will help to add backgroundColor in indicator
  final OuterBuilder? outerBuilder;

  final Widget? idleIcon, loadingIcon, noMoreIcon, failedIcon, canLoadingIcon;

  /// icon and text middle margin
  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  /// notice that ,this attrs only works for LoadStyle.ShowWhenLoading
  final Duration completeDuration;

  const MyClassicFooter({
    super.key,
    super.onClick,
    super.loadStyle,
    super.height,
    this.outerBuilder,
    this.textStyle = const TextStyle(color: Colors.grey),
    this.loadingText,
    this.noDataText,
    this.noMoreIcon,
    this.idleText,
    this.failedText,
    this.canLoadingText,
    this.failedIcon = const Icon(Icons.error, color: Colors.grey),
    this.iconPos = IconPosition.left,
    this.spacing = 15.0,
    this.completeDuration = const Duration(milliseconds: 300),
    this.loadingIcon,
    this.canLoadingIcon = const Icon(Icons.autorenew, color: Colors.grey),
    this.idleIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _MyClassicFooterState();
  }
}

class _MyClassicFooterState extends LoadIndicatorState<MyClassicFooter> {
  Widget _buildText(LoadStatus? mode) {
    RefreshString strings =
        MyRefreshLocalizations.of(context)?.currentLocalization ??
            EnRefreshString();
    return Text(
        mode == LoadStatus.loading
            ? widget.loadingText ?? strings.loadingText!
            : LoadStatus.noMore == mode
                ? widget.noDataText ?? strings.noMoreText!
                : LoadStatus.failed == mode
                    ? widget.failedText ?? strings.loadFailedText!
                    : LoadStatus.canLoading == mode
                        ? widget.canLoadingText ?? strings.canLoadingText!
                        : widget.idleText ?? strings.idleLoadingText!,
        style: widget.textStyle);
  }

  Widget _buildIcon(LoadStatus? mode) {
    Widget? icon = mode == LoadStatus.loading
        ? widget.loadingIcon ??
            SizedBox(
              width: 25.0,
              height: 25.0,
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator()
                  : const CircularProgressIndicator(strokeWidth: 2.0),
            )
        : mode == LoadStatus.noMore
            ? widget.noMoreIcon
            : mode == LoadStatus.failed
                ? widget.failedIcon
                : mode == LoadStatus.canLoading
                    ? widget.canLoadingIcon
                    : widget.idleIcon;
    return icon ?? Container();
  }

  @override
  Future endLoading() {
    // TODO: implement endLoading
    return Future.delayed(widget.completeDuration);
  }

  @override
  Widget buildContent(BuildContext context, LoadStatus? mode) {
    // TODO: implement buildChild
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[iconWidget, textWidget];
    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction: widget.iconPos == IconPosition.bottom ||
              widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!(container)
        : SizedBox(
            height: widget.height,
            child: Center(
              child: container,
            ),
          );
  }
}