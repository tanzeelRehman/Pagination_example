// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:paggination_practice/products_response_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  //! Properties ==============================================================================================
  // ignore: non_constant_identifier_names
  final _base_url =
      'http://20.212.227.60:3007/api/v1/notificaion/userNotification?';
  int _page = 1;
  bool isMoreDataLoading = false;

  //! PRODUCT LIST
  List<Data> products = [];

  //* PUBLIC FUNCTIONS ======================================================================================================

  Future<void> fetchProducts() async {
    var product = await _callAPI();
    products = product!.data;
    _page = _page + 1;
    notifyListeners();
  }

  Future<void> fetchMoreProducts() async {
    if (isMoreDataLoading) return;
    _toggleisMoreDataLoading();
    var product = await _callAPI();
    if (products.isNotEmpty) {
      _page = _page + 1;
      products.addAll(product!.data);
      _toggleisMoreDataLoading();
      print("Already have the data");
    }
  }

  Future refresh() async {
    isMoreDataLoading = false;
    _page = 1;
    products.clear();
    await fetchProducts();
    notifyListeners();
  }

  //* API CALLS ======================================================================================================

  Future<ProductsResponseModel?> _callAPI() async {
    try {
      final response = await http.get(Uri.parse('${_base_url}page=$_page'));
      print(Uri.parse('${_base_url}page=$_page'));
      if (response.statusCode == 200) {
        final json = response.body;
        print(json);
        var product = ProductsResponseModel.fromJson(jsonDecode(json));
        print("Product length is ${products.length}");
        return product;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  //* LOADER FUNCTIONS ===================================================================
  //? Function to change bool value in to true or false
  //! !true== false
  void _toggleisMoreDataLoading() {
    isMoreDataLoading = !isMoreDataLoading;
    notifyListeners();
  }
}
