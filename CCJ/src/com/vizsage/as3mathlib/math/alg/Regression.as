package com.vizsage.as3mathlib.math.alg {
	import flash.display.MovieClip;
	
/**
 * @class       com.vizsage.as3mathlib.math.alg.Regression
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Regression Class as an
 *              extended MovieClip. It defines a class instance for polyline
 *              mapping, linear least squares, and polynomial least squares
 *              helper functions.
 *		        <p>
 * @usage       <pre>var inst:Regression = new Regression();</pre>
 * @param       none -- no input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright: � 2004, Richard Wright       [wisolutions2002@shaw.ca]
 * AS1 original copyright: � 2003, James W. Bennett iii [snowballs.chance@hell.com]
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
 *       Regression()
 *           1.  plotPolyline(x_arr, y_arr)
 *           2.  plotLinearData(x_arr, y_arr)
 *           3.  plotPolynomialData(x_arr, y_arr)
 *           4.  calcLinearLeastSquares(x_arr, y_arr)
 *           5.  calcPolynomialLeastSquares(x_arr, y_arr)
 *           6.  calcPolynomial(aVals, deg)
 *           7.  gaussEliminate(coeffs)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Regression extends MovieClip {
	/**
	 * @property none -- no class properties.
	**/

	public function Regression() {
	    //trace ("Regression Class loaded");
	}

      // 1. plotPolyline --------------------------------

    /**
     * @method  plotPolyline
     * @description  Sort x and y values by ascending x values and connect
     *               the points with line segments.
     * @usage  <pre>inst.plotPolyline(x_arrmy_arr);</pre>
     * @param   x_arr   (Array)   -- data array containing x-values from the data set.
     * @param   y_arr   (Array)   -- data array containing y-values from the data set.
     * @return  (void)  -- if successful, a plot is generated on the current mc.
    **/
    public function plotPolyline(x_arr:Array, y_arr:Array):void {
	    var ptCount:Number = x_arr.length;
	    var pt_arr:Array = [ptCount];
	    var i:uint;
	    // stuff x and y values into a temporary array of points
	    for (i=0; i<ptCount; ++i)
		    pt_arr[i] = {x:x_arr[i], y:y_arr[i]};
	    // define an internal sort f\unction
	    var comparePts:Function = function(pt1:Point, pt2:Point):Object {
		    return pt1.x-pt2.x;
	    };
	    // sort x values from low to high
	    pt_arr.sort(comparePts);
	    // move to first point
	    this.graphics.moveTo(pt_arr[0].x, pt_arr[0].y);
	    // plot the resulting line segments
	    for (i=1; i<ptCount; ++i) {
	        this.graphics.lineTo(pt_arr[i].x, pt_arr[i].y);
	    }
    }

      // 2. plotLinearData ----------------------------------

    /**
     * @method  plotLinearData
     * @description  Find the line (y = mx + b) which best fits a given set of
     *               points using the 'least squares' appoach: fit the line to
     *               the data such that the SUM of the SQUARES of the DIFFERENCES
     *               between the line and the data is as small as possible.
     * @usage  <pre>inst.plotLinearData(x_arr, y_arr);</pre>
     * @param   x_arr   (Array)  -- data array containing x-values from the data set.
     * @param   y_arr   (Array)  -- data array containing y-values from the data set.
     * @return  (void) -- a plot is generated on the current mc.
    **/
    public function plotLinearData(x_arr:Array, y_arr:Array):void {
	 	var x1:Number = 0;
	 	var y1:Number = 0;
	 	var x2:Number = 0;
	 	var y2:Number = 0;
	 	var ptCount:Number = x_arr.length;
	 	var i:Number;

	 	trace ("$$$ LinearLeastSquares plotLinearData ptCount:"+ptCount);

	 	x1 = Number(x_arr[0]);
	 	x2 = x1;
	 	// get the minimum and maximum x values from the dataset
	 	for (i=1;i<ptCount;++i) {
	 		x1 = Number(x_arr[i])<x1 ? Number(x_arr[i]) : x1;
	 		x2 = Number(x_arr[i])>x2 ? Number(x_arr[i]) : x2;
	 	}
	 	// if min != max (e.g. line not vertical), we need to calculate the y terms
	 	if (x1!=x2) {
	 		// calculate necessary coeffs
	 		var results:Object = calcLinearLeastSquares(x_arr, y_arr);
	 		// calculate y values using y = mx + b
	 		y1 = results.m*x1+results.b;
	 		y2 = results.m*x2+results.b;
	 	}
	 	else {
	 		// if x1 = x2, the resulting line is vertical and running
	 		// calcLinearLeastSquares will cause a division by zero error.
	 		// Instead, just draw a vertical line using min and max y-values
	 		y1 = Number(y_arr[0]);
	 		y2 = y1;
	 		// get the minimum and maximum y values from the dataset
	 		for (i=1;i<ptCount;++i) {
	 			y1 = Number(y_arr[i])<y1 ? Number(y_arr[i]) : y1;
	 			y2 = Number(y_arr[i])>y2 ? Number(y_arr[i]) : y2;
	 		}
	 	}
	 	// plot the resulting line
	 	this.graphics.moveTo(x1, y1);
	 	this.graphics.lineTo(x2, y2);
	 	trace ("$$$ LinearLeastSquares plotLinearData (x1:"+x1+", y1:"+y1+"), (x2:"+x2+", y2:"+y2+")");
    }

      // 3. plotPolynomialData ------------------------------

    /**
     * @method  plotPolynomialData
     * @description  A method which implements n-degree polynomial solutions to
     *               fit a curve to a set of points. The 'least squares' appoach
     *               is employed: fit the curve to the data such that the SUM of
     *               the SQUARES of the DIFFERENCES between the curve and the data
     *               is as small as possible.
     *               <p>
     *               For degree = 2, the solution is quadratic: y = ax^2 + bx + c
     *               For degree = n, the solution is of the form: y = A0 + A1X + A2X^2 + A3X^3 + ... + AnX^n
     * @usage  <pre>inst.plotPolynomialData(degree, x_arr, y_arr);</pre>
     * @param   degree  (Number)   -- one less than the number of terms in your polynomial.
	 * @param   x_arr  (Array)  -- data array containing x-values from the data set.
     * @param   y_arr  (Array)  -- data array containing y-values from the data set.
     * @return  (void)  -- if successful, a plot is generated on the current mc, otherwise a trace() is fired.
    **/
    public function plotPolynomialData(degree:Number, x_arr:Array, y_arr:Array):void {
		var ptCount:Number = x_arr.length;

		if (ptCount<3) return;
		// if degree = ptCount - 1, solution is as good as it can get using this
		// method. Using a higher degree will cause arbitrary, undesired results.
		// So . . . cap degree at ptCount - 1
		if (degree>ptCount-1) degree = ptCount-1;

		// initialize variables
		var aVals:Array = [];
		var xMin:Number, xMax:Number, x1:Number, x2:Number, xCurrent:Number, dx:Number;

	    // Get the parameters for the quadratic, if there are any
		aVals = this.calcPolynomialLeastSquares(degree, x_arr, y_arr);
	    if (aVals!=null) {
			// There is a solution, so get the min and max x vals from the data set
			x1 = x_arr[0];
			x2 = x1;
			for (var i:uint =1;i<ptCount;++i ) {
				x1 = x_arr[i]<x1 ? x_arr[i] : x1;
				x2 = x_arr[i]>x2 ? x_arr[i] : x2;
			}
	        // Draw the curve
	        this.graphics.moveTo(x1, calcPolynomial(aVals, x1));
	        // size of linesegments for rendered curve, in pixels
	        dx = 1;
	        xCurrent = x1+dx;
	        while (xCurrent<x2) {
	            this.graphics.lineTo(xCurrent, calcPolynomial(aVals, xCurrent));
	            xCurrent += dx;
	        }
	        this.graphics.lineTo(x2, calcPolynomial(aVals, x2));
		}
		else {
			// There is no solution.
	        trace ("There is no solution.");
		}
    }

      // 4. calcLinearLeastSquares --------------------------

    /**
     * @method  calcLinearLeastSquares
     * @description  Use linear least squares method to compute the m and b
     *               coefficients which best describe a given set of ordered
     *               pairs as a single line.
     * @usage  <pre>inst.calcLinearLeastSquares(x_arr, y_arr);</pre>
     * @param   x_arr   (Array)   -- data array containing x-values from the data set.
     * @param   y_arr   (Array)   -- data array containing y-values from the data set.
     * @return  (Object)  -- a results object -- {m: m_term, b: b_term}.
    **/
    public function calcLinearLeastSquares(x_arr:Array, y_arr:Array):Object {
		var ptCount:Number = x_arr.length;	// size of the data set
		var A:Number = 0;                       // summation terms
		var B:Number = 0;
		var C:Number = 0;
		var D:Number = 0;
		var result:Object = {m:0, b:0};		    // holder for resulting m and b terms
		var i:Number;

		trace ("$$$ LinearLeastSquares calcLinearLeastSquares ptCount:"+ptCount);

		// do the summations
		for (i=0;i<ptCount;++i) {
			A += Number(x_arr[i])*Number(x_arr[i]);
			B += Number(x_arr[i]);
			C += Number(x_arr[i])*Number(y_arr[i]);
			D += Number(y_arr[i]);
		}
		trace ("$$$ LinearLeastSquares calcLinearLeastSquares A:"+A+", B:"+B+", C:"+C+", D:"+D);
		// plug in the results and solve for m and b
		// NOTE: if all x values are identical (i.e. vertical line), this equation
		// results in div by zero error, thus the use of infinity clamps
		result.m = (B*D-C*ptCount)/(B*B-A*ptCount);
		result.b = (B*C-A*D)/(B*B-A*ptCount);
		if (result.m==Infinity) result.m = 1e304;
		if (result.m==-Infinity) result.m = -1e304;

		return result;
    }

      // 5. calcPolynomialLeastSquares ----------------------

    /**
     * @method  calcPolynomialLeastSquares
     * @description  Compute the a, b, c, ... n values for polynomial least
     *               squares, caller should check for a 'null' return value
     *               to indicate failure, otherwise an array of coefficients
     *               is returned.
     * @usage <pre>inst.calcPolynomialLeastSquares(degree, xVals, yVals);</pre>
     * @param   deg   (Number)   -- one less than the number of terms in your polynomial.
     * @param   xVals   (Array)   -- data array containing x-values from the data set.
     * @param   yVals   (Array)   -- data array containing y-values from the data set.
     * @return  (Array)  -- failure returns null -- success returns an array of coefficients for the plotting equation.
    **/
    public function calcPolynomialLeastSquares(deg:Number, xVals:Array, yVals:Array):Array {
		var ptCount:uint = xVals.length;
		var i:uint;
		// create a temp holder for the coefficients matrix . . .
		var coeffs:Array  = [];
		// . . . and size it as necessary
		for (i=0;i<=deg;++i) coeffs[i] = [deg];
		// holder for the solution coefficients, if a solution exists
		var aVals:Array = [deg];
		var row:Number, col:Number;	    // index variables
		var total:Number;			// temp holder for summations

		for (row=0;row<=deg;++row) {
	        // Find the coeffsicients for the columns.
	        for (col=0;col<=deg;++col) {
				// reset total
				total = 0;
	            // Find Sum(Xi^(row + col)) over all i.
				for (i=0;i<ptCount;++i) total += Math.pow( xVals[i], row+col);
	            coeffs[row][col] = total;
	        }
			// Find the constant term.
			total = 0;
			for (i=0;i<ptCount;++i) total += yVals[i]*Math.pow(xVals[i], row);
	        coeffs[row][deg+1] = total;
		}
	    // attempt a gaussian elimination.
		// NOTE: "coeffs" will be modified inside the gaussEliminate method
	    if (gaussEliminate(coeffs)) {
	        // grab the last column of coeffs and store it
			for (row=0;row<=deg;++row) aVals[row] = coeffs[row][deg+1];

	        // return the results
			return aVals;
		}
		else {
	        // sorry, there was no solution
	        return null;
		}
    }

      // 6. calcPolynomial ----------------------------------

    /**
     * @method  calcPolynomial
     * @description  Find the value of the polynomial given a set of input coefficients.
     * @usage  <pre>inst.calcPolynomial(aVals, deg);</pre>
     * @param   aVals   (Array)  -- data array containing x-values from the data set.
     * @param   deg   (Number)  -- one less than the number of terms in your polynomial.
     * @return  (Number)  -- returns value of polynomial.
    **/
    public function calcPolynomial(aVals:Array, deg:Number):Number {
	    var max_coeff:Number = aVals.length;
	    var x_power:Number   = 1.0;
		var total:Number     = 0.0;

	    for (var i:uint=0;i<max_coeff;++i) {
	        total += x_power*aVals[i];
	        x_power *= deg;
	    }

	    return total;
    }

      // 7. gaussEliminate ----------------------------------

    /**
     * @method  gaussEliminate
     * @description  If possible, decompose a matrix of N * (N + 1) coefficients
     *               into a single coefficient vector.
     * @usage  <pre>inst.gaussEliminate(coeffs);</pre>
     * @param   coeffs   (Array)   -- an N by N+1 matrix representing the N+1 coefficients of N required equations.
     * @return  (Boolean)  -- a boolean value is returned to indicate success or failure. Additionally, the "coeffs" array is modified directly for use by the calling function (result is the vector represented by column N+1 of 'coeffs').
    **/
    public function gaussEliminate(coeffs:Array):Boolean {
		var factor:Number, tmp:Number, row:Number, col:Number, i:Number, j:Number;
	    var max_row:Number = coeffs.length;
	    var max_col:Number = coeffs[0].length;

	    for (row=0;row<max_row;++row) {
	        // make sure coeffs[row][row] != 0.
	        factor = coeffs[row][row];

	        if (Math.abs(factor)<0.001) {
	            // switch this row with one that is not
	            // zero in position. Find this row.
	            for (i=row+1;i<max_row;++i) {
	                if (Math.abs(coeffs[i][row])>0.001) {
	                    // switch rows i and row.
	                    for (j=0;j<max_col;++j) {
	                        tmp = coeffs[row][j];
	                        coeffs[row][j] = coeffs[i][j];
	                        coeffs[i][j] = tmp;
	                    }
	                    factor = coeffs[row][row];
	                }
				}
	            // see if we found a good row, if not, no solution
	            if (Math.abs(factor)<0.001) return false;
	        }

	        // divide each entry in this row by coeffs[row][row]
	        for (i=0;i<max_col;++i)
	            coeffs[row][i] /= factor;
	        // subtract this row from the others.
	        for (i=0;i<max_row;++i) {
	            if (i!=row) {
					// see what factor we will multiply
	                // by before subtracting for this row.
	                factor = coeffs[i][row];
	                for (j=0;j<max_col;++j) coeffs[i][j] -= factor*coeffs[row][j];
	            }
	        }
	    }
	    // there is a solution.
	    return true;
    }

}// class
}//package

