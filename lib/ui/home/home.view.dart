import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/enum.dart';
import 'package:getx_mvvm_boilerplate/models/todo_detail.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/button/add_button.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/empty_content.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/main_app_bar.dart';
import 'package:getx_mvvm_boilerplate/ui/_widgets/search_and_sorting_content.dart';
import 'package:getx_mvvm_boilerplate/ui/home/_widgets/todo_item_list.dart';
import 'package:getx_mvvm_boilerplate/ui/home/home.vm.dart';

class HomeView extends BaseView<HomeVM> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData().scaffoldBackground(),
      appBar: MainAppBar(
        context: context,
        title: i18n.home,
        isRootPage: true,
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
      floatingActionButton: AddButton(
        onTap: () {
          controller.routeToCreateTodo();
        },
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        SearchAndSortingContent(
          textEditingController: _searchController,
          onSubmitted: controller.onSearchSubmitted,
          onChanged: controller.onSearchChanged,
          onSorted: (String type, bool isAscending) {
            controller.onSorted(type, isAscending: isAscending);
          },
          sortLists: const [
            SortType.none,
            SortType.title,
            SortType.date,
            SortType.status,
          ],
        ),
        Expanded(
          child: baseContent(child: _listViewContent()),
        ),
      ],
    );
  }

  Widget _listViewContent() {
    return Obx(
      () {
        List<TodoDetail> list = controller.todoDetailList.toList();
        if (list.isEmpty) return EmptyContent();
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            TodoDetail item = list[index];
            return Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.routeToTodoDetail(item.id);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Dimen.xxSmall),
                      child: TodoItemList(
                        id: item.id,
                        title: item.title,
                        status: item.status,
                        date: item.date,
                        createdAt: item.createdAt,
                        imageBase64: item.image,
                        description: item.description,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: ThemeData().alert(),
                  ),
                  onPressed: () {
                    controller.onDeleteTodo(item.id);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}
