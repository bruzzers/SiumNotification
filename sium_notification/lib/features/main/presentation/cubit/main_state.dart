part of 'main_cubit.dart';

class MainState extends BaseState{
  final int? index;
  final List<Widget>? childrenList;
  final List<BottomNavigationBarItem>? bottomItems;
  @override
  // TODO: implement props
  List<Object?> get props => [index, childrenList, bottomItems];

  MainState({
    this.index,
    this.childrenList,
    this.bottomItems,
  });

  MainState copyWith({
    int? index,
    List<Widget>? childrenList,
    List<BottomNavigationBarItem>? bottomItems,
  }) {
    return MainState(
      index: index ?? this.index,
      childrenList: childrenList ?? this.childrenList,
      bottomItems: bottomItems ?? this.bottomItems,
    );
  }
}
