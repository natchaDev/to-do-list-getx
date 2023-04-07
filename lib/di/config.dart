import 'package:dio/dio.dart';

import '../application/env.dart';
import '../commons/data/mock_data_loader.dart';
import '../commons/helpers/media_query_helper.dart';
import '../data/preferences/user_preference.dart';
import '../data/repositories/api_repository.dart';
import '../data/services/api_service.dart';
import '../data/services/base_service/base_service.dart';
import 'container.dart';

extension DefaultSetting on DiContainer {
  DiContainer withDefaultDependencies() {
    // === Repository ===
    singletonFactory<ApiRepository>((c) {
      return ApiRepository();
    });

    // === Service ===
    singletonFactory<BaseService>((c) {
      return BaseService(c.get<EnvironmentConfig>());
    });

    singletonFactory<ApiService>((c) {
      return ApiService();
    });

    // === Preference ===
    singletonFactory<UserPreference>((_) {
      return UserPreference();
    });

    // === Core Framework ===
    singletonFactory<MediaQueryHelper>((_) {
      return MediaQueryHelper();
    });

    singletonFactory<MockDataLoader>((_) {
      return MockDataLoader();
    });

    // === Third-Party ===
    singletonFactory<Dio>((_) {
      return Dio();
    });

    return this;
  }
}
