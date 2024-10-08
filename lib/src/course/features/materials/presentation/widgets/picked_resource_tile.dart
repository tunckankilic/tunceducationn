import 'package:tunceducationn/core/res/media_res.dart';
import 'package:tunceducationn/src/course/features/materials/domain/entities/picked_resource.dart';
import 'package:tunceducationn/src/course/features/materials/presentation/widgets/picked_resource_horizontal_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickedResourceTile extends StatelessWidget {
  const PickedResourceTile(
    this.resource, {
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final PickedResource resource;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image.asset(MediaRes.material),
            ),
            title: Text(
              resource.path.split('/').last,
              maxLines: 1,
            ),
            contentPadding: EdgeInsets.only(left: 16.r, right: 5.r),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
                IconButton(onPressed: onDelete, icon: Icon(Icons.close)),
              ],
            ),
          ),
          Divider(height: 1),
          PickedResourceHorizontalText(label: 'Author', value: resource.author),
          PickedResourceHorizontalText(label: 'Title', value: resource.title),
          PickedResourceHorizontalText(
            label: 'Description',
            value: resource.description.trim().isEmpty
                ? '"None"'
                : resource.description,
          ),
        ],
      ),
    );
  }
}
