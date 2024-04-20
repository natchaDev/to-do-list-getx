import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/enum.dart';
import 'package:getx_mvvm_boilerplate/commons/helpers/file_helper.dart';
import 'package:getx_mvvm_boilerplate/commons/validator.dart';
import 'package:getx_mvvm_boilerplate/models/todo_detail.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/button/button.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/dialog/custom_dialog.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/text_field/app_text_form_field.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/main_app_bar.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/todo_detail/todo_detail.vm.dart';

import '../../../assets/i18n/i18n_constant.dart';

class TodoDetailView extends BaseView<TodoDetailVM> with Validators {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FileHelper _fileHelper = Get.find<FileHelper>();
  final _formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _initObserver();
    super.onInit();
  }

  _initObserver() {
    controller.todoDetail.listen((TodoDetail? todoDetail) {
      _titleController.text = todoDetail?.title ?? '';
      _descriptionController.text = todoDetail?.description ?? '';
    });

    controller.message.listen((String message) {
      context!.showMessageDialog(
        content: message,
        onTap: () {
          Get.back();
        },
      );
    });
  }

  _takePhoto() async {
    File? file = await _fileHelper.pickImageFromCamera();
    if (file == null) return;
    controller.onTakePhoto(file);
  }

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData().scaffoldBackground(),
      appBar: MainAppBar(
        context: context,
        title: i18n.detail,
      ).defaultAppbar,
      body: Stack(
        children: [
          _content(context),
          Obx(
            () => controller.pageState.value == PageState.LOADING
                ? loading()
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return baseContent(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextFormField(
                _titleController,
                title: i18n.title,
                isRequired: true,
                maxLine: 1,
                validatorList: [
                  Validators.required('Please enter title.'),
                  Validators.maxLength(
                    100,
                    'Please enter a maximum of 100 characters.',
                  ),
                ],
              ),
              VSpacings.small,
              _imageContent(context),
              VSpacings.small,
              _statusContent(context),
              VSpacings.small,
              AppTextFormField(
                _descriptionController,
                maxLine: 3,
                title: i18n.description,
              ),
              VSpacings.small,
              _saveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(i18n.image.tr, style: context.textSmallBold),
        VSpacings.xxSmall,
        Button(
          icon: Icon(
            Icons.image,
            size: IconSize.small,
            color: ThemeData().icon(),
          ),
          title: i18n.select,
          onPressed: () {
            _takePhoto();
          },
        ),
        Obx(
          () {
            String? imageBase64 = controller.todoDetail.value?.image;
            if (imageBase64 == null) return Container();
            return Container(
              margin: EdgeInsets.only(top: Dimen.small),
              child: Image.memory(
                base64Decode(imageBase64 ?? ''),
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 5,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _statusContent(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: RadioListTile<String>(
              title: Text(
                i18n.inProgress.tr,
                style: context.textSmall,
              ),
              value: StatusType.inProgress,
              groupValue: controller.selectedStatus.value,
              onChanged: (String? value) {
                controller.onSelectedStatus(value);
              },
            ),
          ),
          Expanded(
            child: RadioListTile<String>(
              title: Text(
                i18n.completed.tr,
                style: context.textSmall,
              ),
              value: StatusType.complete,
              groupValue: controller.selectedStatus.value,
              onChanged: (String? value) {
                controller.onSelectedStatus(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Button(
      width: MediaQuery.of(context).size.width,
      title: i18n.save,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          controller.onSave(
            title: _titleController.text,
            description: _descriptionController.text,
          );
        }
      },
    );
  }
}
