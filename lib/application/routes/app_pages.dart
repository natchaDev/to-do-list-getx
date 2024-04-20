import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/home/home.binding.dart';
import 'package:getx_mvvm_boilerplate/ui/home/home.view.dart';
import 'package:getx_mvvm_boilerplate/ui/splash_screen/splash_screen.view.dart';
import 'package:getx_mvvm_boilerplate/ui/splash_screen/splash_screen.vm.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/create_todo/create_todo.binding.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/create_todo/create_todo.view.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/todo_detail/todo_detail.binding.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/todo_detail/todo_detail.view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: _Paths.splashScreen,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.createTodo,
      page: () => CreateTodoView(),
      binding: CreateTodoBinding(),
    ),
    GetPage(
      name: _Paths.todoDetail,
      page: () => TodoDetailView(),
      binding: TodoDetailBinding(),
    ),
  ];
}
