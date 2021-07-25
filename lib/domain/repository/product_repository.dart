

import 'package:flutter_product_list/domain/model/product_model.dart';

abstract class ProductRepositoryInterface {
  
  Stream getAllProducts();
  Future addProduct(Product product);
  Future deleteProduct(String docId);
}