import 'package:get/get.dart';
import 'package:lab_app/src/model/category_model.dart';
import 'package:lab_app/src/model/item_model.dart';
import 'package:lab_app/src/page/home/repository/home_repository.dart';
import 'package:lab_app/src/page/home/result/home_result.dart';
import 'package:lab_app/src/services/utils_services.dart';

int itensPerPage = 6;

class HomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  List<CategoryModel> allCategories = [];
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  CategoryModel? currentCategory;

  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;

    update();
  }

  @override
  onInit() {
    super.onInit();

    getAllCategories();
  }

  selectCategories(CategoryModel categories) {
    currentCategory = categories;
    update();

    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        selectCategories(allCategories.first);
      },
      error: (message) {
        utilsServices.showToast(
          label: message,
        );
      },
    );
  }

  Future<void> getAllProducts() async {
    setLoading(true);

    Map<String, dynamic> body = {
      "page": currentCategory!.pagination,
      "categoryId": "aGN3NQKlXp",
      "itemsPerPage": itensPerPage,
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false);

    result.when(
      success: (data) {
        // currentCategory!.items = data;
        print("Funcionou? $data");
      },
      error: (message) {
        utilsServices.showToast(label: message);
      },
    );
  }
}
