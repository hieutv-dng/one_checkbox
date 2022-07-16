part of 'package:one_checkbox/one_checkbox.dart';

class OneCheckbox extends StatefulWidget {
  const OneCheckbox({
    Key? key,
    this.isEnable,
    this.isChecked,
    this.isTristate = false,
    this.label,
    this.uncheckIcon,
    this.checkedIcon,
    this.onChanged,
    this.padding = const EdgeInsets.fromLTRB(5, 10, 5, 10),
    this.controller,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  final bool? isEnable;
  final bool? isChecked;
  final bool isTristate;
  final Widget? label;
  final Widget? uncheckIcon;
  final Widget? checkedIcon;
  final ValueChanged<bool?>? onChanged;
  final EdgeInsetsGeometry padding;
  final OneCheckboxController? controller;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<StatefulWidget> createState() => _OneCheckboxState();
}

class _OneCheckboxState extends State<OneCheckbox> {
  late OneCheckboxController _controller;
  OneCheckboxController get _effectiveController => widget.controller ?? _controller;

  bool? _isEnable;
  bool get isEnable => _isEnable ?? _effectiveController.isEnable;

  bool? _isChecked;
  bool get isChecked => _isChecked ?? _effectiveController.isChecked;

  Widget get _checkIcon => widget.checkedIcon ?? const Icon(Icons.check_box);
  Widget get _checkDisabledIcon => widget.checkedIcon ?? const Icon(Icons.check_box);
  Widget get _uncheckIcon => widget.uncheckIcon ?? const Icon(Icons.check_box_outline_blank);
  Widget get _uncheckDisabledIcon => widget.uncheckIcon ?? const Icon(Icons.check_box_outline_blank);

  Widget get _checkboxView {
    switch (isChecked) {
      case true:
        return isEnable ? _checkIcon : _checkDisabledIcon;
      case false:
        return isEnable ? _uncheckIcon : _uncheckDisabledIcon;
      default:
        return isEnable ? _checkIcon : _checkDisabledIcon;
    }
  }

  Widget get _labelView {
    if (widget.label == null) return const SizedBox();
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: widget.label!,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isEnable = widget.isEnable;
    _isChecked = widget.isChecked;
    if (widget.controller == null) {
      _controller = OneCheckboxController(
        isChecked: widget.isChecked ?? false,
        isEnable: widget.isEnable ?? true,
      );
    } else {
      if (widget.isChecked != null) widget.controller!.isChecked = widget.isChecked!;
      if (widget.isEnable != null) widget.controller!.isEnable = widget.isEnable!;
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OneCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = OneCheckboxController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        _isChecked = widget.controller!.isChecked;
        if (oldWidget.controller == null) {
          _controller = OneCheckboxController(
            isChecked: widget.isChecked ?? false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnable ? _actionHandler : null,
        child: Padding(
          padding: widget.padding,
          child: Row(
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              _checkboxView,
              _labelView,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _actionHandler() {
    switch (isChecked) {
      case false:
        _didChange(true);
        break;
      case true:
        _didChange(widget.isTristate ? null : false);
        break;
      default: // case null:
        _didChange(false);
        break;
    }
  }

  void _didChange(bool? isChecked) {
    setState(() {
      _isChecked = isChecked;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(isChecked);
    }
    if (_effectiveController.isChecked != isChecked) {
      _effectiveController.isChecked = isChecked;
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.isChecked != _isChecked) {
      _didChange(_effectiveController.isChecked);
    }
    setState(() {
      _isEnable = _effectiveController.isEnable;
    });
  }
}
