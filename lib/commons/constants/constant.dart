import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';

class ClientKeyPath {
  static const demo = 'demo_client_key';
  static const dev = 'dev_client_key';
  static const devLocal = 'dev_local_client_key';
  static const production = 'production_client_key';
}

class ServerType {
  static const demo = 'Demo';
  static const dev = 'Dev';
  static const devLocal = 'Dev Local';
  static const production = 'Production';
}

class StatusType {
  static const inProgress = 'in_progress';
  static const complete = 'completed';

  static String getName(String? status){
    switch(status) {
      case StatusType.inProgress: return i18n.inProgress;
      case StatusType.complete: return i18n.completed;
      default: return '';
    }
  }
}

class DateTimeFormat {
  static const dmyHM = 'd/MM/y H:mm';
}

class SortType {
  static const String none = 'None';
  static const String title = 'Title';
  static const String date = 'Date';
  static const String status = 'Status';
}
