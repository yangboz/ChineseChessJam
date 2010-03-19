package com.vizsage.as3mathlib.math.calc {
/**
 * @class       com.vizsage.as3mathlib.math.calc.Integral
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description Implements the static behaviours of the Integral Class.
 *              This class cannot be subclassed or instantiated because all
 *              methods are static.
 * @usage       <pre>Integral.classMethod(args);</pre>
 * @param       none  -- static methods are called directly without class instantiation.
 * -----------------------------------------------
 * Latest update: September 19, 2004
 * -----------------------------------------------
 * AS2  revision copyright: � 2004, Richard Wright     [wisolutions2002@shaw.ca]
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
 *       Integral()
 *           1.  trapezoidal(f, start, stop, n, tol)
 *           2.  simpson(f, start, stop, n)
 *           3.  simpsonTol(f, start, stop, n, tol)
 *           4.  romberg(f, start, stop, n, tol)
 *           5.  ode(f, start, stop, tol)
 *           6.  fillArray(f, start, stop, tol, n)
 *           7.  fillArrayData(f, start, stop, tol, data)
 *           8.  relativePrecision(epsilon, result)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.calc.*;

public class Integral  {
	/**
	 * @property $MAX_ITERATIONS  (Number)  -- maximum iterations.
	**/
    public var $MAX_ITERATIONS:Number = 15;

    public function Integral() {
        trace ("Integral Class loaded");
    }

      // 1. trapezoidal --------------------------------

    /**
     * @method  trapezoidal
     * @description Integrates the function using the trapezoidal method.
     * @usage  <pre>Integral.trapezoidal(f, start, stop, n, tol);</pre>
     * @param f  (Function)  -- the function.
     * @param start  (Number)  -- the first ordinate.
     * @param stop  (Number)  -- the last ordinate.
     * @param n  (Number)  -- the number of partitions.
     * @param tol  (Number)  -- relative tolerance.
     * @return  (Number)  -- returns the integral.
    **/
    public function trapezoidal(f:Function, start:Number, stop:Number, n:Number, tol:Number):Number {
        trace ("**Integral trapezoidal fired");
        var step:Number = stop-start;
        var sign:Number = (step<0) ? -1 : 1;

        if (sign<1) {
            trace ("**Integral trapezoidal 1 sign: "+sign);
            step = -step;
            var temp:Number = start;
            start = stop;
            stop = temp;
        }

        var iterations:Number = 0;
        var sum:Number = (Number(f.call(this, stop))+Number(f.call(this, start)))*step*0.5;
        var oldSum:Number;

        do {
            var x:Number = start+0.5*step;
            var newSum:Number = 0;
            trace ("**Integral trapezoidal 2 x: "+x+", stop: "+stop);

            oldSum = sum;
            if (x<stop) {
                newSum += Number(f.call(this, x));
                x += step;
                trace ("**Integral trapezoidal 3 x: "+x+", newSum: "+newSum+", step: "+step);
            }
            sum = (step*newSum+sum)*0.5;
            step *= 0.5;
            iterations++;
            n /= 2;
            trace ("**Integral trapezoidal 4 n: "+n);
        }
        while (n>0 || (iterations<$MAX_ITERATIONS && relativePrecision(Math.abs(sum-oldSum), sum)>tol));

        return sign*sum;
    }

      // 2. simpson ----------------------------------

    /**
     * @method  simpson
     * @description  Numerical integration using Simpson's rule.
     * @usage  <pre>Integral.simpson(f, start, stop, n);</pre>
     * @param  f  (Function)  -- a function.
     * @param  start  (Number)  -- the first ordinate.
     * @param  stop  (Number)  -- the last ordinate.
     * @param  n  (Number)  -- the number of partitions.
     * @return  (Number)  -- returns the integral.
    **/
    public function simpson(f:Function, start:Number, stop:Number, n:Number):Number {
        trace ("**Integral simpson fired");
        if (n%2!=0) {
            throw new Error(
            "Number of partitions must be even in Simpson's method.");
        }

        var sumOdd:Number = 0.0;
        var sumEven:Number = 0.0;
        var x:Number = start;
        var h:Number = (stop-start)/(2*n);

        for (var i:Number=0;i<n-1;i++) {
            sumOdd += Number(f.call(this, x+h));
            sumEven += Number(f.call(this, x+2*h));
            x += 2.0*h;
            trace ("**Integral simpson 1 i: "+i+", x: "+x);
        }
        sumOdd += Number(f.call(this, x+h));
        trace ("**Integral simpson 2 sumOdd: "+sumOdd);

        return h/3.0*(f.call(this, start)+4.0*sumOdd+2.0*sumEven+f.call(this, stop));
    }

      // 3. simpsonTol ------------------------------

    /**
     * @method  simpsonTol
     * @description  Numerical integration using Simpson's rule.
     * @usage  <pre>Integral.simpsonTol(f, start, stop, n, tol);</pre>
     * @param  f  (Function)  -- the function.
     * @param  start  (Number)  -- the first ordinate.
     * @param  stop  (Number)  -- the last ordinate.
     * @param  n  (Number)  -- minimum number of partitions.
     * @param  tol  (Number)  -- relative tolerance.
     * @return  (Number)  -- returns the integral.
    **/
    public function simpsonTol(f:Function, start:Number, stop:Number, n:Number, tol:Number):Number {
        trace ("**Integral simpsonTol fired");
        var step:Number = stop-start;
        var sign:Number = (step<0) ? -1 : 1;

        if (sign<1) {
            trace ("**Integral simpsonTol 1 sign: "+sign);
            var temp:Number = start;

            start = stop;
            stop = temp;
            step = -step;
        }

        var iterations:Number = 0;
        var sum:Number = (Number(f.call(this, stop))+Number(f.call(this, start)))*step*0.5;
        var result:Number = sum;
        var oldSum:Number;
        var oldResult:Number = result;

        do {
            var x:Number = start+0.5*step;
            var newSum:Number = 0;
            trace ("**Integral simpsonTol 2 x: "+x);

            oldSum = sum;
            if (x<stop) {
                newSum += Number(f.call(this, x));
                x += step;
                trace ("**Integral simpsonTol 3 x: "+x);
            }
            sum = (step*newSum+sum)*0.5;
            step *= 0.5;
            iterations++;
            oldResult = result;
            result = (4*sum-oldSum)/3.0;
            n /= 2;
            trace ("**Integral simpsonTol 4 n: "+n);
        }
        while (n>0 || (iterations<$MAX_ITERATIONS && relativePrecision(Math.abs(result-oldResult), result)>tol));

        return sign*result;
    }

      // 4. romberg --------------------------------

    /**
     * @method  romberg
     * @description  Integrates the function using Romberg's algorithm based on Richardson's deferred approach.
     * @usage  <pre>Integral.romberg(f, start, stop, n, tol);</pre>
     * @param  f  (Function)  -- the function.
     * @param  start  (Number)  -- the first ordinate.
     * @param  stop  (Number)  -- the last ordinate.
     * @param  tol  (Number)  -- relative tolerance.
     * @return    (Number)  -- returns the integral.
    **/
    public function romberg(f:Function, start:Number, stop:Number, n:Number, tol:Number):Number {
        trace ("**Integral romberg fired");
        if (start==stop) return (0);
        if (tol<=0) return Number.NaN; // eps must be positive

        var coef:Array = new Array($MAX_ITERATIONS);
        var h:Number = (stop-start)/n; // starting value for step size
        var k:Number;

        // first row
        coef[0] = .5*(Number(f.call(this, start))+Number(f.call(this, stop)));
        for (k=1;k<n;k++) coef[0] += Number(f.call(this, start+k*h));
        coef[0] *= h;
        for (var j:Number=1;j<$MAX_ITERATIONS;j++) {
            trace ("**Integral romberg 1 j: "+j);
            h /= 2;
            var c0:Number = coef[0];
            coef[0] = coef[j] = 0;
            // further quadrature
            for (k=0;k<n;k++) coef[0] += Number(f.call(this, start+(2*k+1)*h));
            coef[0] = .5*c0+h*coef[0];
            var inc:Number = 1;
            for (k=1;k<=j;k++) {
                inc *= 4;
                var Lk:Number = coef[k];
                coef[k] = (inc*coef[k-1]-c0)/(inc-1);
                c0 = Lk;
                trace ("**Integral romberg 2 coef["+k+"]: "+coef[k]+", c0: "+c0);
            }
            //Math.abs(coef[j]-coef[j-1]) is est error
            if (relativePrecision(Math.abs(coef[j]-coef[j-1]), coef[j])<tol) {
                trace ("**Integral romberg 3 coef["+j+"]: "+coef[j]);
                return coef[j];
            }
            n *= 2;
            trace ("**Integral romberg 4 n: "+n);
        }

        return Number.NaN; // accuracy not achieved
    }

      // 5. ode --------------------------------

    /**
     * @method  ode
     * @description  Computes the integral of the function using an ODE solver.
     * @usage  <pre>Integral.ode(f, start, stop, tol);</pre>
     * @param  f  (Function)  -- the function.
     * @param  start  (Number)  -- the first ordinate.
     * @param  stop  (Number)  -- the last ordinate.
     * @param  tol  (Number)  -- relative tolerance.
     * @return  (Number)  -- returns the integral.
    **/
    public function ode(f:Function, start:Number, stop:Number, tol:Number):Number {
    	throw new Error("AS2-AS3 Transition Error: why were they implementing an Interface?");
    	/*
        trace ("**Integral ode fired");
        var iode:IODE = new FunctionRate(f, start);
        var ode_method:IODESolver = new IODESolver(iode); //RK45MultiStep(ode);

        ode_method.setTolerance(tol);
        ode_method.setStepSize(stop-start);  // must be a fixed step size method
        ode_method.step();

        return iode.getState()[0];
        */
    }

      // 6. fillArray ----------------------------

    /**
     * @method  fillArray
     * @description  Fills a data array with the integral of the given function.
     * @usage  <pre>Integral.fillArray(f, start, stop, tol, n);</pre>
     * @param  f  (Function)  -- to be integrated.
     * @param  start  (Number)  -- start of integral.
     * @param  stop  (Number)  -- end of integral.
     * @param  tol  (Number)  -- computation tolerance.
     * @param  n  (Number)  -- number of data points.
     * @return  (Array)  -- returns a nested data array.
    **/
    public function fillArray(f:Function, start:Number, stop:Number, tol:Number, n:Number):Array {
        trace ("**Integral fillArray fired");
        var data:Array = [];
        data[0] = new Array(n);
        data[1] = new Array(n);

        return fillArrayData(f, start, stop, tol, data);
    }

      // 7. fillArrayData --------------------------------

    /**
     * @method  fillArrayData
     * @description  Fills the given data array with the integral of the given function.
     * @usage  <pre>Integral.fillArrayData(f, start, stop, tol, data);</pre>
     * @param  f  (Function)  -- to be integrated.
     * @param  start  (Number)  -- start of integral.
     * @param  stop  (Number)  -- end of integral.
     * @param  tol  (Number)  -- computation tolerance.
     * @param  data  (Array)  -- a 2-dimensional array.
     * @return  (Array)  -- returns a nested data array.
    **/
    public function fillArrayData(f:Function, start:Number, stop:Number, tol:Number, data:Array):Array {
    	throw new Error("AS2-AS3 Transition Error: why were they implementing an Interface?");
    	/*
        trace ("**Integral fillArrayData fired");
        var iode:IODE = new FunctionRate(f, start);
        var iode_method:IODESolver = new IODESolver(iode); //ODEMultistepSolver(ode);  // must be a fixed step size algorithm

        iode_method.setTolerance(tol);

        var dx:Number = 1;
        var n:Number = data[0].length;

        if (n>1) dx = (stop-start)/(n-1);
        iode_method.setStepSize(dx);
        for (var i:Number=0;i<n;i++) {
            data[0][i] = iode.getState()[1];
            data[1][i] = iode.getState()[0];
            iode_method.step();
        }

        return data;
        */
    }

      // 8. relativePrecision ------------------------

    /**
     * @method  relativePrecision
     * @description  Defines relative precision based on input.
     * @usage  <pre>Integral.relativePrecision(epsilon, result);</pre>
     * @param epsilon(Number)  -- the absolute error.
     * @param result(Number)  -- the result.
     * @return  (Number)  -- returns the relative error.
    **/
    public function relativePrecision(epsilon:Number, result:Number):Number {
        trace ("**Integral relativePrecision fired");
        return (result>Number.MIN_VALUE) ? epsilon/result : epsilon;
    }

}// class
}//package

