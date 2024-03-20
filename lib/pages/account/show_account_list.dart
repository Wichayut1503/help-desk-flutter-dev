import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/account/show_account_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/interfaces/Account/detail_account.dart';
import 'package:flutter_application_1/services/account_service.dart';
import 'package:flutter_application_1/services/global_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ShowListAccount extends StatefulWidget {
  const ShowListAccount({super.key});

  @override
  State<ShowListAccount> createState() => _ShowListAccountState();
}

class _ShowListAccountState extends State<ShowListAccount> {
  static const _pageSize = 1;

  late PagingController<int, Content> _pagingController;

  late TextEditingController searchController;
  late String hintText;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    // Initialize searchController and hintText
    searchController = TextEditingController();
    hintText = 'Search';
  }

  @override
  void dispose() {
    _pagingController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await getDataAccount(GlobalService().accessToken, pageKey);

      final isLastPage = newItems.data!.content!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data!.content!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems.data!.content!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<DetailAccount> getDataAccount(String token, int page) async {
    final response = await http.get(
      AccountService.getUserList(page, _pageSize, ""),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return DetailAccount.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to load");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'List of Accounts',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),

            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 138, 159, 171)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 0, 95, 188)),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 138, 159, 171),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: PagedListView<int, Content>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Content>(
                  itemBuilder: (context, item, index) {
                    final user = item;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShowDetailAccountPage(userId: user.id),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ListTile(
                          leading: const FlutterLogo(size: 60.0),
                          title: Text(user.fullName ?? 'Unknown'),
                          subtitle: Text(user.email ?? 'Unknown'),
                          trailing: Text(user.roleName ?? 'Unknown'),
                        ),
                      ),
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) => const Center(
                    child: Text('Something went wrong!'),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const Center(
                    child: Text('No accounts found!'),
                  ),
                  newPageProgressIndicatorBuilder: (_) =>
                      const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
