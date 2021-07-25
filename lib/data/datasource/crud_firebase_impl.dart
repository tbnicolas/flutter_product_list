

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_product_list/domain/model/product_model.dart';
import 'package:flutter_product_list/domain/repository/product_repository.dart';

class CrudFirebaseImpl extends ProductRepositoryInterface {
  
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /* Se leen y se mantiene escuchando el flujo de datos de la coleccion 'productList' */

  @override
  Stream getAllProducts() {
   return _db.collection('productList').snapshots();
  }

  /* Se añade O Actualizamos un producto a FireStore */

  @override
  Future addProduct(Product product) async{
    return await  _db.collection('productList').doc(product.id).set(product.toJson());
  }

  /* Se Borra un producto de FireStore */

  @override
  Future deleteProduct(String docId) async {
    return await _db.collection('productList')
    .doc(docId)
    .delete();
  }

}