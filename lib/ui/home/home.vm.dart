import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/get_argument_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/enum.dart';
import 'package:getx_mvvm_boilerplate/data/local_db/repositories/todo_repository.dart';
import 'package:getx_mvvm_boilerplate/models/todo_detail.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/create_todo/create_todo.binding.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/create_todo/create_todo.view.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/todo_detail/todo_detail.binding.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/todo_detail/todo_detail.view.dart';
import 'package:getx_mvvm_boilerplate/commons/utils/string_utils.dart';

import '../../commons/debouncer.dart';

class HomeVM extends BaseController {
  final RxList<TodoDetail> todoDetailList = <TodoDetail>[].obs;
  final TodoRepository _todoRepository = Get.find<TodoRepository>();
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 1500),
  );
  List<TodoDetail> _todoDetailList = [];
  bool _isAscending = true;
  String _sortType = SortType.none;

  @override
  void onInit() {
    _loadTodoDetail();
    super.onInit();
  }

  _loadTodoDetail() {
    pageState.value = PageState.LOADING;
    _todoRepository.getTodoDetailList().then((List<TodoDetail> list) {
      pageState.value = PageState.DEFAULT;
      _todoDetailList = list.toList();
      todoDetailList.value = list;
      _sort(_sortType, _isAscending);
    }).catchError((e) {
      pageState.value = PageState.DEFAULT;
      showErrorMessage(e);
    });
  }

  routeToCreateTodo() async {
    await Get.to(
      () => CreateTodoView(),
      binding: CreateTodoBinding(),
    );
    onInit();
  }

  routeToTodoDetail(String id) async {
    await Get.to(
      () => TodoDetailView(),
      arguments: {
        GetArgumentConst.id: id,
      },
      binding: TodoDetailBinding(),
    );
    onInit();
  }

  onSearchSubmitted(String text) {
    if (text.isBlank()) {
      onInit();
      return;
    }
    _search(text);
  }

  onSearchChanged(String text) {
    if (_debouncer.isActive()) _debouncer.cancel();
    if (text.isBlank()) {
      onInit();
      return;
    }
    _search(text);
  }

  _search(String text) {
    pageState.value = PageState.LOADING;
    todoDetailList.value = _filterByText(text);
    pageState.value = PageState.DEFAULT;
  }

  List<TodoDetail> _filterByText(String text) {
    text = text.trim().toLowerCase();
    return _todoDetailList.where((TodoDetail item) {
      return item.title.trim().toLowerCase().contains(text) ||
          (item.description?.trim().toLowerCase() ?? '').contains(text);
    }).toList();
  }

  onSorted(String type, {bool isAscending = true}) {
    pageState.value = PageState.LOADING;
    _sortType = type;
    _isAscending = isAscending;
    _sort(type, isAscending);
    pageState.value = PageState.DEFAULT;
  }

  _sort(String type, bool isAscending) {
    if (type == SortType.none) {
      todoDetailList.value = _todoDetailList.toList();
      pageState.value = PageState.DEFAULT;
      return;
    }
    if (isAscending) {
      todoDetailList.sort((f, s) => _comparator(type, f, s));
    } else {
      todoDetailList.sort((s, f) => _comparator(type, f, s));
    }
  }

  int _comparator(String type, TodoDetail f, TodoDetail s) {
    switch (type) {
      case SortType.title:
        return TodoDetail.titleComparator(f, s);
      case SortType.date:
        return TodoDetail.dateComparator(f, s);
      case SortType.status:
        return TodoDetail.statusComparator(f, s);
      default:
        return -1;
    }
  }
}
