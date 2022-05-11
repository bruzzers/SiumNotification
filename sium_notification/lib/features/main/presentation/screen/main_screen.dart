// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sium_notification/features/main/presentation/cubit/main_cubit.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state){
      if(state.childrenList?.isNotEmpty == true && state.bottomItems?.isNotEmpty == true) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: state.bottomItems ?? [],
            currentIndex: state.index ?? 0,
            onTap: context
                .read<MainCubit>()
                .changeIndex,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: state.childrenList ?? [],
            controller: context
                .read<MainCubit>()
                .controller,
          ),
        );
      }else{
        return Container();
      }
    });
  }

}