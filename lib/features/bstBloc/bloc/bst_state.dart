part of 'bst_bloc.dart';

@immutable
sealed class BstState {}

final class BstInitial extends BstState {}
class BstNewValueAddedState extends BstState {
  final TreeNode root;
  BstNewValueAddedState(this.root);
}