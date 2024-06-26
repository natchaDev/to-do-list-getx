import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetDynamicUtils;
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';
import 'package:getx_mvvm_boilerplate/models/rx_nullable.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';
import 'package:getx_mvvm_boilerplate/commons/utils/list_utils.dart';

class SearchAndSortingContent extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String text) onSubmitted;
  final Function(String text) onChanged;
  final Function(String sort, bool isAscending)? onSorted;
  final List<String>? sortLists;

  const SearchAndSortingContent({
    Key? key,
    required this.textEditingController,
    required this.onSubmitted,
    required this.onChanged,
    this.onSorted,
    this.sortLists,
  }) : super(key: key);

  @override
  State<SearchAndSortingContent> createState() =>
      _SearchAndSortingContentState();
}

class _SearchAndSortingContentState extends State<SearchAndSortingContent> {
  final RxBool _isAscending = true.obs;
  final Rx<String?> _selectedSort = RxNullable<String?>().setNull();
  final _layerLink = LayerLink();
  OverlayEntry? _entry;

  @override
  void dispose() {
    _hideOverlay();
    _selectedSort.close();
    _isAscending.close();
    super.dispose();
  }

  double _getOverlayHeight() {
    double height = MediaQuery.of(context).size.height / 2;
    return height * (widget.sortLists?.length ?? 1);
  }

  _showOverlay() {
    _hideOverlay();
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              _hideOverlay();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.bottomCenter,
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: _getOverlayHeight(),
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(-36, 56),
              child: _buildOverlay(),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_entry!);
  }

  _hideOverlay() {
    _entry?.remove();
    _entry = null;
  }

  IconData _getIcons(String title, String? selectedSort, bool isAscending) {
    if (title == selectedSort) {
      return isAscending ? Icons.arrow_upward : Icons.arrow_downward;
    } else {
      return Icons.arrow_upward;
    }
  }

  Widget _selectSort(
    String title, {
    required String? selectedSort,
    required bool isAscending,
    required Function onTap,
    bool isLast = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Padding(
            padding: EdgeInsets.all(Dimen.xxxSmall),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: context.textMediumNormal.copyWith(
                      color: selectedSort == title
                          ? ThemeData().primary()
                          : ThemeData().primaryText(),
                    ),
                  ),
                ),
                Visibility(
                  visible: title == SortType.none,
                  child: Text(
                    '(${i18n.defaultStr.tr})',
                    style: context.textMediumNormal.copyWith(
                      color: ThemeData().secondaryText(),
                    ),
                  ),
                ),
                Visibility(
                  visible: title != SortType.none,
                  child: Icon(
                    _getIcons(title, selectedSort, isAscending),
                    color: ThemeData().icon(),
                    size: IconSize.small,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: !isLast,
          child: const Divider(thickness: 1),
        )
      ],
    );
  }

  Widget _buildOverlay() {
    if (widget.sortLists.isBlank) return const SizedBox.shrink();
    List<String> sortingLists = widget.sortLists!;
    return Material(
      elevation: 8,
      color: ThemeData().background2(),
      child: Padding(
        padding: EdgeInsets.all(Dimen.small),
        child: Obx(() {
          String? selectedSort = _selectedSort.value;
          bool isAscending = _isAscending.value;
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: sortingLists.length,
            itemBuilder: (BuildContext context, int index) {
              String item = sortingLists[index];
              return _selectSort(
                item,
                selectedSort: selectedSort,
                isAscending: isAscending,
                onTap: () {
                  if (widget.onSorted == null) return;
                  if (_selectedSort.value == item && item != SortType.none) {
                    _isAscending.toggle();
                  } else {
                    _isAscending.value = true;
                  }
                  _selectedSort.value = item;
                  widget.onSorted?.call(item, _isAscending.value);
                  _hideOverlay();
                },
                isLast: index == sortingLists.length - 1,
              );
            },
          );
        }),
      ),
    );
  }

  Widget _sortingButton({required Function() onTap}) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ThemeData().primary(),
        ),
        width: 46,
        height: 46,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 3),
          child: Icon(
            Icons.sort,
            color: ThemeData().icon(),
          ),
        ),
      ),
      onTap: () {
        onTap.call();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: Dimen.medium,
            right: Dimen.medium,
            top: Dimen.small,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  height: 44,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    color: ThemeData().background2(),
                    borderRadius: AppBorderRadius.large,
                  ),
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: TextField(
                      controller: widget.textEditingController,
                      textInputAction: TextInputAction.go,
                      onChanged: (text) {
                        widget.onChanged(text);
                      },
                      onSubmitted: (text) {
                        widget.onSubmitted(text);
                      },
                      decoration: InputDecoration(
                        hintText: i18n.search.tr,
                        hintStyle: context.textSmall
                            .copyWith(color: ThemeData().secondaryText()),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: ThemeData().background2(),
                        suffixIcon: InkWell(
                          onTap: () {
                            widget.textEditingController.clear();
                            widget.onChanged('');
                          },
                          child: Icon(
                            Icons.close,
                            color: ThemeData().primary(),
                            size: IconSize.medium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Dimen.xxSmall),
                child: _sortingButton(
                  onTap: () {
                    _showOverlay();
                  },
                ),
              ),
            ],
          ),
        ),
        VSpacings.medium,
        const Divider(
          height: 0,
          thickness: 1.50,
        ),
      ],
    );
  }
}
