import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/src/course/features/materials/presentation/app/providers/resource_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResourceTile extends StatelessWidget {
  const ResourceTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ResourceController>(
      builder: (_, controller, __) {
        final resource = controller.resource!;
        final authorIsNull =
            resource.author == null || resource.author!.isEmpty;
        final descriptionIsNull =
            resource.description == null || resource.description!.isEmpty;

        final downloadButton = controller.downloading
            ? CircularProgressIndicator(
                value: controller.percentage,
                color: Colours.primaryColour,
              )
            : IconButton.filled(
                onPressed: controller.fileExists
                    ? controller.openFile
                    : controller.downloadAndSaveFile,
                icon: Icon(
                  controller.fileExists
                      ? Icons.download_done_rounded
                      : Icons.download_rounded,
                ),
              );
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: EdgeInsets.symmetric(horizontal: 10.w),
          title: Text(
            resource.title!,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (authorIsNull && descriptionIsNull) downloadButton,
                if (!authorIsNull)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Author',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(resource.author!),
                          ],
                        ),
                      ),
                      downloadButton,
                    ],
                  ),
                if (!descriptionIsNull)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!authorIsNull) SizedBox(height: 10.h),
                            Text(
                              'Description',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(resource.description!),
                          ],
                        ),
                      ),
                      if (authorIsNull) downloadButton,
                    ],
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
