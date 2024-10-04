import 'dart:io';

import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StyledProductCard extends StatefulWidget {
  const StyledProductCard({
    super.key,
    required this.name,
    required this.importance,
    required this.price,
    required this.photoPath,
    this.onTap,
  });

  final String name;
  final String importance;
  final String price;
  final String photoPath;
  final Function()? onTap;

  @override
  State<StyledProductCard> createState() => _StyledProductCardState();
}

class _StyledProductCardState extends State<StyledProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        height: 114,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1),
                  Text(
                    style: Theme.of(context).textTheme.bodySmall,
                    'Importance: ${widget.importance}',
                    overflow: TextOverflow.ellipsis,
                  ),Text(
                    style: Theme.of(context).textTheme.bodySmall,
                    'Price: ${widget.price}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 5 / 3,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(StyledConstants.borderRadius),
                  child: Image.file(
                    File(widget.photoPath),
                    fit: BoxFit.cover,
                  ),
                  /*child: Image.asset(widget.photoPath,
                      fit: BoxFit.cover),*/
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
