import 'package:flutter/material.dart';

class CDropDown<T> extends StatefulWidget {
  const CDropDown({
    super.key,
    required this.changedItem,
    required this.options,
    this.selectedItemName = "Select an Option",
    this.onChange,
    this.dropdownRadius = 1,
    this.background = Colors.white,
    this.boxBorderColor = Colors.black,
    this.boxBorderWidth = 1,
    this.textStyle = const TextStyle(),
    this.selectedIconColor = Colors.black,
    this.dropdownIconSize = 10,
    this.paddingHor = 6,
    this.paddingVert = 2,
    this.dropdownOffset = 36,
  });

  final List<T> options;
  final String Function(T) changedItem;
  final String selectedItemName;
  final Function? onChange;

  final double dropdownRadius;
  final Color background;
  final Color boxBorderColor;
  final double boxBorderWidth;
  final TextStyle textStyle;
  final Color selectedIconColor;
  final double dropdownIconSize;
  final double paddingHor;
  final double paddingVert;
  final double dropdownOffset;

  @override
  State<CDropDown<T>> createState() => _CDropDownState<T>();
}

class _CDropDownState<T> extends State<CDropDown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  late String _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItemName;
    super.initState();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isDropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isDropdownOpen = false);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    double screenHeight = MediaQuery.of(context).size.height;
    double availableHeight =
        screenHeight - position.dy - renderBox.size.height - 30;

    return OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeDropdown,
                  behavior: HitTestBehavior.opaque,
                ),
              ),
              Positioned(
                left: position.dx,
                top: position.dy + renderBox.size.height + 4,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  offset: Offset(0, widget.dropdownOffset),
                  child: Material(
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(widget.dropdownRadius),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            availableHeight > 300 ? 300 : availableHeight,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.background,
                          border: Border.all(
                            color: widget.boxBorderColor,
                            width: widget.boxBorderWidth,
                          ),
                          borderRadius: BorderRadius.circular(
                            widget.dropdownRadius,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                widget.options
                                    .map((option) => _buildMenuItem(option))
                                    .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildMenuItem(T option) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedItem = widget.changedItem(option);
        });
        if (widget.onChange != null) widget.onChange!();
        _closeDropdown();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(widget.changedItem(option), style: widget.textStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.paddingHor,
            vertical: widget.paddingVert,
          ),
          decoration: BoxDecoration(
            color: widget.background,
            border: Border.all(
              color: widget.boxBorderColor,
              width: widget.boxBorderWidth,
            ),
            borderRadius: BorderRadius.circular(widget.dropdownRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  _selectedItem,
                  style: widget.textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: widget.selectedIconColor,
                size: widget.dropdownIconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
