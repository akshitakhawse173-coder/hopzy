
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../theme/text_styles.dart';

/// Customable and nice Switch button :).
///
/// Currently, you can change the widget
/// width but not the height property.
///
/// The following arguments are required:
///
/// * [value] determines switch state (on/off).
/// * [onChanged] is called when user toggles switch on/off.
/// * [onTap] event called on tap
/// * [onDoubleTap] event called on double tap
/// * [onSwipe] event called on swipe (left/right)
///
class LiteRollingSwitch extends StatefulWidget {
  @required
  final bool value1;
  final double width;
  final double height;

  @required
  final Function(bool) onChanged;
  final String textOff;
  final Color textOffColor;
  final String textOn;
  final Color textOnColor;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn;
  final IconData iconOff;

  const LiteRollingSwitch({
    super.key,
    this.value1 = false,
    this.width = 130,
    this.height = 40,
    this.textOff = "Off",
    this.textOn = "On",
    this.textSize = 14.0,
    this.colorOn = Colors.green,
    this.colorOff = Colors.red,
    this.iconOff = Icons.flag,
    this.iconOn = Icons.check,
    this.animationDuration = const Duration(milliseconds: 600),
    this.textOffColor = Colors.white,
    this.textOnColor = Colors.white,
    required this.onChanged,
  });

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<LiteRollingSwitch> with SingleTickerProviderStateMixin {
  /// Late declarations
  late AnimationController animationController;
  late Animation<double> animation;
  late bool turnState;

  double value = 0.0;

  @override
  void dispose() {
    //Ensure to dispose animation controller
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, lowerBound: 0.0, upperBound: 1.0, duration: widget.animationDuration);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value1;

    // Executes a function only one time after the layout is completed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (turnState) {
          animationController.forward();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update `turnState` when `widget.value1` changes
    if (turnState != widget.value1) {
      turnState = widget.value1;
      if (turnState) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }

    //Color transition animation
    Color? transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
      },
      onTap: () {
        _action();
      },
      onPanEnd: (details) {
        _action();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(color: transitionColor, borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: isRTL(context) ? Offset(-10 * value, 0) : Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: isRTL(context) ? const EdgeInsets.only(left: 10) : const EdgeInsets.only(right: 10),
                  alignment: isRTL(context) ? Alignment.centerLeft : Alignment.centerRight,
                  height: 40,
                  child: Text(
                    widget.textOff,
                    style: AppTextStyle.medium500(color: widget.textOffColor, fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: isRTL(context) ? Offset(-10 * (1 - value), 0) : Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: isRTL(context) ? const EdgeInsets.only(right: 5) : const EdgeInsets.only(left: 5),
                  alignment: isRTL(context) ? Alignment.centerRight : Alignment.centerLeft,
                  height: 40,
                  child: Text(
                    widget.textOn,
                    style: AppTextStyle.medium500(color: widget.textOnColor, fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: isRTL(context) ? Offset((-widget.width + 40) * value, 0) : Offset((widget.width - 40) * value, 0),
              child: Transform.rotate(
                angle: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOff,
                            size: 18,
                            color: transitionColor,
                          ),
                        ),
                      ),
                      Center(
                        child: Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOn,
                            size: 18,
                            color: transitionColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState) ? animationController.forward() : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}

bool isRTL(BuildContext context) {
  return Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode);
}
