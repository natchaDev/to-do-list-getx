import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/utils/date_utils.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/app_card.dart';

import '../../../assets/i18n/i18n_constant.dart';

class TodoItemList extends StatelessWidget {
  final String? id;
  final String? title;
  final String? status;
  final DateTime? date;
  final DateTime? createdAt;
  final String? imageBase64;
  final String? description;

  TodoItemList({
    this.id,
    this.title,
    this.status,
    this.date,
    this.createdAt,
    this.imageBase64,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textContent(context: context, title: i18n.id, content: id),
          _textContent(context: context, title: i18n.title, content: title),
          _textContent(
            context: context,
            title: i18n.status,
            content: StatusType.getName(status).tr,
          ),
          _textContent(
            context: context,
            title: i18n.description,
            content: description,
          ),
          _textContent(
            context: context,
            title: i18n.date,
            content: date != null
                ? date!.toLocal().toDateTimeString(DateTimeFormat.dmy)
                : '-',
          ),
          _textContent(
            context: context,
            title: i18n.createdAt,
            content: createdAt != null
                ? createdAt!.toLocal().toDateTimeString(DateTimeFormat.dmyHM)
                : '-',
          ),
          _imageContent(context, imageBase64),
        ],
      ),
    );
  }

  Widget _textContent({
    required BuildContext context,
    required String title,
    required String? content,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimen.xxSmall),
      child: Row(
        children: [
          Text('${title.tr}:', style: context.textSmallBold),
          HSpacings.small,
          Text(content ?? '-', style: context.textSmall),
        ],
      ),
    );
  }

  Widget _imageContent(BuildContext context, String? base64) {
    if (base64 == null) return Container();
    return Image.memory(
      base64Decode(base64 ?? ''),
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 5,
      fit: BoxFit.contain,
    );
  }
}
