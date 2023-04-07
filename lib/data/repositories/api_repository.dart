import '../../di/container.dart';
import '../services/api_service.dart';

class ApiRepository {
  final ApiService _service = inject<ApiService>();
}
