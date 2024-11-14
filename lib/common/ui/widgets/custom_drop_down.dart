import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CustomDropDown extends FormBuilderField<String> {
  final List<Map<String, dynamic>> elements;
  final String elementValueKey;
  final String elementChildKey;
  final String hint;
  final double? width;
  final double? height;
  final Color? boxColor;
  final Color? hintColor;
  final double? hintSize;
  final Function? onTap;

  CustomDropDown({
    super.key,
    required super.name,
    required this.elements,
    required this.elementValueKey,
    required this.elementChildKey,
    required this.hint,
    this.width,
    this.height,
    this.boxColor,
    this.hintColor,
    this.hintSize,
    super.initialValue,
    super.validator,
    super.enabled,
    this.onTap,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
    super.onChanged,
  }) : super(
          builder: (FormFieldState<String> field) {
            final state = field as _CustomDropDownState;
            return state.buildDropdown();
          },
        );

  @override
  FormBuilderFieldState<CustomDropDown, String> createState() =>
      _CustomDropDownState();
}

class _CustomDropDownState
    extends FormBuilderFieldState<CustomDropDown, String> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      try {
        final defaultElement = widget.elements.firstWhere(
          (element) {
            final elementValue = element[widget.elementValueKey]?.toString();
            return elementValue == widget.initialValue;
          },
        );
        if (widget.initialValue == null) {
          log("value is null");
        }

        setValue(defaultElement[widget.elementValueKey]);
      } catch (e) {
        log("Notificacion, no se encontró el valor predeterminado: ${widget.initialValue}");
        log(e.toString());
      }
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              constraints: BoxConstraints(
                // Adjust to control how many elements you need or want to show
                maxHeight: widget.elements.length <= 4
                    ? widget.elements.length * 50
                    : 200,
              ),
              decoration: BoxDecoration(
                color: ThemeColors.secondary.withOpacity(0.1),
                border: Border.all(color: ThemeColors.secondary, width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: widget.elements.map((element) {
                  return GestureDetector(
                    onTap: () {
                      // if (onTap != null) {
                      //   onTap!();
                      // }
                      didChange(element[widget.elementValueKey].toString());
                      _toggleDropdown();
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: ThemeColors.secondary, width: 1.0),
                        ),
                      ),
                      child: CustomText(
                        text: element[widget.elementChildKey] ?? 'empty',
                        color: ThemeColors.primary,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
    if (_isOpen) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  Widget buildDropdown() {
    String displayText = widget.hint;
    try {
      if (value != null) {
        final selectedElement = widget.elements.firstWhere(
          (element) => element[widget.elementValueKey].toString() == value,
          orElse: () => {widget.elementChildKey: widget.hint},
        );
        displayText = selectedElement[widget.elementChildKey] ?? widget.hint;
      }
    } catch (e) {
      log("Notificacion Custom Dropdown buildDropdown ${e.toString()}");
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.enabled ? _toggleDropdown : null,
        child: Container(
          width: widget.width ?? 320,
          height: widget.height ?? 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: widget.boxColor ?? ThemeColors.secondary.withOpacity(0.1),
            border: Border.all(color: ThemeColors.secondary, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  text: displayText,
                  color: widget.hintColor ?? ThemeColors.primary,
                  fontWeight: FontWeight.w300,
                  fontSize: widget.hintSize ?? 14,
                ),
              ),
              SvgPicture.asset(
                _isOpen
                    ? "assets/icons/arrow_up.svg"
                    : "assets/icons/arrow_down.svg",
                colorFilter: ColorFilter.mode(
                  widget.hintColor ?? ThemeColors.primary,
                  BlendMode.srcIn,
                ),
                width: 25,
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
