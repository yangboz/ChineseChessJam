package com.vizsage.as3mathlib.math.calc {
/**
 * @class       com.vizsage.as3mathlib.math.calc.Derivative
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.8
 * @description Implements the behaviours of the Derivative Class. This class is presently under 
 *              construction ... it originally was written with static methods, but I am 
 *              still experimenting, and the class may be instantiated first as well.
 * @usage       <pre>Derivative.classMethod(args);</pre>
 * @param       none  -- static methods are called directly without class instantiation.
 * -----------------------------------------------
 * Latest update: July 8, 2005
 * -----------------------------------------------
 * AS2  revision copyright: � 2005, Richard Wright     [wisolutions2002@shaw.ca]
 * Java original copyright: � 2003, Wolfgang Christian [http://sip.clarku.edu/3e/]
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
 *       Derivative()
 *           1.  romberg(f, x0, h, tol)
 *           2.  centered(f, x, h)
 *           3.  centeredPartial(f, x, n, tol)
 *           4.  second(f, x, tol)
 *           5.  secondFillArray(f, start, stop, tol, n)
 *           6.  secondFillArrayData(f, start, stop, tol, data)
 *           7.  fillArray(f, start, stop, tol, n)
 *           8.  fillArrayData(f, start, stop, tol, data)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.calc.*;

public class Derivative {
	/**
	 * @property none  -- no class properties.
	**/
    public function Derivative() {
        //trace ("Derivative Class fired");
    }

	// 1. romberg ------------------------------------

    /**
     * @method  romberg
     * @description  Calculates the derivative using the Romberg scheme for
     *               Richardson extrapolation.
     *               <p>
     *               This method runs until all Romberg rows are filled or until
     *               the step size drops below defaultNumericalPrecision or if the
     *               desired tolerance is reached.
     * @usage <pre>inst.romberg(f, x0, h, tol);</pre>
     * @param f  (Function)  -- the function.
     * @param x  (Number)  -- where derivative is to be calculated.
     * @param h  (Number)  -- initial step size.
     * @param tol  (Number)  -- desired accuracy.
     * @return  (Number)  -- returns the derivative.
    **/

    //var deriv:Derivative = new Derivative();
    //var derivRomberg:Number = Derivative.romberg(func, x, dx, 1.0e-9);
    //var derivCentered:Number = deriv.centered(func, x, dx);
	
	static public function romberg(f:Function, x:Number, h:Number, tol:Number):Number {
	    var n:Number = 6;  //max. number of columns in the Romberg scheme
	    var d:Array = new Array(n);
	    var j:Number, m:Number, i:Number;
	    var error_code:Number = 1;
	
	    //d[0] = (f.call(this, (x+h))-f.call(this, (x-h)))/h/2.0;
	    d[0] = ((x+h)-(x-h))/h/2.0;
	
	    for(j=1;j<=n-1;j++) {
	        d[j] = 0.0;
	        var d1:Number = d[0];
	        var h2:Number = h;
	        h *= 0.5;
	        if (h<Number.MIN_VALUE) {
	            error_code = 2;  /* step size less than  defaultNumericalPrecision */
	            break;
	        }
	        //d[0] = (f.call(this, (x+h))-f.call(this, (x-h)))/h2;
	        d[0] = ((x+h)-(x-h))/h2;
	        for (m=4, i=1;i<=j;i++, m*=4) {
	            var d2:Number = d[i];
	            d[i] = (m*d[i-1]-d1)/(m-1);
	            d1 = d2;
	        }
	        if (Math.abs(d[j]-d[j-1])<tol) {  /* desired accuracy reached */
	            return d[j];
	        }
	    }
	    throw new Error("Derivative did not converge.");
	    return NaN;
	}
	
	/*
    public function romberg(f:Function, x:Number, h:Number, tol:Number):Number {
        var n:Number = 6;  //max. number of columns in the Romberg scheme
        var d:Array = new Array(n);
        var j:Number, m:Number, i:Number;

        d[0] = (f.call(this, x+h)-f.call(this, x-h))/h/2.0;
        trace ("\n**romberg: \n\nf = "+f+", "+(typeof(f))+", "+(f instanceof Function));
        trace ("x = "+x+", h = "+h+", tol = "+tol);
        trace ("f.call("+this+", "+x+"+"+h+") = "+f.call(this, x+h));
        trace ("\nd[0] = "+d[0]);
        for (j=1;j<n;j++) {
            d[j] = 0.0;
            trace ("a) d["+j+"] = "+d[j]);
            var d1:Number = d[0];
            var h2:Number = h;

            h *= 0.5;
            if (h<Number.MIN_VALUE) break;
            d[0] = (f.call(this, x+h)-f.call(this, x-h))/h2;
            for (m=4, i=1;i<=j;i++, m*=4) {
                var d2:Number = d[i];

                d[i] = (m*d[i-1]-d1)/(m-1);
                d1 = d2;
                trace ("b) d["+i+"] = "+d[i]);
            }
            // desired accuracy reached
            if (Math.abs(d[j]-d[j-1])<tol) return d[j];
        }
        //throw new Error("Derivative did not converge.");
    }
*/

      // 2. centered -----------------------------------

    /**
     * @method  centered
     * @description  Calculates the derivative of a function using the centered
     *               difference approximation.
     * @usage <pre>inst.centered(f, x, h);</pre>
     * @param f  (Function)  -- the function.
     * @param x  (Number)  -- the x value.
     * @param h  (Number)  -- initial step size.
     * @return  (Number)  -- returns the derivative.
    **/
    public function centered(f:Function, x:Number, h:Number):Number {
        //return (f.call(this, x+h)-f.call(this, x-h))/h/2.0;
        return ((x+h)-(x-h))/h/2.0;
    }

      // 3. centeredPartial -----------------------------

    // f:MultiVarFunction -- Java type

    /**
     * @method  centeredPartial
     * @description  Calculates the partial derivative of a function using the
     *               centered difference approximation.
     * @usage <pre>inst.centeredPartial(f, x, n, tol);</pre>
     * @param f  (Function)  -- the function.
     * @param x_arr  (Array)  -- a list of x values.
     * @param n  (Number)  -- initial step size.
     * @param tol  (Number)  -- desired accuracy.
     * @return  (Number)  -- returns the partial derivative.
    **/
    public function centeredPartial(f:Function, x_arr:Array, n:Number, tol:Number):Number {
        var tempPlus:Array = new Array(x_arr.length);
        var tempMinus:Array = new Array(x_arr.length);

        tempPlus = x_arr.concat();
        tempPlus[n] += tol;
        tempMinus = x_arr.concat();
        tempMinus[n] -= tol;

        return (f.call(this, tempPlus)-f.call(this, tempMinus))/2.0/tol;
 }

      // 4. second --------------------------------------

    /**
     * @method  second
     * @description  Calculates the second derivative of a function.
     * @usage <pre>inst.second(f, x, tol);</pre>
     * @param f  (Function)  -- the function.
     * @param x  (Number)  -- the x value.
     * @param tol  (Number)  -- desired accuracy.
     * @return  (Number)  -- returns the second derivative.
    **/
    public function second(f:Function, x:Number, tol:Number):Number {
        if (tol==0) tol = 1.0e-9;

        var dx:Number = tol;
        var dx2:Number = tol*tol;
        var count:Number = 10;
        var d2fdx2:Number = 0;  // second order finite difference result
        var d2fdx4:Number = 0;  // fourth order finite difference result

        do {
            var fP2:Number = Number(f.call(this, x+2*dx));
            var fP1:Number = Number(f.call(this, x+dx));
            var f0:Number = Number(f.call(this, x));
            var fM1:Number = Number(f.call(this, x-dx));
            var fM2:Number = Number(f.call(this, x-2*dx));

            d2fdx2 = (fP1-2*f0+fM1)/dx2;
            d2fdx4 = (-fP2+16*fP1-30*f0+16*fM1-fM2)/dx2/12.0;
            dx /= 10;  // decrease the dx in preparation for next try.
            dx2 = dx*dx;
            count--;
        }
        while (count>0 && Math.abs(d2fdx2-d2fdx4)>tol);

        return d2fdx4;
    }

      // 5. secondFillArray -----------------------------

    /**
     * @method  secondFillArray
     * @description  Fills an array with the second derivative of a function.
     * @usage <pre>inst.secondFillArray(f, start, stop, tol, n);</pre>
     * @param f  (Function)  -- the function.
     * @param start  (Number)  --
     * @param stop  (Number)  --
     * @param tol  (Number)  --
     * @param n  (Number)  --
     * @return  (Array)  -- returns
    **/
    public function secondFillArray(f:Function, start:Number, stop:Number, tol:Number, n:Number):Array {
        var data:Array = [];

        data[0] = new Array(n);
        data[1] = new Array(n);

        return secondFillArrayData(f, start, stop, tol, data);
    }

      // 6. secondFillArrayData -------------------------

    /**
     * @method  secondFillArrayData
     * @description  Fills an array with the second derivative of a function.
     * @usage <pre>inst.secondFillArrayData(f, start, stop, tol, data);</pre>
     * @param f  (Function)  -- the function.
     * @param start  (Number)  --
     * @param stop  (Number)  --
     * @param tol  (Number)  --
     * @param data  (Array)  --
     * @return  (Array)  --
    **/
    public function secondFillArrayData(f:Function, start:Number, stop:Number, tol:Number, data:Array):Array {
        var dx:Number = 1;
        var n:Number = data[0].length;
        var x:Number = start;

        if (n>1) dx = (stop-start)/(n-1);
        for (var i:Number=0;i<n;i++) {
            data[0][i] = x;
            //data[1][i] = romberg(f, x, dx, tol);
            data[1][i] = second(f, x, tol);
            x += dx;
        }

        return data;
    }

      // 7. fillArray -----------------------------------

    /**
     * @method  fillArray
     * @description  Fills an array with the derivatives of a function.
     * @usage <pre>inst.fillArrayData(f, start, stop, tol, data);</pre>
     * @param f  (Function)  -- the function.
     * @param start  (Number)  --
     * @param stop  (Number)  --
     * @param tol  (Number)  --
     * @param n  (Number)  --
     * @return  (Array)  --
    **/
    public function fillArray(f:Function, start:Number, stop:Number, tol:Number, n:Number):Array {
        var data:Array = [];

        data[0] = new Array(n);
        data[1] = new Array(n);

        return fillArrayData(f, start, stop, tol, data);
    }

      // 8. fillArrayData -------------------------------

    /**
     * @method  fillArrayData
     * @description  Fills an array with the derivatives of a function.
     * @usage <pre>inst.fillArrayData(f, start, stop, tol, data);</pre>
     * @param f  (Function)  -- the function.
     * @param start  (Number)  --
     * @param stop  (Number)  --
     * @param tol  (Number)  --
     * @param data  (Array)  --
     * @return  (Array)  --
    **/
    public function fillArrayData(f:Function, start:Number, stop:Number, tol:Number, data:Array):Array {
        var dx:Number = 1;
        var n:Number = data[0].length;
        var x:Number = start;

        if (n>1) dx = (stop-start)/(n-1);
        for (var i:Number=0;i<n;i++) {
            data[0][i] = x;
            data[1][i] = romberg(f, x, dx, tol);
            x += dx;
        }

        return data;
    }
}// class
}

