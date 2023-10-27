import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/search_controller/search_controller.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/mini_player_screen/miniplayer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchControllerT searchController = Get.put(SearchControllerT());
    return GetBuilder<SearchControllerT>(
        init: SearchControllerT(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  onChanged: (value) {
                    searchController.searchT(value);
                    searchController.isCloseButtonVisible = value.isNotEmpty;
                  },
                  controller: searchController.searchEditingController,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: Visibility(
                          visible: searchController.isCloseButtonVisible,
                          child: IconButton(
                              onPressed: () {
                                searchController.searchEditingController
                                    .clear();
                                searchController.isCloseButtonVisible = false;
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              )))),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10, top: 7),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              backgroundColor: Colors.black,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: searchController.searchdata,
                      builder: (context, value, child) => searchController
                                  .searchEditingController.text.isEmpty ||
                              searchController.searchEditingController.text
                                  .trim()
                                  .isEmpty
                          ? searchController.searchFun(context)
                          : searchController.searchdata.value.isEmpty
                              ? searchController.searchEmpty()
                              : searchController.searchFound(context),
                    ),
                  ),
                  globalController.isMiniPlayerVisible
                      ? const MiniPlayer()
                      : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }
}
