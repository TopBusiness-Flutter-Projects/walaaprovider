import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/features/addproduct/presentation/cubit/add_product_cubit.dart';

class DropDownCategory extends StatefulWidget {
  final List<CategoryModel> items ;

   DropDownCategory({Key? key, required this.items}) : super(key: key);

  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  @override
   CategoryModel categoryModel=CategoryModel.name(0, '', '');

  @override
  Widget build(BuildContext context) {
    selectcategory();
    return
     Container(
       width: double.infinity-30,
       child: DropdownButtonHideUnderline(

            child: DropdownButton2(
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(

                  'Select Category'.tr(),
                  style: TextStyle(
                    fontSize: 14,

                    color: Theme
                        .of(context)
                        .hintColor,
                  ),
                ),
              ),

              items: widget.items.isNotEmpty? widget.items
                  .map((item) =>
                  DropdownMenuItem<CategoryModel>(
                    value: item,
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList():null,

              value:categoryModel.id!=0?categoryModel:null,
              onChanged: (value) {
                setState(() {
                  categoryModel = value as CategoryModel;
                  context.read<AddProductCubit>().addProductModel.cat_id=categoryModel.id;
                  context.read<AddProductCubit>().checkValidData();

                });
              },
              buttonHeight: 40,
              buttonWidth: 140,
              itemHeight: 40,
            ),
          ),
     )

    ;
  }

  void selectcategory() {
    if(context.read<AddProductCubit>().addProductModel.cat_id!=0){
    widget.items.forEach(
          (element) {
        if (context.read<AddProductCubit>().addProductModel.cat_id!=0&&element.id == context.read<AddProductCubit>().addProductModel.cat_id) {
         categoryModel=element;
         setState(() {
           categoryModel;
         });
        }
      },
    );
  }

  }


}
