package com.vizsage.as3mathlib.types.lists {
/**
 * @class       com.vizsage.as3mathlib.types.lists.Node
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Node Class.
 *              <p>
 *		        BinaryTree.as is built using this node class. Each node stores one
 *              data element, and has left and right sub-tree pointer which may be
 *              null. The node is a 'dumb' nested class -- we just use it for
 *              storage; it does not have any methods.
 * @usage       <pre>var inst:Node = new Node(newData)</pre>
 * @param       newData (Number)  -- a real number.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2  revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
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
 *       Node(newData)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Node  {
	/**
	 * @property $left (Node)  -- holder for left Node.
	 * @property $right (Node)  -- holder for right Node.
	 * @property $data (Number)  -- a real number.
	**/
    public var $left:	Node;
    public var $right:	Node;
    public var $data:	Number;

    public function Node(newData:Number) {
        $left  = null;
        $right = null;
        $data  = newData;
    }

}// class
}//package

