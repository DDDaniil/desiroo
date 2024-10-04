import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:flutter/material.dart';

class WishlistGridItem extends StatelessWidget {
  const WishlistGridItem({
    super.key,
    required this.name,
    this.imageUrl,
    this.onTap,
    this.onLongPress,
  });

  final String name;
  final String? imageUrl;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.0),
      onLongPress: onLongPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(StyledConstants.borderRadius),
              child: AspectRatio(
                aspectRatio: 1,
                child: imageUrl != null
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrl!,
                        placeholder: (context, url) => Container(
                          color: StyledConstants.colorDivider,
                          padding: const EdgeInsets.all(30),
                          child: const CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                            color: StyledConstants.colorPrimary,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            transform: GradientRotation(
                                Random().nextInt(180) * pi / 180),
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color((Random().nextDouble() * 0xFFFFAF).toInt())
                                  .withOpacity(.4),
                              Color((Random().nextDouble() * 0xFFFFAF).toInt())
                                  .withOpacity(.4)
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: StyledConstants.edgeInsetsVertical,
              left: 4
            ),
            child: Text(
              name,
              style: StyledConstants.mainTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
