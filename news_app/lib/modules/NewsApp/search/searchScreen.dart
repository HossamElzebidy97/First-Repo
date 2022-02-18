
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';


class SearchScreen  extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var list = NewsCubit.get(context).search;

        NewsCubit cubit=BlocProvider.of(context);

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onchange: (value) {
                   cubit.getSearch(value);
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                child: articleBuilder(
                  context,
                  list: cubit.search,
                  isSearch: false
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}