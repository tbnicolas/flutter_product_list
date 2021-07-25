
import 'package:flutter/material.dart';
import 'package:flutter_product_list/domain/model/product_model.dart';
import 'package:flutter_product_list/domain/repository/product_repository.dart';
import 'package:flutter_product_list/domain/validator/validator.dart';


enum ProductStatus{
  UnLoaded,
  Uncreated,
  Loading,
  Created,
  Error
}


class CrudCaseController extends ChangeNotifier with Validator{

  final ProductRepositoryInterface productRepositoryInterface;
  
  List<Product> _allPrducts;
  Product _product;
  ProductStatus _productStatus = ProductStatus.Uncreated;

  List<Product> get allProducts => this._allPrducts;
  Product get product => this._product;
  ProductStatus get productStatus => this._productStatus;


  CrudCaseController({ this.productRepositoryInterface });

  Stream handleGetProducts() => this.productRepositoryInterface.getAllProducts();

  set allProducts(List list){
    this._allPrducts = [];
    list.forEach((item) {
        this._allPrducts.add(
          new Product(
            name: item.data()['name'],
            description: item.data()['description'],
            price: item.data()['price'],
            stock: item.data()['stock'],
            id: item.data()['id']
          )
        );
        
     });
    
  }

  void changeName( String name ){
    productExist();
    this._product.name = name ?? '';
    notifyListeners();
  }

  void changeDescription( String description ){
    productExist();
    this._product.description = description ?? '';
    notifyListeners();
  }

  void changePrice( int price ){
    productExist();
    this._product.price = price ?? 0;
    notifyListeners();
  }

  void changeStock( int stock ){
    productExist();
    this._product.stock = stock ?? 0;
    notifyListeners();
  }
  void changeId(){
    productExist();
    this._product.id= DateTime.now().millisecondsSinceEpoch.toString();
    notifyListeners();
  }

  void clearFields(){
    
    this._product = new Product();
    //notifyListeners();

  }

  void loadData(Product product){
    this._productStatus = ProductStatus.Uncreated;
    this._product = product;
    notifyListeners();
  }

  void productExist(){
    if( this._product == null ){
      this._product = new Product();
    }
  }

  

  Future<ProductStatus> handleCreateProduct() async {
    try {
      this._productStatus = ProductStatus.Loading;
      notifyListeners();

      await this.productRepositoryInterface.addProduct(this._product);
      this._productStatus = ProductStatus.Created;
      
      clearFields();

      notifyListeners();
      

      return _productStatus;
    } catch (e) {
      this._productStatus = ProductStatus.Error;
      notifyListeners();

      return _productStatus;
    }
  }
  Future<ProductStatus> handleUpdateProduct() async {
    try {
      this._productStatus = ProductStatus.Loading;
      notifyListeners();

      await this.productRepositoryInterface.addProduct(this._product);
      this._productStatus = ProductStatus.Created;

      clearFields();

      notifyListeners();


      return _productStatus;
    } catch (e) {
      this._productStatus = ProductStatus.Error;
      notifyListeners();

      return _productStatus;
    }
  }
  Future handleDeleteProduct(String id) {
    return this.productRepositoryInterface.deleteProduct(id);
  }

  
}