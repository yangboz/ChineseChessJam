package com.vizsage.as3mathlib.math.num {
/**
 * @class       com.vizsage.as3mathlib.math.num.Stat
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static behaviours of the Stat Class, which deals
 *              with Probability and Statistics math algorithms.
 *              <p>
 * @usage       <pre>Stat.classMethod(args);</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright © more developers recognized within functions
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
 *       Stat()
 *           1. permutations(n, r)
 *           2. combinations(n, r)
 *           3. gcd(a, b)
 *           4. lcm(a, b)
 *           5. percentage(a, b)
 *           6. mean(arr)
 *           7. variance(arr)
 *           8. sd(arr)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.num.Factor;

public class Stat  {
	/**
	 * @property none  -- no class properties.
	**/

    public function Stat() {
        //trace ("Stat Class loaded");
    }

      // 1. permutations -------------------------------

    /**
     * @method  permutations
     * @description  Number of ways to arrange a list -- order matters.
     * @usage  <pre>Stat.permutations(n, r);</pre>
     * @param   n   (Number)  -- a real number.
     * @param   r   (Number)  -- a positive integer.
     * @return  (Number)  -- returns total number of permutations.
    **/
    public static function permutations(n:Number, r:Number):Number {
        return Factor.factorial(n)/Factor.factorial(n-r);
    }

      // 2. combinations -------------------------------

    /**
     * @method  combinations
     * @description  Number of ways to arrange a list -- order doesn't matter.
     * @usage  <pre>Stat.combinations(n, r);</pre>
     * @param   n   (Number)  -- a real number.
     * @param   r   (Number)  -- a positive integer.
     * @return  (Number)  -- returns total number of combinations.
    **/
    public static function combinations(n:Number, r:Number):Number {
        return Stat.permutations(n, r)/Factor.factorial(r);
    }

      // 3. gcd ----------------------------------------

    /**
     * @method  gcd
     * @description  Defines greatest common divisor of two input numbers.
     * @usage  <pre>Stat.gcd(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns greatest common divisor of two input numbers.
    **/
    public static function gcd(a:Number, b:Number):Number {
        if(a==0) return b;

        var r:Number;

        while(b!=0) {
            r = a%b;
            a = b;
            b = r;
        }

        return Math.abs(a);
    } // actionscript@bokelberg.de - Nov. 2001

      // 4. lcm ----------------------------------------

    /**
     * @method  lcm
     * @description  Defines lowest common multiple of two input numbers.
     * @usage  <pre>Stat.lcm(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns lowest common multiple of two input numbers.
    **/
    public static function lcm(a:Number, b:Number):Number {
        var ta:Number = a;
        var tb:Number = b;
        var tr:Number;

        do {
            if((tr=a%b)==0) break;
            a = b;
            b = tr;
        }
        while (1);

        return ta*tb/b;
    } // v3nom - Feb 2002

      // 5. percentage ---------------------------------

    /**
     * @method  percentage
     * @description  Defines percentage of two input numbers.
     * @usage  <pre>Stat.percentage(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns percentage of two input numbers.
    **/
    public static function percentage(a:Number, b:Number):Number {
        return (a/b)*100;
    }

      // 6. mean ---------------------------------------

    /**
     * @method  mean
     * @description  Defines the mean for an array of numbers.
     * @usage  <pre>Stat.mean(arr);</pre>
     * @param   arr   (Array)  -- a list of real numbers.
     * @return  (Number)  -- returns the mean for an array of numbers.
    **/
    public static function mean(arr:Array):Number {
        var l:Number = arr.length;
        var s:Number = 0;

        while (l--) s += arr[l];

        return s/arr.length;
    }

      // 7. variance -----------------------------------

    /**
     * @method  variance
     * @description  Defines the variance for an array of numbers.
     * @usage  <pre>Stat.variance(arr);</pre>
     * @param   arr   (Array)  -- a list of real numbers.
     * @return  (Number)  -- returns the variance for an array of numbers.
    **/
    public static function variance(arr:Array):Number {
	    var x:Number = 0;
        var x2:Number = 0;
        var len:Number = arr.length;
	    var j:Number;

	    for (j=0;j<len;j++) {
		    x += arr[j];
		    x2 += arr[j]*arr[j];
	    }

	    return ((len*x2)-(x*x))/(len*(len-1));
    }

      // 8. sd -----------------------------------------

    /**
     * @method  sd
     * @description  Defines the standard deviation for an array of numbers.
     * @usage  <pre>Stat.sd(arr);</pre>
     * @param   arr   (Array)  -- a list of real numbers.
     * @return  (Number)  -- returns the standard deviation for an array of numbers.
    **/
    public static function sd(arr:Array):Number {
        return Math.sqrt(Stat.variance(arr));
    }

}// class
}//package

