class TreeNode {
  int? value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value) : left = null, right = null;

  bool get isEmpty => value == null;

  void insert(int newValue) {
    if (value == null) {
      value = newValue;
    } else if (newValue < value!) //to check for duplicates
    {
      if (left == null) {
        left = TreeNode(newValue);
      } else {
        left!.insert(newValue);
      }
    } else if (newValue > value!)//to check for duplicates
    {
      if (right == null) {
        right = TreeNode(newValue);
      } else {
        right!.insert(newValue);
      }
    }
  }
}
