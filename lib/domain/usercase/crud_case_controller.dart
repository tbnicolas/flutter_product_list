
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

  /* Aqui se pasa la lista que viene de la base de datos a el modelo producto para mas comodidad a la hora de trabajar con la misma */

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

  /* Se asigna y notifica todos los cambios en los campos que aparecen en crear y actualizar */

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

  /* Luego de utilizar el metodo de crear o de actualizar se limpia la propiedad de product como manera de evitar crear o actualizar algo que no se desea  */
  void clearFields(){
    
    this._product = new Product();
    //notifyListeners();

  }

  /*  Con este metodo se muestra se rellenan los campos en la vista de actualizar */

  void loadData(Product product){
    this._productStatus = ProductStatus.Uncreated;
    this._product = product;
    notifyListeners();
  }

  /*  Aqui se valida con el fin de crear una unica instacia de la clase product */

  void productExist(){
    if( this._product == null ){
      this._product = new Product();
    }
  }


  /* Al usar el metodo se crea un producto con los datos que ya han sido recolectados a traves del manejador de estado */  

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

  /* Al usar el metodo se actualiza un producto con los datos que ya han sido recolectados a traves del manejador de estado */  


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

  /*  Con este metodo se elimina un producto de la lista no es necesario el uso del async-await ya que no es necesario detener la cola de tareas 
      Ya que visualmente se elimina con el widget Dissmisable lo que le da la sensacion al usuario final de que ya se elimino aunque en realidad tarte un par
      de milisegundos mas en borrarlo de la base de datos 
   */

  Future handleDeleteProduct(String id) {
    return this.productRepositoryInterface.deleteProduct(id);
  }

  
}