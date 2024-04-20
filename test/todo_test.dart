import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/binding/initial_binding.dart';
import 'package:getx_mvvm_boilerplate/application/env.dart';
import 'package:getx_mvvm_boilerplate/application/mock_path_provider.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/table_constant.dart';
import 'package:getx_mvvm_boilerplate/data/local_db/repositories/todo_repository.dart';
import 'package:getx_mvvm_boilerplate/models/todo_detail.dart';
import 'package:getx_mvvm_boilerplate/ui/home/home.vm.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = FakePathProviderPlatform();
  EnvironmentConfig environmentConfig = DevLocalEnvironment();
  InitialBinding(environmentConfig).dependencies();
  TodoRepository todoRepository = Get.find<TodoRepository>();

  group('TodoRepository: Delete All', () {
    test('deleteAll()', () async {
      expect(
        () async => await todoRepository.deleteAll(),
        isA<void>(),
      );
    });
  });

  setUp(() {
    Future<void> putItem1 = todoRepository.put(
        todoDetail: TodoDetail(
      '1',
      'item 1',
      DateTime.now().toUtc(),
      StatusType.inProgress,
      'description 1',
      null,
    ));
    Future<void> putItem2 = todoRepository.put(
        todoDetail: TodoDetail(
      '2',
      'item 2',
      DateTime.now().add(const Duration(hours: 1)).toUtc(),
      StatusType.complete,
      'description 2',
      null,
    ));
    Future<void> putItem3 = todoRepository.put(
        todoDetail: TodoDetail(
      '3',
      'item 3',
      DateTime.now().add(const Duration(hours: 1)).toUtc(),
      StatusType.inProgress,
      'description 3',
      null,
    ));
    return Future.wait([putItem1, putItem2, putItem3]);
  });

  group('TodoRepository', () {
    test('getTodoDetailList(): isNotEmpty', () async {
      List<TodoDetail> list = await todoRepository.getTodoDetailList();
      expect(true, list.isNotEmpty);
    });

    test('getTodoDetail(): is not null', () async {
      TodoDetail? result = await todoRepository.getTodoDetail('1');
      expect(true, result != null);
    });

    test('getTodoDetail(): is null', () async {
      TodoDetail? result = await todoRepository.getTodoDetail('4');
      expect(true, result == null);
    });
  });

  group("Home View model", () {
    HomeVM homeVM = Get.put<HomeVM>(HomeVM());

    setUp(() {
      homeVM.onInit();
    });

    List<TodoDetail> mock = [
      TodoDetail(
        '1',
        'item 1',
        DateTime.now().toUtc(),
        StatusType.inProgress,
        'description 1',
        null,
      ),
      TodoDetail(
        '2',
        'item 2',
        DateTime.now().add(const Duration(hours: 1)).toUtc(),
        StatusType.complete,
        'description 2',
        null,
      ),
      TodoDetail(
        '3',
        'item 3',
        DateTime.now().add(const Duration(hours: 1)).toUtc(),
        StatusType.inProgress,
        'description 3',
        null,
      ),
    ];

    group('Search', () {
      test('onSearchChanged()', () async {
        homeVM.onSearchChanged('item 1');
        String expectTitle = 'item 1';
        String? result = homeVM.todoDetailList
            .firstWhereOrNull((item) => item.title == expectTitle)
            ?.title;
        expect(expectTitle, result);
      });

      test('onSearchSubmitted()', () async {
        homeVM.onSearchSubmitted('description 2');
        String expectDescription = 'description 2';
        String? result = homeVM.todoDetailList
            .firstWhereOrNull((item) => item.description == expectDescription)
            ?.description;
        expect(expectDescription, result);
      });
    });

    group('Sort', () {
      mock.shuffle();
      test('Sort by title', () {
        List<String> expectResults = [
          'item 1',
          'item 2',
          'item 3',
        ];
        homeVM.onSorted(SortType.title);
        expect(expectResults,
            homeVM.todoDetailList.map((item) => item.title).toList());
      });

      test('Sort by date', () {
        List<String> expectResults = [
          '1',
          '2',
          '3',
        ];
        homeVM.onSorted(SortType.date);
        expect(expectResults,
            homeVM.todoDetailList.map((item) => item.id).toList());
      });

      test('Sort by status', () {
        List<String> expectResults = [
          '2',
          '1',
          '3',
        ];
        homeVM.onSorted(SortType.status);
        var results = homeVM.todoDetailList.map((item) => item.id).toList();
        expect(expectResults, results);
      });

      test('Sort by status', () {
        List<String> expectResults = [
          '1',
          '2',
          '3',
        ];
        homeVM.onSorted(SortType.none);
        var results = homeVM.todoDetailList.map((item) => item.id).toList();
        expect(expectResults, results);
      });
    });
  });

  group('TodoRepository: Delete Todo', () {
    test('deleteByKey()', () async {
      expect(
        () async => await todoRepository.deleteByKey(
          key: '1',
          boxName: BoxName.todo,
        ),
        isA<void>(),
      );
    });
  });
}
