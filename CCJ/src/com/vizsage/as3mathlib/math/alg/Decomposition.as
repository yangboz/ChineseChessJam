package com.vizsage.as3mathlib.math.alg {
/**
 * @class       com.vizsage.as3mathlib.math.alg.Decomposition
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Decomposition Class.
 *              <p>
 *		        Provides methods for calculating the decompositionm of a matrix.
 * @usage       <pre>var inst:Decomposition = new Decomposition();</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: January 3, 2005
 * -----------------------------------------------
 * AS2 revision copyright: � 2004, Richard Wright  [wisolutions2002@shaw.ca]
 * JS  original copyright: � 2002, Lucio Tavernini [http://tavernini.com/newton.shtml]
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
 * Functions:
 *       Decomposition()
 *           1.  squareMatrixCreate(order)
 *           2.  symMatrixCreate(order)
 *           3.  destroy()
 *           4.  norm(x)
 *           5.  singular()
 *           6.  factorDirectLU()
 *           7.  solveDirectLU(x, y)
 *           8.  factorPivotingLU()
 *           9.  solvePivotingLU(x, y)
 *           10. factorCholesky()
 *           11. solveCholesky(x, y)
 *           12. newton(m, f, p_arr, bound)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.num.Format;

public class Decomposition  {
	/**
	 * @property $order (Number)  -- a positive integer for matrix size.
	 * @property $newtonIterations (Number)  --
	 * @property $newtonMaxIterations (Number)  --
	 * @property $element (Array)  --
	 * @property $index (Array)  --
	 * @property $debug (String)  -- trace string.
	**/
    public var $order:Number;
    public var $newtonIterations:Number;
    public var $newtonMaxIterations:Number;
    public var $element:Array;
    public var $index:Array;
    public var $debug:String;

    // constructor
    public function Decomposition() {
        //trace ("Decomposition Class loaded");
    }

      // 1. squareMatrixCreate -------------------------

    /**
     * @method  squareMatrixCreate
     * @description  Square matrix creator.
     * @usage  <pre>inst.squareMatrixCreate(order);</pre>
     * @param   order   (Number)  -- a positive integer for matrix size.
     * @return  (void)
    **/
    public function squareMatrixCreate(order:Number):void {
        trace ("$$ squareMatrixCreate fired!");

        var element:Array = new Array(order);
        var index:Array = new Array(order);
        var i:Number;

        for (i=0;i<order;i++) {
            element[i] = new Array(order);
            index[i] = i;
        }
        $order = order;
        $element = element;
        $index = index;
        //this.factorPivotingLU = factorPivotingLU;
        //this.solvePivotingLU = solvePivotingLU;
        //this.destroy = destroy;
    }

      // 2. symMatrixCreate ----------------------------

    /**
     * @method  symMatrixCreate
     * @description ** function description here
     * @usage  <pre>inst.symMatrixCreate(order);</pre>
     * @param   order   (Number)  -- a positive integer for matrix size.
     * @return  (void)
    **/
    public function symMatrixCreate(order:Number):void {
        var element:Array = new Array(order);
        var i:Number;

        for (i=0;i<order;i++) element[i] = new Array(i+1);
        $order = order;
        $element = element;
        //this.factorCholesky = factorCholesky;
        //this.solveCholesky = solveCholesky;
        //this.destroy = destroy;
    }

      // 3. destroy ------------------------------------

    /**
     * @method  destroy
     * @description  Matrix destructor.
     * @usage  <pre>inst.destroy();</pre>
     * @return  (void)
    **/
    public function destroy():void {
        trace ("$$ destroy fired!");

        var i:Number;

        for (i=0;i<$order;i++) {
        	delete $element[i];
        }
        // FIXME -- delete causes complaint in AS3
		// delete $element;
        // FIXME -- delete causes complaint in AS3
		// delete $index;
    }

      // 4. norm ---------------------------------------

    /**
     * @method  norm
     * @description  Calculates the 1-norm of x.
     * @usage  <pre>inst.norm(x);</pre>
     * @param   x_arr   (Array)  --
     * @return  (Number)  --
    **/
    public function norm(x_arr:Array):Number {
        //trace ("$$ norm fired!");

        var i:Number;
        var sum:Number = 0;

        for (i=0;i<x_arr.length;i++) sum += Math.abs(x_arr[i]);

        return sum;
    }

      // 5. singular -----------------------------------

    /**
     * @method  singular
     * @description ** function description here
     * @usage  <pre>inst.singular();</pre>
     * @return  (Boolean)
    **/
    public function singular():Boolean {
        trace ("$$ singular fired!");

        $debug += ("\nError: The matrix appears to be singular.\n");

        //return -1;
        return true;
    }

      // 6. factorDirectLU -----------------------------

    /**
     * @method  factorDirectLU
     * @description  Attempts to factor the matrix A as A = LU using Gauss
     *               elimination without row interchanges.
     * @usage  <pre>inst.factorDirectLU();</pre>
     * @return  (Boolean)
    **/
    public function factorDirectLU():Boolean {
        var i:Number, j:Number, k:Number, pivot:Number, multiplier:Number;
        var n:Number = $order;

        for (k=0;k<n-1;k++) {
            pivot = $element[k][k];
            if (pivot==0) return singular();
            for (i=k+1;i<n;i++) {
                $element[i][k] = (multiplier=$element[i][k]/pivot);
                for (j=k+1;j<n;j++) {
                    $element[i][j] -= multiplier*$element[k][j]
                }
            }
        }
        // Test a[n-1, n-1].
        if ($element[n-1][n-1] == 0) return this.singular();

        return false;
    }

      // 7. solveDirectLU ------------------------------

    /**
     * @method  solveDirectLU
     * @description  Solves Ax = y after A has been factored as A = LU.
     * @usage  <pre>inst.solveDirectLU(x_arr, y_arr);</pre>
     * @param   x_arr   (Array)  --
     * @param   y_arr   (Array)  --
     * @return  (void)
    **/
    public function solveDirectLU(x_arr:Array, y_arr:Array):void {
        var i:Number, j:Number, sum:Number;
        var n:Number = $order;

        // Forward Substitution
        for (i=0;i<n;i++) {
            for (sum=0, j=0;j<i;j++) {
                sum += $element[i][j]*x_arr[j];
            }
            x_arr[i] = y_arr[i]-sum;
        }
        // Back Substitution
        for (i=n-1;i>=0;i--) {
            for (sum=0, j=i+1;j<n;j++) {
                sum += $element[i][j]*x_arr[j];
            }
            x_arr[i] = (x_arr[i]-sum)/$element[i][i];
        }
    }

      // 8. factorPivotingLU ---------------------------

    /**
     * @method  factorPivotingLU
     * @description  Attempts to factor a row-permutation of A as PA = LU,
     *               where P is a row-permutation matrix.  Represent P by
     *               recording the permutations in the array '$index'.
     *               Use equilibrated partial pivoting.
     * @usage  <pre>inst.factorPivotingLU();</pre>
     * @return  (Boolean)
    **/
    public function factorPivotingLU():Boolean {
        trace ("$$ factorPivotingLU fired!");

        var i:Number, ii:Number, j:Number, k:Number, kk:Number, temp:Number;
        var pivot:Number, multiplier:Number, max:Number, pivotRow:Number;
        var n:Number = $order;
        var equilibration:Array = new Array();

        // Initialize row indices.  Compute equilibration factors.
        for (i=0;i<n;i++) {
            for (max=0, j=0;j<n;j++) {
                max = ((temp = Math.abs($element[i][j]))>max) ? temp : max;
            }
            if (max==0) return singular();
            equilibration[i] = 1/max;
        }
        // Factor the matrix using Gauss elimination.
        for (k=0;k<n-1;k++) {
            for (max=0, i=k;i<n;i++) {
                ii = $index[i];
                if ((temp = Math.abs($element[ii][k])*equilibration[ii])>max) {
                    max = temp;
                    pivotRow = i;
                }
            }
            j = $index[k];
            $index[k] = $index[pivotRow];
            $index[pivotRow] = j;
            kk = $index[k];
            pivot = $element[kk][k];

            if (pivot==0) return singular();
            for (i=k+1;i<n;i++) {
                ii = $index[i];
                $element[ii][k] = (multiplier = $element[ii][k]/pivot);
                for (j=k+1;j<n;j++) {
                    $element[ii][j] -= multiplier*$element[kk][j];
                }
            }
        }

        // Test the actual a[n-1, n-1].
        if ($element[$index[n-1]][n-1]==0) return this.singular();
        //return 0;
        return false;
    }

      // 9. solvePivotingLU ----------------------------

    /**
     * @method  solvePivotingLU
     * @description  Solves Ax = y after A has been factored as PA = LU,
     *               where P is the row-permutation matrix represented
     *               by the array '$index'.
     * @usage  <pre>inst.solvePivotingLU(x_arr, y_arr);</pre>
     * @param   x_arr   (Array)  --
     * @param   y_arr   (Array)  --
     * @return  (void)
    **/
    public function solvePivotingLU(x_arr:Array, y_arr:Array):void {
        trace ("$$ solvePivotingLU fired!");

        var i:Number, ii:Number, j:Number, sum:Number;
        var n:Number = $order;

        // Forward substitution
        for (i=0;i<n;i++) {
            ii = $index[i];
            for (sum=0, j=0;j<i;j++) sum += $element[ii][j]*x_arr[j];
            x_arr[i] = y_arr[ii]-sum;
        }
        // Back substitution
        for (i=n-1;i>=0;i--) {
            ii = $index[i];
            for (sum=0, j=i+1;j<n;j++) {
                sum += $element[ii][j]*x_arr[j];
            }
            x_arr[i] = (x_arr[i]-sum)/$element[ii][i];
        }
    }

      // 10. factorCholesky -----------------------------

    /**
     * @method  factorCholesky
     * @description  Factors the symmetric positive definite matrix A in the form
     *               A = LDU, where L is the transpose of U, a unit upper-triangular
     *               matrix, and where D is a diagonal matrix.  A square root-free
     *               modification of Cholesky's method is used.
     * @usage  <pre>inst.factorCholesky();</pre>
     * @return  (Boolean)
    **/
    public function factorCholesky():Boolean {
        var i:Number, j:Number, k:Number, sum:Number;
        var n:Number = $order;
        // Allocate the equilibration array.
        var s:Array = new Array(n);

        // Factor the matrix.
        for (i=0;i<n;i++) {
            for (j=0;j<=i-1;j++) {
                s[j] = $element[i][j];
                for (k=0;k<=j-1;k++) {
                    s[j] -= s[k]*$element[j][k];
                }
                if ($element[j][j]==0) return singular();
                $element[i][j] = s[j]/$element[j][j];
            }
            sum = $element[i][i];
            for (k=0;k<=i-1;k++) sum -= s[k]*$element[i][k];
            $element[i][i] = sum;
        }

        return false;
    }

 // 11. solveCholesky ------------------------------

    /**
     * @method  solveCholesky
     * @description  Solves the linear system Ax = y after a has been factored
     *               by factorCholesky.
     * @usage  <pre>inst.solveCholesky(x_arr, y_arr);</pre>
     * @param   x_arr   (Array)  --
     * @param   y_arr   (Array)  --
     * @return  (void)
    **/
    public function solveCholesky(x_arr:Array, y_arr:Array):void {
        var i:Number, j:Number;
        var n:Number = $order;

        // Forward substitution
        for (i=0;i<n;i++) {
            for (x_arr[i]=y_arr[i], j=0;j<=i-1;j++) {
                x_arr[i] -= $element[i][j]*x_arr[j];
            }
        }
        // Back substitution
        for (i=n-1;i>=0;i--) {
            for (x_arr[i]/=$element[i][i], j=i+1;j<n;j++) {
                x_arr[i] -= $element[j][i]*x_arr[j];
            }
        }
    }

      // 12. newton -------------------------------------

    /**
     * @method  newton
     * @description  Newton's method With damping in n-space.
     *               <p>
     *               An attempt to solve f(x) = 0 using Newton's method with damping.
     *               The Jacobian matrix of f is approximated using finite differences.
     * @usage  <pre>inst.newton(m, f, p_arr, bound);</pre>
     * @param   m   (Number)  --
     * @param   f   (Function)  -- the function.
     * @param   p_arr   (Array)  --
     * @param   bound   (Number)  --
     * @return  (Array)  -- returns
    **/
    public function newton(m:Number, f:Function, p_arr:Array, bound:Number):Array {
        trace ("$$ newton fired!");

        var eps:Number, h:Number, i:Number, j:Number;
        var n_singular:Number, delta:Number, save:Number;
        var norm_f_x:Number, norm_f_z:Number, norm_y:Number;
        var abort:Boolean = false;
        var failure:Boolean = false;
        //  Allocate memory.
        var a:Decomposition = new Decomposition();
        var x:Array = new Array(m);
        var y:Array = new Array(m);
        var z:Array = new Array(m);
        var f_x:Array = new Array(m);
        var f_z:Array = new Array(m);

        // Initialize.
        a.squareMatrixCreate(m);
        x = p_arr;
        f_x = f(x);
        norm_f_x = norm(f_x);
        eps = 4096*Format.dbleEpsilon();
        $newtonIterations = 0;
        trace ("newton 1. x:"+x+", f_x:"+f_x+", norm_f_x:"+norm_f_x+", eps:"+eps);
        do {
            ++$newtonIterations;
            // a = approximate value of -f'(x).
            delta = eps*(1+norm(x));
            for (j=0;j<m;j++) {
                save = x[j];
                x[j] += delta;
                y = f(x);
                for (i=0;i<m;i++) {
                    a.$element[i][j] = (f_x[i]-y[i])/delta;
                    trace ("newton 2. a.$element["+i+"]["+j+"]:"+a.$element[i][j]);
                }
                x[j] = save;
            }
            //  Try to solve ay = f(x).
            n_singular = 0;
            do {
                failure = a.factorPivotingLU();
                trace ("newton 3. failure:"+failure);
                if (failure) {
                    ++n_singular;
                    //  Perturb the approximate Jacobian matrix a.
                    for (j=0;j<m;j++) {
                        for (i=0;i<m;i++) {
                            a.$element[i][j] += delta;
                            trace ("newton 4. a.$element["+i+"]["+j+"]:"+a.$element[i][j]);
                        }
                    }
                }
                abort = n_singular>$newtonMaxIterations;
            }
            while (!abort && failure);
            if (!abort) {
                //  Solve the linear system.
                a.solvePivotingLU(y, f_x);
                trace ("newton 5. a.solvePivotingLU:"+a.solvePivotingLU(y, f_x));
                //  Perform the one-dimensional search.
                h = 2;
                do {
                    h = 0.5*h;
                    for (i=0;i<m;i++) {
                        z[i] = x[i]+h*y[i];
                        f_z = f(z);
                        norm_f_z = norm(f_z);
                        abort = h<eps;
                    }
                }
                while (norm_f_z>=eps && norm_f_z>=norm_f_x && !abort);
                x = z;
                f_x = f_z ;
                norm_f_x = norm_f_z;
            }
            //  Estimate the error.  Check for too many iterations.
            norm_y = norm(y);
            trace ("newton 6. norm_y:"+norm_y);
            abort = $newtonIterations>$newtonMaxIterations;
          //  Test for convergence to within the specified bound.
        }
        while ((!(norm_y<bound || norm_y<eps) || norm_f_x>=eps) && !abort);
        //  If we have a failure, make the appropriate termination.
        if (abort) $debug += ("newton: The approximations failed to converge.");

        return x;
    }

}// class
}//package

