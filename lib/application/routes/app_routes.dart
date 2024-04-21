part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const createTodo = _Paths.createTodo;
  static const todoDetail = _Paths.todoDetail;
}

abstract class _Paths {
  static const home = '/home';
  static const createTodo = '/createTodo';
  static const todoDetail = '/todoDetail';
}