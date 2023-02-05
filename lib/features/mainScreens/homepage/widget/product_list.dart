import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';
import 'package:walaaprovider/features/mainScreens/homepage/widget/product_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit homeCubit =context.read<HomeCubit>();

      print(homeCubit.productLength);
      List<ProductModel> list=[];
      if(homeCubit.productList.isNotEmpty){
      list = homeCubit.productList;}
print("ssss${list.length}");
if(homeCubit.productLength>0){
      return GridView.builder(

        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .8,
            mainAxisSpacing: 1,

            crossAxisCount: 2),
        itemCount: list.length>0?list.length:homeCubit.productLength,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: state is AllProductLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : state is AllProductError
                      ? Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.refresh),
                          ),
                        )
                      : homeCubit.productList.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.all(25.0),
                              child: ProductWidget(
                                  model: context
                                      .read<HomeCubit>()
                                      .productList
                                      .elementAt(index),index: index,),
                            )
                          : SizedBox(
                            child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                          ));
        },
      );}
else{
  return Center(child: Container(child:Text('no_data_found'.tr(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: AppColors.primary),),));
}
    });
  }
}
