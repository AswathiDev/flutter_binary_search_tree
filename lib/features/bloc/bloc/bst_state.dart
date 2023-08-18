part of 'bst_bloc.dart';

@immutable
sealed class BstState {}

final class BstInitial extends BstState {}
class BSTLoadedState extends BstState {
  final TreeNode root;
  BSTLoadedState(this.root);
}