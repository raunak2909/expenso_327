import 'package:expense_app_ui/data/local/model/cat_model.dart';

class AppConstants{

  static const String APP_NAME = "Monety";

  static List<CatModel> mCat = [
    CatModel(id: 1, title: "Coffee", imgPath: "asset/icons/coffee.png"),
    CatModel(id: 2, title: "FastFood", imgPath: "asset/icons/fast-food.png"),
    CatModel(id: 3, title: "Gift", imgPath: "asset/icons/gift-box.png"),
    CatModel(id: 4, title: "Grocery", imgPath: "asset/icons/ic_grocery.png"),
    CatModel(id: 5, title: "Shopping", imgPath: "asset/icons/ic_shopping.png"),
    CatModel(id: 6, title: "Bill/Recharge", imgPath: "asset/icons/mobile-transfer.png"),
    CatModel(id: 7, title: "Petrol", imgPath: "asset/icons/vehicles.png"),
  ];
}