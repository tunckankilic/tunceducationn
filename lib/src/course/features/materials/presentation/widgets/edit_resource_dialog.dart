import 'package:tunceducationn/core/common/widgets/info_field.dart';
import 'package:tunceducationn/src/course/features/materials/domain/entities/picked_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditResourceDialog extends StatefulWidget {
  const EditResourceDialog(this.resource, {super.key});

  final PickedResource resource;

  @override
  State<EditResourceDialog> createState() => _EditResourceDialogState();
}

class _EditResourceDialogState extends State<EditResourceDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.resource.title.trim();
    descriptionController.text = widget.resource.description.trim();
    authorController.text = widget.resource.author.trim();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoField(
                controller: titleController,
                border: true,
                hintText: 'Title',
              ),
              SizedBox(height: 10.h),
              InfoField(
                controller: descriptionController,
                border: true,
                hintText: 'Description',
              ),
              SizedBox(height: 10.h),
              InfoField(
                controller: authorController,
                border: true,
                hintText: 'Author',
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final newResource = widget.resource.copyWith(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        author: authorController.text.trim(),
                        authorManuallySet: authorController.text.trim() !=
                            widget.resource.author,
                      );
                      Navigator.pop(context, newResource);
                    },
                    child: Text('Confirm'),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
