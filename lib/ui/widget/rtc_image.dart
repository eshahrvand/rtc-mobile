import 'dart:io' show File;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RtcImage extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final String? placeHolder;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final bool? isCircle;
  final double? circleWidth;
  final double? circleHeight;
  final bool? isFile;
  final bool? isMicro;
  final BoxFit? boxFit;
  final Color? color;

  const RtcImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.placeHolder,
    this.backgroundColor,
    this.padding,
    this.alignment,
    this.isFile = false,
    this.isCircle = false,
    this.isMicro = false,
    this.circleWidth,
    this.circleHeight,
    this.boxFit = BoxFit.none,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isCircle ?? false) {
      return ClipOval(
        child: Container(
          width: circleWidth,
          height: circleHeight,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? Colors.transparent,
          ),
          padding: padding ?? EdgeInsets.zero,
          alignment: alignment ?? Alignment.center,
          child: image != null ? getImage() : getPlaceHolder(),
        ),
      );
    }

    if (image != null) {
      return Padding(padding: padding ?? EdgeInsets.zero, child: getImage());
    } else {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: getPlaceHolder(),
      );
    }
  }

  Widget getImage() {
    if (image!.startsWith("http")) {
      if (image!.contains(".svg")) {
        if (width != null || height != null) {
          if (color != null) {
            return SvgPicture.network(
              image ?? "",
              width: width,
              height: height,
              fit: boxFit!,
              alignment: alignment ?? Alignment.center,
              colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
            );
          } else {
            return SvgPicture.network(
              image ?? "",
              width: width,
              height: height,
              fit: boxFit!,
              alignment: alignment ?? Alignment.center,
            );
          }
        } else {
          if (color != null) {
            return SvgPicture.network(
              image ?? "",
              fit: boxFit!,
              alignment: alignment ?? Alignment.center,
              colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
            );
          } else {
            return SvgPicture.network(
              image ?? "",
              fit: boxFit!,
              alignment: alignment ?? Alignment.center,
            );
          }
        }
      }

      if (width != null || height != null) {
        if (color != null) {
          return CachedNetworkImage(
            imageUrl: image ?? "",
            width: width,
            height: height,
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            color: color,
            imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
          );
        } else {
          return CachedNetworkImage(
            imageUrl: image ?? "",
            width: width,
            height: height,
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
          );
        }
      } else {
        if (color != null) {
          return CachedNetworkImage(
            imageUrl: image ?? "",
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            color: color,
            imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
          );
        } else {
          return CachedNetworkImage(
            imageUrl: image ?? "",
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
          );
        }
      }
    }

    if (isFile ?? false) {
      if (kIsWeb) {
        if (width != null || height != null) {
          return Image.network(
            image ?? "",
            width: width,
            height: height,
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            color: color,
            errorBuilder: (context, error, stackTrace) => getPlaceHolder(),
          );
        } else {
          return Image.network(
            image ?? "",
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            color: color,
            errorBuilder: (context, error, stackTrace) => getPlaceHolder(),
          );
        }
      }

      if (width != null || height != null) {
        if (color != null) {
          return Image.file(
            File(image ?? ""),
            width: width,
            height: height,
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            color: color,
          );
        } else {
          return Image.file(
            File(image ?? ""),
            width: width,
            height: height,
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
          );
        }
      } else {
        if (color != null) {
          return Image.file(
            File(image ?? ""),
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            color: color,
          );
        } else {
          return Image.file(
            File(image ?? ""),
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
          );
        }
      }
    }

    // if (image!.contains(".json")) {
    //   if (width != null || height != null) {
    //     return Lottie.asset(
    //       image ?? "",
    //       width: width,
    //       height: height,
    //       fit: boxFit!,
    //     );
    //   } else {
    //     return Lottie.asset(
    //       image ?? "",
    //       fit: boxFit!,
    //     );
    //   }
    // }

    if (image!.contains(".svg")) {
      if (width != null || height != null) {
        if (color != null) {
          return SvgPicture.asset(
            image ?? "",
            width: width,
            height: height,
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
          );
        } else {
          return SvgPicture.asset(
            image ?? "",
            width: width,
            height: height,
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
          );
        }
      } else {
        if (color != null) {
          return SvgPicture.asset(
            image ?? "",
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
            colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
          );
        } else {
          return SvgPicture.asset(
            image ?? "",
            fit: boxFit!,
            alignment: alignment ?? Alignment.center,
          );
        }
      }
    }

    if (width != null || height != null) {
      if (color != null) {
        return Image.asset(
          image ?? "",
          width: width,
          height: height,
          fit: boxFit!,
          alignment: alignment ?? Alignment.center,
          color: color,
        );
      } else {
        return Image.asset(
          image ?? "",
          width: width,
          height: height,
          fit: boxFit!,
          alignment: alignment ?? Alignment.center,
        );
      }
    } else {
      if (color != null) {
        return Image.asset(
          image ?? "",
          fit: boxFit!,
          alignment: alignment ?? Alignment.center,
          color: color,
        );
      } else {
        return Image.asset(
          image ?? "",
          fit: boxFit!,
          alignment: alignment ?? Alignment.center,
        );
      }
    }
  }

  Widget getPlaceHolder() {
    if (placeHolder!.contains("svg")) {
      return SvgPicture.asset(placeHolder ?? "");
    }

    return Image.asset(placeHolder ?? "");
  }
}
