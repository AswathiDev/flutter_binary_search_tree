// class TreeNode {
//   //it represents a single node in bst
//   int? value;
//   TreeNode? left;
//   TreeNode? right;

//   TreeNode(this.value) : left = null, right = null;

//   // bool get isEmpty => value == null;

//   void insert(int newValue) {
//     if (value == null) {//current node is empty
//       value = newValue;
//     } else if (newValue < value!) 
//     {
//       if (left == null) {
//         left = TreeNode(newValue);
//       } else {
//         left!.insert(newValue);
//       }
//     } else if (newValue > value!)
//     {
//       if (right == null) {
//         right = TreeNode(newValue);
//       } else {
//         right!.insert(newValue);
//       }
//     }else{
//     print('value is a duplicate');
    

//     }
//   }
// }
class TreeNode {
  static TreeNode? _instance; // Singleton instance
  int? value;
  TreeNode? left;
  TreeNode? right;

  // Private constructor
  TreeNode._(this.value) : left = null, right = null;

  factory TreeNode.getInstance() {
    // if (_instance == null) {
      _instance = TreeNode._(null); // Initialize the instance with a null value
    // }
    return _instance!;
  }

  void insert(int newValue) {
    if (value == null) {
      value = newValue;
    } else if (newValue < value!) {
      if (left == null) {
        left = TreeNode._(newValue); // Create new instance only if needed
      } else {
        left!.insert(newValue);
      }
    } else if (newValue > value!) {
      if (right == null) {
        right = TreeNode._(newValue); // Create new instance only if needed
      } else {
        right!.insert(newValue);
      }
    } else {
      print('Value is a duplicate');
    }
  }
}
