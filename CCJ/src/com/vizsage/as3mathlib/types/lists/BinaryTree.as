package com.vizsage.as3mathlib.types.lists {
/**
 * @class       com.vizsage.as3mathlib.types.lists.BinaryTree
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the BinaryTree Class.
 *              <p>
 *		        Provides methods for creating and displaying results from
 *              a binary tree crawl.
 * @usage       <pre>var inst:BinaryTree = new BinaryTree();</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * Dependency:  com.vizsage.as3mathlib.types.lists.Node
 * -----------------------------------------------
 * Reference:   http://cslibrary.stanford.edu/110/BinaryTrees.html
 * -----------------------------------------------
 * AS2  revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
 * Java original copyright � 2003, Nick Parlante  [nick.parlante@cs.stanford.edu]
 * -----------------------------------------------
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     - Redistributions of source code must retain the above copyright notice,
 *       this list of conditions and the following disclaimer.
 *
 *     - Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 *     - Neither the name of this software nor the names of its contributors
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * -----------------------------------------------
 *   Functions:
 *       BinaryTree()
 *           1.  lookup(data)
 *           2.  lookupRecurs(node, data)
 *           3.  insert(data)
 *           4.  insertRecurs(node, data)
 *           5.  size()
 *           6.  sizeRecurs(node)
 *           7.  maxDepth()
 *           8.  maxDepthRecurs(node)
 *           9.  minValue()
 *           10. minValueIter(node)
 *           11. maxValue()
 *           12. maxValueIter(node)
 *           13. printTree()
 *           14. printTreeRecurs(node)
 *           15. printPostOrder()
 *           16. printPostOrderRecurs(node)
 *           17. hasPathSum(sum)
 *           18. hasPathSumRecurs(node, sum)
 *           19. printPaths()
 *           20. printPathsRecurs(node, path, pathLen)
 *           21. printArray(ints, len)
 *           22. mirror()
 *           23. mirrorRecurs(node)
 *           24. doubleTree()
 *           25. doubleTreeRecurs(node)
 *           26. sameTree(other)
 *           27. sameTreeRecurs(a, b)
 *           28. countTreesRecurs(numKeys)
 *           29. isBST()
 *           30. isBSTRecurs(node)
 *           31. isBST2()
 *           32. isBST2Recurs(node, min, max)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

import com.vizsage.as3mathlib.types.lists.Node;

public class BinaryTree  {
	/**
	 * @property $root (Node) -- will be null for an empty tree.
	 * @property $debug (String)  -- debug mode results.
	**/
    public var $root:Node;
    public var $debug:String = "Debug\n";

    // constructor
    public function BinaryTree() {
        $root = null;
    }

      // 1. lookup -------------------------------------

    /**
     * @method  lookup
     * @description  Public -- calls recursive lookup for input number.
     * @usage  <pre>inst.lookup(data);</pre>
     * @param   data   (Number)  -- a real number.
     * @return  (Boolean)  -- returns true if the given target is in the binary tree.
    **/
    public function lookup(data:Number):Boolean {
        return (lookupRecurs($root, data));
    }

      // 2. lookupRecurs -------------------------------

    /**
     * @method  lookupRecurs
     * @description  Recursive lookup  -- given a node, recur down searching
     *               for the given data.
     * @usage  <pre>inst.lookupRecurs(node, data);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @param   data   (Number)  -- a real number.
     * @return  (Boolean)
    **/
    private function lookupRecurs(node:Node, data:Number):Boolean {
        if (node==null) return false;
        if (data==node.$data) return true;
        else if (data<node.$data) return(lookupRecurs(node.$left, data));
        else return lookupRecurs(node.$right, data);
    }

      // 3. insert  ------------------------------------

    /**
     * @method  insert
     * @description  Public -- inserts the given data into the binary tree.
     * @usage  <pre>inst.insert(data);</pre>
     * @param   data   (Number)  -- a real number.
     * @return  (void)
    **/
    public function insert(data:Number):void {
        $root = insertRecurs($root, data);
    }

      // 4. insertRecurs -------------------------------

    /**
     * @method  insertRecurs
     * @description  Recursive insert -- given a node pointer, recur down and
     *               insert the given data into the tree.
     * @usage  <pre>inst.insertRecurs(node, data);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @param   data   (Number)  -- a real number.
     * @return  (Node)  -- returns the new node pointer (the standard way to communicate a changed pointer back to the caller).
    **/
    private function insertRecurs(node:Node, data:Number):Node {
        if (node==null) {
            node = new Node(data);
        }
        else {
            if (data<=node.$data) node.$left = insertRecurs(node.$left, data);
            else node.$right = insertRecurs(node.$right, data);
        }

        return node; // in any case, return the new pointer to the caller
    }

      // 5. size ---------------------------------------

    /**
     * @method  size
     * @description  Public -- uses a recursive helper that recurs down the
     *               tree and counts the nodes.
     * @usage  <pre>inst.size();</pre>
     * @return  (Number)  -- returns the number of nodes in the tree.
    **/
    public function size():Number {
        return sizeRecurs($root);
    }

      // 6. sizeRecurs ---------------------------------

    /**
     * @method  sizeRecurs
     * @description  Recursive helper that recurs down the tree and counts the nodes.
     * @usage  <pre>inst.sizeRecurs(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (Number)  -- returns the number of nodes in the tree.
    **/
    private function sizeRecurs(node:Node):Number {
        if (node==null) return(0);
        else return (sizeRecurs(node.$left)+1+sizeRecurs(node.$right));
    }

      // 7. maxDepth  ----------------------------------

    /**
     * @method  maxDepth
     * @description  Public -- uses a recursive helper that recurs down to
     *               find the max depth.
     * @usage  <pre>inst.maxDepth();</pre>
     * @return  (Number)  -- returns the max $root-to-leaf depth of the tree.
    **/
    public function maxDepth():Number {
        return maxDepthRecurs($root);
    }

      // 8. maxDepthRecurs -----------------------------

     //Recursive helper function

    /**
     * @method  maxDepthRecurs
     * @description  Recursive helper that recurs down to find the max depth.
     * @usage  <pre>inst.maxDepthRecurs(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (Number)  -- returns the max $root-to-leaf depth of the tree.
    **/
    private function maxDepthRecurs(node:Node):Number {
        if (node==null) {
            return 0;
        }
        else {
            var lDepth:Number = maxDepthRecurs(node.$left);
            var rDepth:Number = maxDepthRecurs(node.$right);

            // use the larger + 1
            return (Math.max(lDepth, rDepth)+1);
        }
    }

      // 9. minValue -----------------------------------

     //Returns the min value in a non-empty binary search tree.
     //Uses a helper method that iterates to the left to find
     //the min value.

    /**
     * @method  minValue
     * @description  Public -- uses a helper method that iterates to the left
     *               to find the min value.
     * @usage  <pre>inst.minValue();</pre>
     * @return  (Number)  -- returns the min value in a non-empty binary search tree.
    **/
    public function minValue():Number {
        return minValueIter($root);
    }

      // 10. minValueIter ------------------------------

    /**
     * @method  minValueIter
     * @description  Recursive helper that iterates to the left to find the min value.
     * @usage  <pre>inst.minValueIter(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (Number)  -- returns the min value in a non-empty binary search tree.
    **/
    private function minValueIter(node:Node):Number {
        var current:Node = node;

        while (current.$left!=null) current = current.$left;

        return current.$data;
    }

      // 11. maxValue ----------------------------------

	/**
	 * @method  maxValue
	 * @description  Public -- uses a helper method that iterates to the right
	 *               to find the max value.
	 * @usage  <pre>inst.maxValue();</pre>
	 * @return  (Number)  -- returns the max value in a non-empty binary search tree.
	**/
	public function maxValue():Number {
	    return maxValueIter($root);
	}

      // 12. maxValueIter -------------------------------

	/**
	 * @method  maxValueIter
	 * @description  Recursive helper that iterates to the right to find
	 *               the max value.
	 * @usage  <pre>inst.maxValueIter(node);</pre>
	 * @param   node   (Node)  -- a Node instance ($root).
	 * @return  (Number)  -- returns the max value in a non-empty binary search tree.
	**/
	private function maxValueIter(node:Node):Number {
	    var current:Node = node;
	    while  (current.$right!=null) { current = current.$right; }
	    return current.$data;
    }

      // 13. printTree ----------------------------------

    /**
     * @method  printTree
     * @description  Public -- prints the node values in the 'inorder' order.
     * @usage  <pre>inst.printTree();</pre>
     * @return  (void)
    **/
    public function printTree():void {
        $debug += "\n## printTree\n\n";
        printTreeRecurs($root);
    }

      // 14. printTreeRecurs ----------------------------

    /**
     * @method  printTreeRecurs
     * @description  Recursive helper to do the tree traversal.
     * @usage  <pre>inst.printTreeRecurs(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (void)
    **/
    private function printTreeRecurs(node:Node):void {
        $debug += "printTreeRecurs\n";
        if (node==null) return;

        // left, node itself, right
        $debug += "printTreeRecurs.node.$left\n";
        printTreeRecurs(node.$left);
        $debug += "printTreeRecurs.node.$data: "+node.$data+"\n";
        $debug += "printTreeRecurs.node.$right\n";
        printTreeRecurs(node.$right);
    }

      // 15. printPostOrder -----------------------------

    /**
     * @method  printPostOrder
     * @description  Public -- prints the node values in the 'postOrder' order.
     * @usage  <pre>inst.printPostOrder();</pre>
     * @return  (void)
    **/
    public function printPostOrder():void {
        $debug += "\n## printPostOrder\n\n";
        printPostOrderRecurs($root);
    }

      // 16. printPostOrderRecurs -----------------------

    /**
     * @method  printPostOrderRecurs
     * @description  Recursive helper to do the tree traversal.
     * @usage  <pre>inst.printPostOrderRecurs(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (void)
    **/
    public function printPostOrderRecurs(node:Node):void {
        $debug += "printPostOrderRecurs\n";
        if (node==null) return;

        // first recur on both subtrees
        $debug += "printPostOrderRecurs.node.$left\n";
        printPostOrderRecurs(node.$left);
        $debug += "printPostOrderRecurs.node.$right\n";
        printPostOrderRecurs(node.$right);

        // then deal with the node
        $debug += "printPostOrderRecurs.node.$data: "+node.$data+"\n";
    }

      // 17. hasPathSum ---------------------------------

    /**
     * @method  hasPathSum
     * @description  Public -- given a tree and a sum, tests to see if there
     *               is a path from the $root down to a leaf, such that adding
     *               up all the values along the path equals the given sum.
     *               <p>
     *               Strategy -- subtract the node value from the sum when recurring
     *               down, and check to see if the sum is 0 when you run out of tree.
     * @usage  <pre>inst.hasPathSum(sum);</pre>
     * @param   sum   (Number)  -- a real number.
     * @return  (Boolean)  -- returns true if there is a path from the $root down to a leaf.
    **/
    public function hasPathSum(sum:Number):Boolean {
        return hasPathSumRecurs($root, sum);
    }

      // 18. hasPathSumRecurs ---------------------------

    /**
     * @method  hasPathSumRecurs
     * @description  Recursive helper that sums the path data.
     * @usage  <pre>inst.hasPathSumRecurs(node, sum);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @param   sum   (Number)  -- a real number.
     * @return  (Boolean)
    **/
    public function hasPathSumRecurs(node:Node, sum:Number):Boolean {
        // return true if we run out of tree and sum==0
        if (node==null) return (sum==0);
        else {
            // otherwise check both subtrees
            var subSum:Number = sum-node.$data;

            return (hasPathSumRecurs(node.$left, subSum) || hasPathSumRecurs(node.$right, subSum));
        }
    }

      // 19. printPaths ---------------------------------

    /**
     * @method  printPaths
     * @description  Public -- given a binary tree, prints out all of its
     *               $root-to-leaf paths, one per line.
     * @usage  <pre>inst.printPaths();</pre>
     * @return  (void)
    **/
    public function printPaths():void {
        $debug += "\n## printPaths\n\n";
        var path:Array = new Array(1000);
        printPathsRecurs($root, path, 0);
    }

      // 20. printPathsRecurs ---------------------------

    /**
     * @method  printPathsRecurs
     * @description  Recursive helper -- given a node, and an array containing
     *               the path from the $root node up to but not including this
     *               node, prints out all the $root-leaf paths.
     * @usage  <pre>inst.printPathsRecurs(node, path, pathLen);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @param   path   (Array)  -- an empty array to hold pushed data.
     * @param   pathLen   (Number)  -- a positive integer.
     * @return  (void)
    **/
    private function printPathsRecurs(node:Node, path:Array, pathLen:Number):void {
        $debug += "printPathsRecurs\n";

        if (node==null) return;

        // append this node to the path array
        path[pathLen] = node.$data;
        pathLen++;

        // it's a leaf, so print the path that led to here
        if (node.$left==null && node.$right==null) {
            printArray(path, pathLen);
        }
        else {
            // otherwise try both subtrees
            $debug += "printPathsRecurs.node.$left\n";
            printPathsRecurs(node.$left, path, pathLen);
            $debug += "printPathsRecurs.node.$right\n";
            printPathsRecurs(node.$right, path, pathLen);
        }
    }

      // 21. printArray ---------------------------------

    /**
     * @method  printArray
     * @description  Public -- utility that prints ints from an array on one line.
     * @usage  <pre>inst.printArray(ints, len);</pre>
     * @param   ints   (Array)  -- a holder for path elements.
     * @param   len   (Number)  -- a positive integer.
     * @return  (void)
    **/
    private function printArray(ints:Array, len:Number):void {
        $debug += "printArray\n";
        var i:Number;
        for (i=0;i<len;i++) $debug += "ints["+i+"]: "+ints[i]+"\n";
    }

      // 22. mirror  -------------------------------------

    /**
     * @method  mirror
     * @description  Public -- changes the tree into its mirror image.
     *               <blockquote><pre>
     *               So the tree...
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ \
     *               &nbsp;&nbsp;&nbsp;&nbsp;2   5
     *               &nbsp;&nbsp;&nbsp;/ \
     *               &nbsp;&nbsp;1   3
     *
     *               is changed to...
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ \
     *               &nbsp;&nbsp;&nbsp;&nbsp;5   2
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ \
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3   1
     *               </pre></blockquote>
     * @usage  <pre>inst.mirror();</pre>
     * @return  (void)
    **/
    public function mirror():void {
        $debug += "\n## mirror\n\n";
        mirrorRecurs($root);
    }

      // 23. mirrorRecurs --------------------------------

    /**
     * @method  mirrorRecurs
     * @description  Recursive helper that recurs over the tree, swapping
     *               the left/right pointers.
     * @usage  <pre>inst.mirrorRecurs(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (void)
    **/
    private function mirrorRecurs(node:Node):void {
        $debug += "mirrorRecurs\n";
        if (node!=null) {
            // do the sub-trees
            $debug += "mirrorRecurs.node.$left\n";
            mirrorRecurs(node.$left);
            $debug += "mirrorRecurs.node.$right\n";
            mirrorRecurs(node.$right);

            // swap the left/right pointers
            var temp:Node = node.$left;
            node.$left = node.$right;
            node.$right = temp;
        }
    }

      // 24. doubleTree  ---------------------------------

    /**
     * @method  doubleTree
     * @description  Public -- changes the tree by inserting a duplicate node
     *               on each node's $left.
     *               <blockquote><pre>
     *               So the tree...
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ \
     *               &nbsp;&nbsp;&nbsp;&nbsp;1   3
     *
     *               Is changed to...
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2
     *               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ \
     *               &nbsp;&nbsp;&nbsp;&nbsp;2   3
     *               &nbsp;&nbsp;&nbsp;/   /
     *               &nbsp;&nbsp;1   3
     *               &nbsp;/
     *               1
     *               </pre></blockquote>
     * @usage  <pre>inst.doubleTree();</pre>
     * @return  (void)
    **/
    public function doubleTree():void {
        $debug += "\n## doubleTree\n\n";
        doubleTreeRecurs($root);
    }

      // 25. doubleTreeRecurs ----------------------------

    /**
     * @method  doubleTreeRecurs
     * @description  Recursive helper to recur over the tree and insert
     *               the duplicates.
     * @usage  <pre>inst.doubleTreeRecurs(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (void)
    **/
    private function doubleTreeRecurs(node:Node):void {
        $debug += "doubleTreeRecurs\n";

        var oldLeft:Node;

        if (node==null) return;

        // do the subtrees
        $debug += "doubleTreeRecurs.node.$left\n";
        doubleTreeRecurs(node.$left);
        $debug += "doubleTreeRecurs.node.$right\n";
        doubleTreeRecurs(node.$right);

        // duplicate this node to its left
        oldLeft = node.$left;
        node.$left = new Node(node.$data);
        node.$left.$left = oldLeft;
    }

      // 26. sameTree ------------------------------------

    /**
     * @method  sameTree
     * @description  Public -- compares the receiver to another tree to see
     *               if they are structurally identical.
     * @usage  <pre>inst.sameTree(other);</pre>
     * @param   other   (BinaryTree)  -- passed tree for comparison.
     * @return  (Boolean)
    **/
    public function sameTree(other:BinaryTree):Boolean {
        return (sameTreeRecurs($root, other.$root));
    }

      // 27. sameTreeRecurs ------------------------------

    /**
     * @method  sameTreeRecurs
     * @description  Recursive helper -- recurs down two trees in parallel,
     *               checking to see if they are identical.
     * @usage  <pre>inst.sameTreeRecurs(a, b);</pre>
     * @param   a   (Node)  -- a Node instance ($root).
     * @param   b   (Node)  -- a passed Node instance ($root).
     * @return  (Boolean)
    **/
    public function sameTreeRecurs(a:Node, b:Node):Boolean {
        // 1. both empty -> true
        if (a==null && b==null) return true;

        // 2. both non-empty -> compare them
        else if (a!=null && b!=null) {
            return (
                a.$data == b.$data &&
                sameTreeRecurs(a.$left, b.$left) &&
                sameTreeRecurs(a.$right, b.$right)
            );
        }

        // 3. one empty, one not -> false
        else return false;
    }

      // 28. countTreesRecurs ----------------------------

    /**
     * @method  countTreesRecurs
     * @description  Public -- for the key values 1...numKeys, how many
     *               structurally unique binary search trees are possible
     *               that store those keys?
     *               <p>
     *               Strategy -- consider that each value could be the $root.
     *               Recursively find the size of the left and right subtrees.
     * @usage  <pre>inst.countTreesRecurs(numKeys);</pre>
     * @param   numKeys   (Number)  -- a positive integer.
     * @return  (Number)  -- returns the number of possible trees with this $root == left*right.
    **/
    public static function countTreesRecurs(numKeys:Number):Number {
        if (numKeys<=1) return 1;
        else {
            // there will be one value at the $root, with whatever remains
            // on the left and right each forming their own subtrees.
            // Iterate through all the values that could be the $root...
            var sum:Number = 0;
            var left:Number;
            var right:Number;
            var rootNum:Number;

            for (rootNum=1;rootNum<=numKeys;rootNum++) {
                left = countTreesRecurs(rootNum-1);
                right = countTreesRecurs(numKeys-rootNum);

                // number of possible trees with this $root == left*right
                sum += left*right;
            }

            return sum;
        }
    }

      // 29. isBST  --------------------------------------

    /**
     * @method  isBST
     * @description  Public -- tests if a tree meets the conditions to be a
     *               binary search tree (BST).
     * @usage  <pre>inst.isBST();</pre>
     * @return  (Boolean)
    **/
    public function isBST():Boolean {
        return isBSTRecurs($root);
    }

      // 30. isBSTRecurs ---------------------------------

    /**
     * @method  isBSTRecurs
     * @description  Recursive helper -- checks if a tree is a BST using
     *               'minValue()' and 'maxValue()' (not efficient).
     * @usage  <pre>inst.isBSTRecurs(node);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @return  (Boolean)
    **/
    private function isBSTRecurs(node:Node):Boolean {
        if (node==null) return true;

        // do the subtrees contain values that do not
        // agree with the node?
        if (node.$left  != null 	&& (node.$left  as BinaryTree).maxValue() >  node.$data) return false;
        if (node.$right != null 	&& (node.$right as BinaryTree).minValue() <= node.$data) return false;

        // check that the subtrees themselves are ok
        return (isBSTRecurs(node.$left) && isBSTRecurs(node.$right));
    }

      // 31. isBST2 --------------------------------------

    /**
     * @method  isBST2
     * @description  Public -- tests if a tree meets the conditions to be a
     *               binary search tree (BST). Uses the efficient recursive helper.
     * @usage  <pre>inst.isBST2();</pre>
     * @return  (Boolean)
    **/
    public function isBST2():Boolean {
        return (isBST2Recurs($root, Number.MIN_VALUE, Number.MAX_VALUE));
    }

      // 32. isBST2Recurs  ------------------------------

    /**
     * @method  isBST2Recurs
     * @description  Efficient BST helper -- given a node, and min and max values,
     *               recurs down the tree to verify that it is a BST, and that all
     *               its nodes are within the min..max range. Works in O(n) time --
     *               visits each node only once.
     * @usage  <pre>inst.isBST2Recurs(node, min, max);</pre>
     * @param   node   (Node)  -- a Node instance ($root).
     * @param   min   (Number)  -- Number.MIN_VALUE.
     * @param   max   (Number)  -- Number.MAX_VALUE.
     * @return  (Boolean)
    **/
    private function isBST2Recurs(node:Node, min:Number, max:Number):Boolean {
        if (node==null) return(true);
        else {
            // left should be in range  min...node.data
            var leftOk:Boolean = isBST2Recurs(node.$left, min, node.$data);

            // if the left is not ok, bail out
            if (!leftOk) return false;

            // right should be in range node.data+1..max
            var rightOk:Boolean = isBST2Recurs(node.$right, node.$data+1, max);

            return rightOk;
        }
    }

      // Test

      // build123a -----------------------------------------

    /**
     * @method  build123a
     * @description  Public -- tester using three pointer variables.
     * @usage  <pre>inst.build123a();</pre>
     * @return  (void)
    **/
    public function build123a():void {
        $root = new Node(2);

        var lChild:Node = new Node(1);
        var rChild:Node = new Node(3);

        $root.$left = lChild;
        $root.$right= rChild;
    }

      // build123b -----------------------------------------

    /**
     * @method  build123b
     * @description  Public -- tester using one pointer variable.
     * @usage  <pre>inst.build123b();</pre>
     * @return  (void)
    **/
    public function build123b():void {
        $root = new Node(2);
        $root.$left = new Node(1);
        $root.$right = new Node(3);
    }

      // build123c -----------------------------------------

    /**
     * @method  build123c
     * @description  Public -- tester calls insert() three times. Note that
     *               the '2' must be inserted first.
     * @usage  <pre>inst.build123c();</pre>
     * @return  (void)
    **/
    public function build123c():void {
        $root = null;
        $root = insertRecurs($root, 2);
        $root = insertRecurs($root, 1);
        $root = insertRecurs($root, 3);
    }

}// class
}//package

