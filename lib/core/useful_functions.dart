// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/enums.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/core/padding_borders.dart';
import 'package:kan_lazim/models/request_model.dart';
import 'package:kan_lazim/services/firebase_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

String trimToText(String text) {
  return text.trim();
}

Color getUgencyColor(String ugency) {
  if (ugency == BloodUgency.Acil.name) {
    return ColorsConstant.red;
  } else if (ugency == BloodUgency.Orta.name) {
    return Colors.yellow.shade700;
  } else if (ugency == BloodUgency.Bekleyebilir.name) {
    return Colors.green;
  } else {
    return Colors.grey;
  }
}

Future<void> browser(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

// Container requestCard({required BuildContext context, required RequestModel item, required bool isOwnerPage, Function(bool state)? isRemoved}) {
//   return
// }

class RequestCard extends StatefulWidget {
  const RequestCard({
    super.key,
    required this.item,
    required this.isOwnerPage,
    this.isRemoved,
  });
  final RequestModel item;
  final bool isOwnerPage;
  final Function(bool state)? isRemoved;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _takeScreenshotAndShare() async {
    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();

        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/screenshot.png').create();
        await file.writeAsBytes(pngBytes);

        await Share.shareXFiles([XFile(file.path)], text: '${widget.item.name} adına kan bağışına ihtiyacımız var!');
      }
    } catch (e) {
      print('Error taking screenshot: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        height: context.deviceHeight * 0.35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: PaddingBorderConstant.borderRadius, border: Border.all(color: Colors.red)),
        margin: PaddingBorderConstant.paddingVertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: PaddingBorderConstant.paddingOnlyTop,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: PaddingBorderConstant.paddingOnlyLeft,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 100,
                          alignment: Alignment.center,
                          width: context.deviceHeight * 0.2,
                          decoration:
                              BoxDecoration(color: Colors.red.shade100, borderRadius: PaddingBorderConstant.borderRadius),
                        ),
                        Column(
                          children: [
                            Text(
                              widget.item.bloodType ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            Text(
                              "${widget.item.unitAmount?.toInt()} Ünite",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade800),
                            )
                          ],
                        ),
                        const Positioned(
                            top: -5,
                            left: -5,
                            child: Icon(
                              Icons.water_drop_rounded,
                              color: Colors.red,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                        title: Text(
                          widget.item.title ?? "",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person_2_outlined,
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  widget.item.name ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${widget.item.city} / ${widget.item.district}",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.local_hospital_outlined,
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  widget.item.hospital ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          )
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: () async {
                          if (widget.isOwnerPage) {
                            await FirebaseService().removeRequest(widget.item);
                            widget.isRemoved?.call(true);
                          } else {
                            await _takeScreenshotAndShare();
                          }
                        },
                        child: Icon(
                          widget.isOwnerPage ? Icons.cancel_outlined : Icons.share,
                          color: widget.isOwnerPage ? Colors.red : Colors.red,
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: PaddingBorderConstant.paddingHorizontalLow,
              child: Text(maxLines: 2, overflow: TextOverflow.ellipsis, widget.item.description ?? ""),
            ),
            const Spacer(),
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }
}
