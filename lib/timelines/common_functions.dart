import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hopzy/timelines/src/indicators.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';


import '../constants/common_variables.dart';
import '../constants/constants.dart';
import '../navigation_service.dart';
import '../theme/app_color.dart';
import '../theme/radius_size.dart';
import '../theme/strings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/dialog/camera_permission_dialog.dart';


abstract class CommonFunctions {
  static Future<T?> navigateToRoute<T>(
      {required Widget page, String? name, Object? arguments, bool replace = false, Function(T)? onThen}) async {
    if (replace) {
      return NavigationService.pushReplacement(page) as Future<T?>;
    } else {
      return NavigationService.push<T>(page: page, name: name, arguments: arguments)?.then((value) {
        if (value != null && onThen != null) {
          onThen(value);
        }
        return value;
      });
    }
  }

  static navigateToRouteAndRemoveUntil({required Widget page, Function? onThen}) {
    NavigationService.pushAndRemoveUntil(page: page, predicate: (route) => false)?.then((value) {
      if (value != null) {
        onThen?.call(value);
      }
    });
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white);

    // IconSnackBar.show(label: message, snackBarType: SnackBarType.success);
  }

  static void showWarningToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);

    //  IconSnackBar.show(label: message, snackBarType: SnackBarType.alert);
  }

  static showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);

    // IconSnackBar.show(context: context, label: message, snackBarType: SnackBarType.fail);
  }

  static showLoader(BuildContext context) {
    context.loaderOverlay.show();
  }

  static dismissLoader(BuildContext context) {
    context.loaderOverlay.hide();
  }

  static void setToClipboard({String? clipboardData}) {
    try {
      Clipboard.setData(ClipboardData(text: clipboardData ?? "")).then((_) {
        CommonFunctions.showSuccessToast("Copied to Clipboard!");
      });
    } catch (e) {
      CommonFunctions.showErrorToast("Failed to copy to clipboard.");
    }
  }

  static Future<void> dialPhoneNumber(String phoneNumber) async {
    // Remove any existing whitespace or dashes
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[\s-]'), '');

    // Add +91 prefix if not already present
    final String formattedNumber = cleanedNumber.startsWith('+91') ? cleanedNumber : '+91$cleanedNumber';

    final Uri callUri = Uri.parse('tel:$formattedNumber');

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $callUri';
    }
  }

  static void becomeRider() {
    if (Platform.isAndroid || Platform.isIOS) {
      final url = Uri.parse(Platform.isAndroid
          ? "market://details?id=com.application.beta_rider"
          : "https://apps.apple.com/us/app/beta-24-rider/id6741687907");
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> sendSupportEmail(String title, String body) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Constants.supportEmailAddress,
      query: encodeQueryParameters(<String, String>{'subject': title, 'body': body}),
    );

    launchUrl(emailLaunchUri);
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  static Future<void> getDirectionOnGoogleMap(
      {required String origin, required String destination, List<String>? waypoints, String travelMode = 'driving'}) async {
    final waypointsString = waypoints?.join('|') ?? '';
    final Uri uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&waypoints=$waypointsString&travelmode=$travelMode&dir_action=navigate');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static BoxDecoration outlineDecoration({Color? color, Color? borderColor, BorderRadius? borderRadius, double borderWidth = 1.0}) {
    return BoxDecoration(
      color: color ?? AppColors.whiteColor,
      border: Border.all(color: borderColor ?? AppColors.editTextBorderColor, width: borderWidth.r),
      borderRadius: borderRadius ?? BorderRadius.circular(RadiusSize.radiusSize4),
    );
  }

  static BoxDecoration cardDecoration({Color? color, List<BoxShadow>? boxShadow, BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: color ?? AppColors.whiteColor,
      boxShadow: boxShadow ??
          const [
            BoxShadow(offset: Offset(1, 1), blurRadius: 6, color: Color.fromRGBO(0, 0, 0, 0.16)),
          ],
      borderRadius: borderRadius ?? BorderRadius.circular(RadiusSize.radiusSize8),
    );
  }

  static BoxDecoration cardOutlineDecoration({Color? color, Color? borderColor, BorderRadius? borderRadius, double? borderWidth}) {
    return BoxDecoration(
        color: color ?? AppColors.whiteColor,
        border: Border.all(color: borderColor ?? AppColors.editTextBorderColor, width: borderWidth ?? 1),
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(RadiusSize.radiusSize8)));
  }

  static BoxDecoration bottomBarDecoration({Color? color, List<BoxShadow>? boxShadow, BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: color ?? AppColors.whiteColor,
      boxShadow: boxShadow ??
          const [
            BoxShadow(offset: Offset(2, 2), blurRadius: 12, color: Color.fromRGBO(0, 0, 0, 0.16)),
          ],
      borderRadius: borderRadius ?? BorderRadius.circular(RadiusSize.radiusSize0),
    );
  }

  static OutlinedDotIndicator todoIndicator(
      {Color? color, Color backgroundColor = Colors.transparent, double borderWidth = 4.0, double size = 22}) {
    return OutlinedDotIndicator(
        color: color ?? AppColors.blackColor, backgroundColor: backgroundColor, borderWidth: borderWidth, size: size.r);
  }

  static OutlinedDotIndicator inProgressIndicator(
      {Color? color, Color backgroundColor = Colors.transparent, double borderWidth = 4.0, double size = 22}) {
    return OutlinedDotIndicator(
        color: color ?? AppColors.primaryColor, backgroundColor: backgroundColor, borderWidth: borderWidth, size: size.r);
  }

  static DotIndicator cancelIndicator() {
    return DotIndicator(color: AppColors.redColor, child: Icon(Icons.close_rounded, size: 14.r, color: AppColors.whiteColor));
  }

  static DotIndicator doneIndicator() {
    return DotIndicator(color: AppColors.creditGreenColor, child: Icon(Icons.check, size: 14.r, color: AppColors.whiteColor));
  }

  static imagePickCropAndCompress(bool isCheckCamera, {int type = 0}) async {
    // 1: Profile  2: Document

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: isCheckCamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile != null) {
      // _image = File(pickedFile.path);
      //Cropping the image
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: type == 1 ? const CropAspectRatio(ratioX: 1, ratioY: 1) : null,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        // aspectRatioPresets: type == 1
        //     ? [CropAspectRatioPreset.square]
        //     : type == 2
        //         ? [CropAspectRatioPreset.ratio16x9]
        //         : [
        //             CropAspectRatioPreset.square,
        //             CropAspectRatioPreset.ratio3x2,
        //             CropAspectRatioPreset.original,
        //             CropAspectRatioPreset.ratio4x3,
        //             CropAspectRatioPreset.ratio16x9
        //           ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Edit Image',
              toolbarColor: AppColors.whiteColor,
              toolbarWidgetColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(title: 'Cropper'),
        ],
      );

      //compress file
      Directory tempDir = await getTemporaryDirectory();

      var result = await FlutterImageCompress.compressAndGetFile(
          croppedFile!.path, '${tempDir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg',
          quality: 20);

      // print(croppedFile.lengthSync());
      // print(result!.lengthSync());

      return result;
    } else {
      print('No image selected.');
    }
    return null;
  }

  static String formatTo12Hour(String dateString) {
    if (dateString.isEmpty) return "";

    try {
      // Parse the input date string
      final inputFormat = DateFormat('dd MMM yyyy, HH:mm');
      final dateTime = inputFormat.parse(dateString);

      // Format to 12-hour with AM/PM
      final outputFormat = DateFormat('dd MMM yyyy, hh:mm a');
      return outputFormat.format(dateTime);
    } catch (e) {
      throw const FormatException('Invalid date format');
    }
  }

  static String getComplaintStatusType(num status) {
    switch (status) {
      case 0:
        return Strings.resolved;
      case 1:
        return Strings.inProgress;
      case 2:
        return Strings.withdraw;
      default:
        return 'Unknown Status';
    }
  }

  static String getStatusType(num status) {
    switch (status) {
      case 0:
        return Strings.created;
      case 1:
        return Strings.waitingForApproval;
      case 2:
        return Strings.inTransit;
      case 3:
        return Strings.payment;
      case 4:
        return Strings.completed;
      case 5:
        return Strings.cancelled;
      default:
        return 'Unknown Status';
    }
  }

  static Color getStatusTypeColor(num status) {
    switch (status) {
      case 1:
        return AppColors.debitRedColor;
      case 2:
        return AppColors.creditGreenColor;
      case 3:
        return AppColors.creditGreenColor;
      case 4:
        return AppColors.creditGreenColor;
      case 5:
        return AppColors.debitRedColor;
      default:
        return AppColors.debitRedColor;
    }
  }

  static showCustomBottomSheet({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    bool isDismissible = false,
    bool enableDrag = false,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor ?? AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius ?? RadiusSize.radiusSize20),
            topRight: Radius.circular(borderRadius ?? RadiusSize.radiusSize20)),
      ),
      showDragHandle: true,
      builder: builder,
    );
  }

  static String maskEmail(String email, {int length = 3}) {
    if (!email.contains('@')) return email; // Return as is if not a valid email

    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];

    // Show at least the first 4 characters or the whole username if it's too short
    if (username.length <= 4) {
      return "$username@$domain"; // No masking for very short usernames
    }

    final visiblePart = username.substring(0, length);
    final maskedUsername = "$visiblePart***";
    return "$maskedUsername@$domain";
  }

  static String maskMobileNumber(String mobileNumber) {
    // Remove any non-digit characters (e.g., spaces, hyphens)
    final cleanedNumber = mobileNumber.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the number is valid (10 digits for Indian mobile numbers)
    if (cleanedNumber.length != 10) {
      return mobileNumber; // Return as is if not a valid Indian mobile number
    }

    // Extract parts of the number
    final firstPart = cleanedNumber.substring(0, 2); // First 2 digits
    const middlePart = 'XXXX'; // Masked middle 4 digits
    final lastPart = cleanedNumber.substring(6); // Last 4 digits

    // Format the number
    final formattedNumber = "$firstPart $middlePart $lastPart";

    return "+91 $formattedNumber";
  }

  /// Returns the total amount including GST.
  static String calculateGST({required num gstPercent, required num price}) {
    if (gstPercent < 0 || price < 0) {
      return "00";
    }

    num gstAmount = (gstPercent / 100) * price;
    num roundedGstAmount = (gstAmount * 100).ceil() / 100;
    return roundedGstAmount.toStringAsFixed(2);
  }

  /// Returns the total amount including GST.
  static String calculateTotalWithGST({required num gstPercent, required num price}) {
    if (gstPercent < 0 || price < 0) {
      return "00";
    }

    num gstAmount = (gstPercent / 100) * price;
    num roundedGstAmount = (gstAmount * 100).ceil() / 100 + price;
    return roundedGstAmount.toStringAsFixed(2);
  }

  static String formatDateTime(String timestamp, String format) {
    if (timestamp.isEmpty) return "";

    try {
      DateTime utcTime = DateTime.parse(timestamp);
      DateTime istTime = utcTime.add(const Duration(hours: 5, minutes: 30));
      return DateFormat(format).format(istTime);
    } catch (e) {
      return ""; // Return empty string if parsing fails
    }
  }

  static String chatDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.isAfter(today)) {
      return 'Today';
    } else if (date.isAfter(yesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static Future<void> handleCameraPermission({
    required BuildContext context,
    required VoidCallback onPermissionGranted,
  }) async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      onPermissionGranted();
      return;
    }

    if (status.isDenied) {
      final newStatus = await Permission.camera.request();
      if (newStatus.isGranted) {
        onPermissionGranted();
      } else if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const CameraPermissionDialog(),
        );
      }
    } else if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CameraPermissionDialog(),
      );
    }
  }


  static String getUserFriendlyError(dynamic error) {
    if (error is PlatformException) {
      switch (error.code) {
        case 'sign_in_failed':
          return 'Google Sign-In failed. Please try again';
        case 'network_error':
          return 'Network error. Check your internet connection';
        case 'sign_in_canceled':
          return 'Sign in cancelled'; // No toast needed for user-initiated cancel
        default:
          return 'Authentication failed. Try another method';
      }
    }
    return 'Google Sign-In failed. Try again';
  }

  static Future<BitmapDescriptor?> loadRiderIcon(String riderGender, String riderType) async {
    final Map<String, String> iconPaths;

    if (HydratedBloc.storage.read(CommonVariables.gender) == Constants.genderType1) {
      iconPaths = {
        '${Constants.serviceType1}_${Constants.genderType1}': Constants.iconBikeMale,
        '${Constants.serviceType1}_${Constants.genderType2}': Constants.iconBikeMale,
        '${Constants.serviceType2}_${Constants.genderType1}': Constants.iconWalkMale,
        '${Constants.serviceType2}_${Constants.genderType2}': Constants.iconWalkMale,
      };
    } else {
      iconPaths = {
        '${Constants.serviceType1}_${Constants.genderType1}': Constants.iconBikeMale,
        '${Constants.serviceType1}_${Constants.genderType2}': Constants.iconBikeFemale,
        '${Constants.serviceType2}_${Constants.genderType1}': Constants.iconWalkMale,
        '${Constants.serviceType2}_${Constants.genderType2}': Constants.iconWalkFemale,
      };
    }

    final iconKey = '${riderType}_$riderGender';
    final iconPath = iconPaths[iconKey];

    try {
      return iconPath != null
          ? await BitmapDescriptor.asset(const ImageConfiguration(devicePixelRatio: 3.2), width: 60, height: 60, iconPath)
          /*await GoogleMapMarker.getMarker(NavigationService.navigatorKey.currentContext!, iconPath)*/
          : BitmapDescriptor.defaultMarker;
    } catch (e) {
      return BitmapDescriptor.defaultMarker;
    }
  }

  static Future<bool> isAndroid13OrHigher() async {
    // For Flutter 3.0+ (recommended approach)
    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 33;
    } catch (e) {
      debugPrint('Error checking Android version: $e');
      return false;
    }
  }

  static String formatTimeShort(num totalMinutes) {
    int roundedMinutes = totalMinutes.ceil();

    int hours = roundedMinutes ~/ 60;
    int minutes = roundedMinutes % 60;
    if (hours > 0) {
      String hourPart = '$hours h';
      String minutePart = minutes > 0 ? '$minutes m' : '';
      return '$hourPart ${minutePart.isNotEmpty ? minutePart : ''}';
    } else {
      return '$minutes m';
    }
  }

  static Color getStatusTypeColor2({required num totalValue, required num requiredValue}) {
    if (totalValue <= 0) {
      return AppColors.debitRedColor;
    } else {
      return (requiredValue <= totalValue) ? AppColors.creditGreenColor : AppColors.debitRedColor;
    }
  }

  static num? parseToNum(dynamic value) => value is num ? value : num.tryParse(value.toString());

  // URL launching with error handling
  // static Future<void> launchSocialUrl(String url, String platform) async {
  //   try {
  //     if (await canLaunchUrl(Uri.parse(url))) {
  //       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  //     } else {
  //       throw 'Could not launch $url';
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to launch $platform: $e');
  //     // Optional: Show error to user
  //     // ScaffoldMessenger.of(context).showSnackBar(...);
  //   }
  // }

  static Future<void> launchSocialUrl(String url, String platform) async {
    try {
      Uri uriToLaunch = Uri.parse(url);

      if (platform.toLowerCase() == 'facebook') {
        final Uri fbAppUri = Uri.parse(Constants.facebookAppLink);
        final Uri fbWebUri = Uri.parse(Constants.facebookWebLink);

        if (await canLaunchUrl(fbAppUri)) {
          await launchUrl(fbAppUri, mode: LaunchMode.externalApplication);
        } else {
          await launchUrl(fbWebUri, mode: LaunchMode.externalApplication);
        }
      } else {
        // Default launcher for other platforms like Instagram, Twitter, etc.
        if (await canLaunchUrl(uriToLaunch)) {
          await launchUrl(uriToLaunch, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      }
    } catch (e) {
      debugPrint('Failed to launch $platform: $e');
    }
  }

  static String getDiscountedPrice(String priceStr, num discount) {
    try {
      final price = double.parse(priceStr);
      if (price < 0) throw ArgumentError('Negative price');
      if (discount < 0 || discount > 100) throw ArgumentError('Invalid discount');

      return (price * (1 - discount / 100)).toStringAsFixed(2);
    } on FormatException {
      throw FormatException('"$priceStr" is not a valid number');
    }
  }


  static String activeTimeFormatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours : $minutes : $seconds';
  }

  static Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');

    if (hex.length == 6) {
      hex = "FF$hex";
    }

    return Color(int.parse("0x$hex"));
  }

  static Widget indicatorBuilder(num code) {
    if ([25,26].contains(code)) {
      return CommonFunctions.doneIndicator();
    } else if ([22,23,24,27,28,29].contains(code)) {
      return CommonFunctions.cancelIndicator();
    } else if ([20,21].contains(code)) {
      return CommonFunctions.todoIndicator(size: 18.r, color: AppColors.primaryColor);
    } else {
      return CommonFunctions.todoIndicator(size: 18.r);
    }
  }

}

enum TimelineStatus {
  done,
  cancel,
  inProgress,
  todo,
}
