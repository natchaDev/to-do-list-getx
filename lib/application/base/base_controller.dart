import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/commons/enum.dart';

abstract class BaseController extends GetxController {

  final Rx<PageState> pageState = PageState.DEFAULT.obs;

  final Rx<String> message= ''.obs;

  updatePageState(PageState state) => pageState(state);

  resetPageState() => pageState(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  showMessage(String msg) => message(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  showErrorMessage(String msg) {
    _errorMessageController(msg);
  }

  final _successMessageController = ''.obs;

  String get successMessage => message.value;

  showSuccessMessage(String msg) => _successMessageController(msg);

  @override
  void onClose() {
    message.close();
    pageState.close();
    super.onClose();
  }
}
