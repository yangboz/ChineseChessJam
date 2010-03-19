package com.vizsage.as3mathlib.math.alg {
/**
 * @class       com.vizsage.as3mathlib.math.alg.Matrix
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Matrix Class -- provides
 *              methods for matrix manipulation.
 * @usage       <code>var inst:Matrix = new Matrix(r, c)</code>
 * @param       r (Number)  -- number of rows in new matrix.
 * @param       c (Number)  -- number of columns in new matrix.
 * -----------------------------------------------
 * Latest update: August 15, 2004
 * -----------------------------------------------
 * Dependency:    com.vizsage.as3mathlib.math.alg.Vector
 * -----------------------------------------------
 * AS2 revision copyright: � 2003, Richard Wright   [wisolutions2002@shaw.ca]
 * AS1 original copyright: � 2001, Brandon Williams [brandon@plotdev.com]
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
 *       Matrix(r, c)
 *           1.  resize(r, c)
 *           2.  augment(m1)
 *           3.  fragment(m1, sr, sc, er, ec)
 *           4.  identity()
 *           5.  constant(a)
 *           6.  randomMatrix(a, b)
 *           7.  addition(m1, m2)
 *           8.  subtract(m1, m2)
 *           9.  scalar(s)
 *           10. transpose()
 *           11. mult(m1, m2)
 *           12. vectorMult(V)
 *           13. determinant()
 *           14. inverse(m1)
 *           15. elemConstant(r, s)
 *           16. elemSwitch(r1, r2)
 *           17. elemCMA(r1, s, r2)
 *           18. rowReduce()
 *           19. print()
 *           20. copy()
 *           21. rotationX(sine, cosine)
 *           22. rotationY(sine, cosine)
 *           23. rotationZ(sine, cosine)
 *           24. rotationAxis(V, sine, cosine)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;

public class Matrix  {
	/**
	 * @property $rows  -- number of rows in matrix.
	 * @property $columns  -- number of columns in matrix.
	 * @property $m  -- matrix array.
	**/
    public var $rows:Number;
    public var $columns:Number;
    public var $m:Array;

    // constructor
    public function Matrix(r:Number, c:Number) {
	    var j:Number;

        $m = new Array(r);
	    for (j=0;j<r;j++) $m[j] = new Array(c);
	    $rows = r;
	    $columns = c;
    }

      // 1. resize -------------------------------------

    /**
     * @method  resize
     * @description  Resize this instance's properties.
     * @usage  <pre>inst.resize(r, c);</pre>
     * @param   r   (Number)  -- a positive integer.
     * @param   c   (Number)  -- a positive integer.
     * @return  (void)
    **/
    public function resize(r:Number, c:Number):void {
	    var j:Number, k:Number;
	    var diffR:Number = r-$rows;
	    var diffC:Number = c-$columns;

	    // add new rows
	    if (diffR>0) {
		    for (j=0;j<diffR;j++) {
			    $m.push(new Array());
			    // initialize new elements as zero
			    for (k=0;k<$columns+diffC;k++) $m[$columns+j][k] = 0;
		    }
	    }
	    // add new columns
	    if (diffC>0) {
		    for (j=0;j<$rows;j++) {
			    for (k=0;k<diffC;k++) $m[j].push(0);
			}
		}

	    // take away extra rows
	    if (diffR<0) {
		    for (j=0;j>diffR;j--) $m.pop();
		}
	    // take away extra columns
	    if (diffC<0) {
		    for (j=0;j<r;j++) {
			    for (k=0;k>diffC;k--) $m[j].pop();
			}
		}

	    $rows = r;
	    $columns = c;
    }

      // 2. augment ------------------------------------

    /**
     * @method  augment
     * @description  Augment this instance with passed Matrix object.
     * @usage  <pre>inst.augment(m1);</pre>
     * @param   m1   (Matrix)  -- an existing Matrix object.
     * @return  (void)
    **/
    public function augment(m1:Matrix):void {
        var j:Number, k:Number;

	    if ($rows==m1.$rows) {
		    for (j=0;j<$rows;j++) {
			    for (k=$columns;k<$columns+m1.$columns;k++) {
				    $m[j].push(m1.$m[j][k-$columns]);
				}
			}
		    $columns += m1.$columns;
	    }
    }

      // 3. fragment -----------------------------------

    /**
     * @method  fragment
     * @description  Defines this instance with a fragment of this instance.
     * @usage  <pre>inst.fragment(m1, sr, sc, er, ec);</pre>
     * @param   m1   (Matrix)  -- an existing Matrix object.
     * @param   sr   (Number)  -- fragment starting row value (positive integer).
     * @param   sc   (Number)  -- fragment starting column value (positive integer).
     * @param   er   (Number)  -- fragment ending row value (positive integer).
     * @param   ec   (Number)  -- fragment ending column value (positive integer).
     * @return  (void)
    **/
    public function fragment(m1:Matrix, sr:Number, sc:Number, er:Number, ec:Number):void {
   		var j:Number, k:Number;

	    // dimension checks
	    if (sr<0) sr = 0;
	    if (sc<0) sc = 0;
	    if (er>m1.$rows) er = $rows;
	    if (ec>m1.$columns) ec = $columns;

	    // new dimensions -- add one to include last elements
	    resize(er-sr+1, ec-sc+1);

	    // copy elements
	    for (j=sr;j<=er;j++) {
		    for (k=sc;k<=ec;k++) $m[j-sr][k-sc] = m1.$m[j][k];
		}
    }

      // 4. identity -----------------------------------

    /**
     * @method  identity
     * @description  Defines this instance as an identity matrix.
     * @usage  <pre>inst.identity();</pre>
     * @return  (void)
    **/
    public function identity():void {
	   	var j:Number, k:Number;

	    for (j=0;j<$rows;j++) {
		    for (k=0;k<$columns;k++) {
			    if (j==k) $m[j][k] = 1;
			    else $m[j][k] = 0;
			}
		}
    }

      // 5. constant -----------------------------------

    /**
     * @method  constant
     * @description  Defines each matrix element as the passed constant value.
     * @usage  <pre>inst.constant(a);</pre>
     * @param   a   (Number)  -- a real number.
     * @return  (void)
    **/
    public function constant(a:Number):void {
        var j:Number, k:Number;

	    for (j=0;j<$m.length;j++) {
		    for (k=0;k<$m[j].length;k++) $m[j][k] = a;
		}
    }

      // 6. random -------------------------------------

    /**
     * @method  random
     * @description  Defines each matrix element as a random number clamped
     *               between passed min-max values.
     * @usage  <pre>inst.random(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (void)
    **/
    public function random(a:Number, b:Number):void {
        var j:Number, k:Number;

	    for (j=0;j<$rows;j++) {
		    for (k=0;k<$columns;k++) {
			    $m[j][k] = Math.round(Math.random()*(Math.max(a, b)-Math.min(a, b)))+Math.min(a, b);
			}
		}
    }

      // 7. addition -----------------------------------

    /**
     * @method  addition
     * @description  Resets this instance's $m property with the addition results
     *               of the passed Matrix objects if they both are sized equally,
     *               or else with the constant '0' if they differ.
     * @usage  <pre>inst.addition(m1, m2);</pre>
     * @param   m1   (Matrix)  -- an existing Matrix object.
     * @param   m2   (Matrix)  -- an existing Matrix object.
     * @return  (void)
    **/
    public function addition(m1:Matrix, m2:Matrix):void {
        var j:Number, k:Number;

	    if (m1.$rows!=m2.$rows || m1.$columns!=m2.$columns) constant(0);
	    else {
		    resize(m1.$rows, m1.$columns);
		    for (j=0;j<$rows;j++) {
			    for (k=0;k<$columns;k++) $m[j][k] = m1.$m[j][k]+m2.$m[j][k];
			}
	    }
    }

      // 8. subtract -----------------------------------

    /**
     * @method  subtract
     * @description  Resets this instance's $m property with the subtraction results
     *               of the passed Matrix objects if they both are sized equally,
     *               or else with the constant '0' if they differ.
     * @usage  <pre>inst.subtract(m1, m2);</pre>
     * @param   m1   (Matrix)  -- an existing Matrix object.
     * @param   m2   (Matrix)  -- an existing Matrix object.
     * @return  (void)
    **/
    public function subtract(m1:Matrix, m2:Matrix):void {
        var j:Number, k:Number;

	    if (m1.$rows!=m2.$rows || m1.$columns!=m2.$columns) constant(0);
	    else {
		    resize (m1.$rows, m1.$columns);
		    for (j=0;j<$rows;j++) {
			    for (k=0;k<$columns;k++) $m[j][k] = m1.$m[j][k]-m2.$m[j][k];
			}
	    }
    }

      // 9. scalar -------------------------------------

    /**
     * @method  scalar
     * @description  Scales this instance's $m elements by the passed value.
     * @usage  <pre>inst.scalar(s);</pre>
     * @param   s   (Number)  -- a real number.
     * @return  (void)
    **/
    public function scalar(s:Number):void {
        var j:Number, k:Number;

	    for (j=0;j<$rows;j++) {
		    for (k=0;k<$columns;k++) $m[j][k] *= s;
		}
    }

      // 10. transpose ----------------------------------

    /**
     * @method  transpose
     * @description  Resizes this instance and transposes its $m elements.
     * @usage  <pre>inst.transpose();</pre>
     * @return  (void)
    **/
    public function transpose():void {
        var j:Number, k:Number;
	    var temp:Matrix = new Matrix($columns, $rows);

	    for (j=0;j<$rows;j++) {
		    for (k=0;k<$columns;k++) temp.$m[k][j] = $m[j][k];
		}
	    resize($columns, $rows);
	    $m = temp.$m;
    }

      // 11. mult ---------------------------------------

    /**
     * @method  mult
     * @description  Resets this instance's $m property with the multiplication
     *               results of the passed Matrix objects if they both are sized
     *               equally, or else with the constant '0' if they differ.
     * @usage  <pre>inst.mult(m1, m2);</pre>
     * @param   m1   (Matrix)  -- an existing Matrix object.
     * @param   m2   (Matrix)  -- an existing Matrix object.
     * @return  (void)
    **/
    public function mult(m1:Matrix, m2:Matrix):void {
        var j:Number, k:Number, s:Number;

	    if (m2.$rows!=m1.$columns) constant(0);
	    else {
		    resize(m1.$rows, m2.$columns);
		    constant(0);
		    for (j=0;j<$rows;j++) {
			    for (k=0;k<$columns;k++) {
				    for (s=0;s<m2.$rows;s++) $m[j][k] += m1.$m[j][s]*m2.$m[s][k];
				}
			}
	    }
    }

      // 12. vectorMult  ---------------------------------

	/**
	 * @method  vectorMult
	 * @description  Defines the vector made from multiplying this instance with 'V'.
	 * @usage  <pre>inst.vectorMult(V);</pre>
	 * @param   V   (Vector)  -- a direction Vector object.
	 * @return  (Vector)  --  returns a new Vector object.
	**/
	public function vectorMult(V:Vector):Vector {
	    var j:Number, k:Number;
	    var product:Vector = new Vector(0.0, 0.0, 0.0);

	    // calculate the components of the vector
	    for (j=0;j<$columns;j++) {
	        product.x += V.x*$m[0][j];
	        product.y += V.y*$m[1][j];
	        product.z += V.z*$m[2][j];
	    }

	    // return the product vector
	    return product;
    }

      // 13. determinant --------------------------------

    /**
     * @method   determinant
     * @description  Calculates the determinant of this instance.
     * @usage  <pre>inst.determinant();</pre>
     * @return  (Number)  -- returns the determinant value.
    **/
    public function determinant():Number {
        var j:Number, k:Number, a:Number, b:Number;
	    var value:Number = 0;
	    var temp:Number = 1;
	    var det:Matrix = new Matrix($rows, 2*$columns-1);

	    // copy elements
	    for (j=0;j<$rows;j++) {
		    for (k=0;k<det.$columns;k++) {
			    if (k<$columns) det.$m[j][k] = $m[j][k];
			    else det.$m[j][k] = $m[j][k-$columns];
		    }
	    }

	    // pluses
	    for (a=0;a<$columns;a++) {
		    for (b=0;b<$rows;b++) temp *= det.$m[b][a+b];
		    value += temp;
		    temp = 1;
	    }

	    // minuses
	    for (a=$columns-1;a<det.$columns;a++) {
		    for (b=0;b<$rows;b++) temp *= det.$m[b][a-b];
		    value -= temp;
		    temp = 1;
	    }

	    if ($rows!=$columns) return 0;
	    else if ($rows==1 && $columns==1) return $m[0][0];
	    else return value;
    }

      // 14. inverse ------------------------------------

    /**
     * @method  inverse
     * @description  Calculates the inverse of this instance using the
     *               row-reduction method.
     * @usage  <pre>inst.inverse();</pre>
     * @return  (void)
    **/
    public function inverse():void {
	    var I:Matrix = new Matrix($rows, $columns);
	    var temp:Matrix = new Matrix(0, 0);

	    I.identity();

	    if ($rows==$columns) {
		    augment(I);
		    rowReduce();
		    temp.fragment(this, 0, $columns/2, $rows-1, $columns-1);
		    fragment(temp, 0, 0, temp.$rows-1, temp.$columns-1);
	    }
    }

      // 15. elemConstant -------------------------------

    /**
     * @method  elemConstant
     * @description  Scales every element in the passed 'r' row of this
     *               instance's $m property by the passed 's' scalar value.
     * @usage  <pre>inst.elemConstant(r, s);</pre>
     * @param   r   (Number)  -- a positive integer.
     * @param   s   (Number)  -- a real number.
     * @return  (void)
    **/
    public function elemConstant(r:Number, s:Number):void {
        var j:Number;

	    if (s!=0) {
		    for (j=0;j<$columns;j++) $m[r][j] *= s;
		}
    }

      // 16. elemSwitch ---------------------------------

    /**
     * @method  elemSwitch
     * @description  A swap routine that exchanges two rows in this
     *               instance's $m property.
     * @usage  <pre>inst.elemSwitch(r1, r2);</pre>
     * @param   r1   (Number)  -- a positive integer.
     * @param   r2   (Number)  -- a positive integer.
     * @return  (void)
    **/
    public function elemSwitch(r1:Number, r2:Number):void {
        var k:Number, t:Number;
	    var tRow:Matrix = new Matrix(0, 0);

	    // copy 'r1' into a temp row
	    tRow.fragment(this, r1, 0, r1+1, $columns);

	    // copy 'r2' into 'r1'
	    for (k=0;k<$columns;k++) $m[r1][k] = $m[r2][k];

	    // copy the temp row into 'r2'
	    for (t=0;t<$columns;t++) $m[r2][t] = tRow.$m[0][t];
    }

      // 17. elemCMA ------------------------------------

    /**
     * @method  elemCMA
     * @description  Copies $m[r1] elements to temp[r2] row, multiplies that
     *               row's elements by the constant 's', then adds 'temp.$m'
     *               elements to this instance's $m elements.
     * @usage  <pre>inst.elemCMA(r1, s, r2);</pre>
     * @param   r1   (Number)  -- a positive integer.
     * @param   s   (Number)  -- a real number.
     * @param   r2   (Number)  -- a positive integer.
     * @return  (void)
    **/
    public function elemCMA(r1:Number, s:Number, r2:Number):void {
        var j:Number;

	    // temp matrix to keep from changing the value of 'r1' -- same
	    // dimensions as 'this' but all extra elements are zero
	    var temp:Matrix =  new Matrix($rows, $columns);

	    // initialize to a zero matrix
	    temp.constant(0);

	    // copy 'r1' of this matrix into 'temp[r2]' row
	    for (j=0;j<$columns;j++) temp.$m[r2][j] = $m[r1][j];

	    // multiply 'temp[r2]' by the constant 's'
	    temp.elemConstant(r2, s);

	    // add 'this' and 'temp' together
	    addition(this, temp);
    }

      // 18. rowReduce ----------------------------------

    /**
     * @method  rowReduce
     * @description  Defines this instance's $m property using a 'row-reduction'
     *               algorithm that employs the three elementary row methods.
     * @usage  <pre>inst.rowReduce();</pre>
     * @return  (void)
    **/
    public function rowReduce():void {
        var j:Number, k:Number;

	    if ($rows==$columns) identity();
	    else if ($rows<$columns) {
		    for (j=0;j<$rows;j++) {
			    if (j<($columns-1) && $m[j][j]==0) elemSwitch(j, j+1);
			    else if ($m[j][j]==0) break;
			    elemConstant(j, 1/$m[j][j]);
			    for (k=0;k<$rows; k++) {
			        if (j!=k) elemCMA(j, -$m[k][j], k);
			    }
		    }
		}
    }

      // 19. print --------------------------------------

	/**
	 * @method  print
	 * @description  Used for debugging -- traces Matrix object properties.
	 * @usage  <pre>inst.print();</pre>
	 * @return  (void)
	**/
	public function print():void {
	    var j:Number;

	    trace ("ELEMENTS:");
	    for (j=0;j<$rows;j++) trace ($m[j]);
	    trace ("Matrix Rows:    "+$rows);
	    trace ("Matrix Columns: "+$columns+"\n");
    }

      // 20. copy ---------------------------------------

    /**
     * @method  copy
     * @description  Copy this instance's $m property elements into passed
     *               Matrix object's $m property elements.
     * @usage  <pre>inst.copy(m1);</pre>
     * @param   m1   (Matrix)  -- an existing Matrix object.
     * @return  (void)
    **/
    public function copy(m1:Matrix):void {
        var j:Number, k:Number;

	    // mopy elements
	    for (j=0;j<$rows;j++) {
		    for (k=0;k<$columns;k++) m1.$m[j][k] = $m[j][k];
	    }
    }

      // 21. rotationX ----------------------------------

    /**
     * @method  rotationX
     * @description  Defines this instance's $m property elements for a rotation
     *               around the x-axis given the sine and cosine of the rotation angle.
     * @usage  <pre>inst.rotationX(sine, cosine);</pre>
     * @param   sine   (Number)  -- a real number between -1 and 1 inclusive.
     * @param   cosine   (Number)  -- a real number between -1 and 1 inclusive.
     * @return  (void)
    **/
    public function rotationX(sine:Number, cosine:Number):void {
        // set the elements of the rotation matrix
        $m[0][0] = 1.0; $m[0][1] = 0.0;    $m[0][2] = 0.0;
        $m[1][0] = 0.0; $m[1][1] = cosine; $m[1][2] = -sine;
        $m[2][0] = 0.0; $m[2][1] = sine;   $m[2][2] = cosine;
    }

      // 22. rotationY ----------------------------------

    /**
     * @method  rotationY
     * @description  Defines this instance's $m property elements for a rotation
     *               around the y-axis given the sine and cosine of the rotation angle.
     * @usage  <pre>inst.rotationY(sine, cosine);</pre>
     * @param   sine   (Number)  -- a real number between -1 and 1 inclusive.
     * @param   cosine   (Number)  -- a real number between -1 and 1 inclusive.
     * @return  (void)
    **/
    public function rotationY(sine:Number, cosine:Number):void {
        // set the elements of the rotation matrix
        $m[0][0] = cosine; $m[0][1] = 0.0; $m[0][2] = sine;
        $m[1][0] = 0.0;	   $m[1][1] = 1.0; $m[1][2] = 0.0;
        $m[2][0] = -sine;  $m[2][1] = 0.0; $m[2][2] = cosine;
    }

      // 23. rotationZ ----------------------------------

    /**
     * @method  rotationZ
     * @description  Defines this instance's $m property elements for a rotation
     *               around the z-axis given the sine and cosine of the rotation angle.
     * @usage  <pre>inst.rotationZ(sine, cosine);</pre>
     * @param   sine   (Number)  -- a real number between -1 and 1 inclusive.
     * @param   cosine   (Number)  -- a real number between -1 and 1 inclusive.
     * @return  (void)
    **/
    public function rotationZ(sine:Number, cosine:Number):void {
        // set the elements of the rotation matrix
        $m[0][0] = cosine; $m[0][1] = -sine;  $m[0][2] = 0.0;
        $m[1][0] = sine;   $m[1][1] = cosine; $m[1][2] = 0.0;
        $m[2][0] = 0.0;    $m[2][1] = 0.0;    $m[2][2] = 1.0;
    }

      // 24. rotationAxis -------------------------------

    /**
     * @method  rotationAxis
     * @description  Defines this instance's $m property elements for a rotation
     *               around a unit Vector object axis given the sine and cosine of
     *               the rotation angle.
     * @usage  <pre>inst.rotationAxis(V, sine, cosine);</pre>
     * @param   V   (Vector)  -- a direction Vector object.
     * @param   sine   (Number)  -- a real number between -1 and 1 inclusive.
     * @param   cosine   (Number)  -- a real number between -1 and 1 inclusive.
     * @return  (void)
    **/
    public function rotationAxis(V:Vector, sine:Number, cosine:Number):void {
        var t:Number = 1-cosine;

        // set the elements of the rotation matrix
        $m[0][0] = t*V.x*V.x+cosine;
        $m[0][1] = t*V.x*V.y-sine*V.z;
        $m[0][2] = t*V.x*V.z+sine*V.y;

        $m[1][0] = t*V.x*V.y+sine*V.z;
        $m[1][1] = t*V.y*V.y+cosine;
        $m[1][2] = t*V.y*V.z-sine*V.x;

        $m[2][0] = t*V.x*V.z-sine*V.y;
        $m[2][1] = t*V.y*V.z+sine*V.x;
        $m[2][2] = t*V.z*V.z+cosine;
    }

}// class
}//package

