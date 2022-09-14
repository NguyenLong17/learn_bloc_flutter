import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/category/category_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryCubit _categoryCubit = CategoryCubit();

  @override
  void initState() {
    // TODO: implement initState
    _categoryCubit.createListCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Page'),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (_, state) {
          if (_categoryCubit.listCategory.isEmpty) {
            return Center(
              child: Text('Dang lay du lieu'),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 160,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return CategoryItem(categoryModel: _categoryCubit.listCategory[index]);
              },itemCount: _categoryCubit.listCategory.length,);
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryItem({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          categoryModel.urlPicture ?? '',
          width: 100,
          height: 100,
        ),
        Text(categoryModel.name ?? ''),
      ],
    );
  }
}
