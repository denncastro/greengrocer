import 'package:lab_app/src/model/category_model.dart';
import 'package:lab_app/src/model/item_model.dart';
import 'package:lab_app/src/page/constants/endpoints.dart';
import 'package:lab_app/src/page/home/result/home_result.dart';
import 'package:lab_app/src/services/http_manager.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: EndPoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result["result"] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result["result"]))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
        "Ocorreu um erro inesperado ao recuperar as categorias",
      );
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: HttpMethods.post,
      method: EndPoints.getAllProducts,
      body: body,
    );

    if (result["result"] != null) {
      List<ItemModel> data = List<Map<String, dynamic>>.from(result["result"])
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult.success(data);
    } else {
      return HomeResult.error(
        "Ocorreu um erro inesperado ao recuperar os produtos",
      );
    }
  }
}
