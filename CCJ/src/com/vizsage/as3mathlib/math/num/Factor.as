package com.vizsage.as3mathlib.math.num {
/**
 * @class       com.vizsage.as3mathlib.math.num.Factor
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static behaviours of the Factor Class.
 * @usage       <code>Factor.classMethod(classProp);</code>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright © developers recognized within functions
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
 *       Factor()
 *           1.  ln(n)
 *           2.  logA(a, n)
 *           3.  summation(n, x)
 *           4.  square(n)
 *           5.  inverse(n)
 *           6.  pow2(a, n)
 *           7.  nRoot(a, n)
 *           8.  factorial(n)
 *           9.  gammaApprox(n)
 *           10. factorialApprox(n)
 *           11. productFactors(n)
 *           12. isPrime(n)
 *           13. isPrime2(n)
 *           14. findPrimeFrom(n, from)
 *           15. primeFactor(n)
 *           16. totient(n)
 *           17. fibonacci(n)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: 14. 'isPrime2' is faster than 13. 'isPrime' but breaks
 *       dependent prime functions, so I've left both in place
 * -----------------------------------------------
**/

public class Factor  {
	/**
	 * @property none  -- no class properties.
	**/

    public function Factor() {
        //trace ("Factor Class loaded");
    }

    /////////////////////////////////
    // Miscellaneous Number Functions
    /////////////////////////////////

      // 1. ln -----------------------------------------

    /**
     * @method  ln
     * @description  Defines the natural logarithm of 'n'.
     * @usage  <pre>Factor.ln(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the natural logarithm of 'n'.
    **/
    public static function ln(n:Number):Number {
        return (Math.log(n));
    }

      // 2. logA ---------------------------------------

    /**
     * @method  logA
     * @description  Defines the logarithm with base 'a' of 'n'.
     * @usage  <pre>Factor.logA(a, n);</pre>
     * @param   a   (Number)  -- a real number for 'log base'.
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the logarithm with base 'a' of 'n'.
    **/
    public static function logA(a:Number, n:Number):Number {
        return (Math.log(n)/Math.log(a));
    }

      // 3. summation ----------------------------------

    /**
     * @method  summation
     * @description  Defines the sum of all the numbers between
     *               1 and 'n' raised to the 'x' power.
     * @usage  <pre>Factor.summation(n, x);</pre>
     * @param   n   (Number)  -- a real number.
     * @param   x   (Number)  -- a real number.
     * @return  (Number)  -- returns the sum of all the numbers between 1 and 'n' raised to the 'x' power.
    **/
    public static function summation(n:Number, x:Number):Number {
        var sum:Number = 0;
        var j:Number;

        for (j=1;j<=n;j++) sum += Math.pow(j, x);

        return sum;
    }

      // 4. square -------------------------------------

    /**
     * @method  square
     * @description  Defines the square of a number.
     * @usage  <pre>Factor.square(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the square of a number.
    **/
    public static function square(n:Number):Number {
        return n*n;
    }

      // 5. inverse ------------------------------------

    /**
     * @method  inverse
     * @description  Defines the inverse of a number.
     * @usage  <pre>Factor.inverse(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the inverse of a number.
    **/
    public static function inverse(n:Number):Number {
        return 1/n;
    }

      // 6. pow2 ---------------------------------------

    /**
     * @method  pow2
     * @description  Solves the negative value input bug.
     * @usage  <pre>Factor.pow2(a, n);</pre>
     * @param   a   (Number)  -- a real number, allowing negative input.
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns a positive square from negative input.
    **/
    public static function pow2(a:Number, n:Number):Number {
        return a==0 ? 0 : (a>0 ? Math.pow(a, n) : Math.pow(a*-1, n)*-1);
    }

      // 7. nRoot --------------------------------------

    /**
     * @method  nRoot
     * @description  Defines the nth root of a number.
     * @usage  <pre>Factor.nRoot(a, n);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the nth root of a number.
    **/
    public static function nRoot(a:Number, n:Number):Number {
        return Factor.pow2(a, 1/n);
    }

      // 8. factorial ----------------------------------

    /**
     * @method  factorial
     * @description  Recursive method that defines the factorial of a positive integer.
     * @usage  <pre>Factor.factorial(n);</pre>
     * @param   n   (Number)  -- a real integer.
     * @return  (Number)  -- returns the factorial of a positive integer.
    **/
    public static function factorial(n:Number):Number {
        if (n!=0) {
            return n*Factor.factorial(n-1);
        }
        else {
            return (1);
        }
    }

      // 9. gammaApprox --------------------------------

    /**
     * @method  gammaApprox
     * @description  Extends the domain of the factorial function by
     *               calculating the factorial of decimal numbers.
     * @usage  <pre>Factor.gammaApprox(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the factorial of a positive floating point number.
    **/
    public static function gammaApprox(n:Number):Number {
        var x:Number = n-1;

        return (Math.sqrt((2*x+1/3)*Math.PI)*Math.pow(x, x)*Math.exp(-x));
    }

      // 10. factorialApprox ---------------------------

    /**
     * @method  factorialApprox
     * @description  Uses the Gamma function to approximate factorial - very fast.
     * @usage  <pre>Factor.factorialApprox(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns an integer approximation of the floating point input's factorial.
    **/
    public static function factorialApprox(n:Number):Number {
        return (Math.round(Factor.gammaApprox(n+1)));
    }

      // 11. productFactors ----------------------------

    /**
     * @method  productFactors
     * @description  Calculates the product of factors of 'n'.
     * @usage  <pre>Factor.productFactors(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the product of factors of 'n'.
    **/
    public static function productFactors(n:Number):Number {
        var k:Number = 1;
        var h:Number;

        for (h=3;h<=n;h+=2) if (Factor.isPrime(h)) k *= h;
        if (n>2) k *= 2;

        return k;
    }

      // 12. fibonacci ----------------------------------

    /**
     * @method  fibonacci
     * @description  Calculates total fibonacci levels in 'n'.
     * @usage  <pre>Factor.fibonacci(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns total fibonacci levels in 'n'.
    **/
    public static function fibonacci(n:Number):Number {
        return Math.round((Math.pow((1+Math.sqrt(5))/2, n)-Math.pow((1-Math.sqrt(5))/2, n))/Math.sqrt(5));
    }

      // 13. isPrime ------------------------------------

    /**
     * @method  isPrime
     * @description  Boolean for 'isPrime' integer condition, ignores decimals.
     * @usage  <pre>Factor.isPrime(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Boolean)
    **/
    public static function isPrime(n:Number):Boolean {
        var h:Number;

        n |= 0;
        if (isNaN(n) || n==0) return false;
        if (n<=3) return true;
        if (n%2==0) return false;

        var iMax:Number = Math.floor(Math.sqrt(n));

        for (h=3;h<=iMax;h+=2) if (n%h==0) return false;

        return true;
    }

      // 14. isPrime2 -----------------------------------

    /**
     * @method  isPrime2
     * @description  Boolean for 'isPrime' integer condition, ignores decimals.
     *               I can't get this to work with the dependent prime functions,
     *               so I'm using the slower version above for now ... it works
     *               on it's own, however!!
     * @usage  <pre>Factor.isPrime2(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Boolean)
    **/
    public static function isPrime2(n:Number):Boolean {
        n |= 0;
        if (isNaN(n) || n==0) return false;
        if (n<=3) return true;
        if (n%2==0) return false;

        var iMax:Number = (Math.sqrt(n)/6 | 0)*6+5;
        var j:Number = 5;

        while (n%j!=0 && n%(j+2)!=0 && (j+=6)!=iMax) {}

        return (j==iMax);
    } // diu - June 2003

      // 15. findPrimeFrom ------------------------------

    /**
     * @method  findPrimeFrom
     * @description  Defines an array of all primes between 'from' and 'n'
     *               inclusive, positive but restricted integer value,
     *               ignores decimals
     * @usage  <pre>Factor.findPrimeFrom(n, from);</pre>
     * @param   n   (Number)  -- a real number.
     * @param   from   (Number)  -- a real number.
     * @return  (Array)  -- returns an array of all primes between 'from' and 'n' inclusive.
    **/
    public static function findPrimeFrom(n:Number, from:Number):Array {
        n |= 0;
        from |= 0;

        var i:Number, j:Number;
        var output_arr:Array = [];
        var count_arr:Array = [];

        if (!from) from = 0;
        else from -= 1;
        n += 1;
        for (i=0;i<n;i++) count_arr[i] = 0;

        var sqrtN:Number = Math.round(Math.sqrt(n+1));
        var last:Number = 2;

        for (i=2;i<=sqrtN;i++) {
            if (count_arr[i]==0) {
                for (j=last*i;j<n;j+=i) count_arr[j] = 1;
                last = i;
            }
        }
        for (i=n-1;i>from;i--) {
            if (count_arr[i] == 0) output_arr.push(i);
        }

        return output_arr;
    } // persist - June 2003

      // 16. primeFactor --------------------------------

    /**
     * @method  primeFactor
     * @description  Defines prime factors of 'n', positive but
     *               restricted integer value, ignores decimals.
     * @usage  <pre>Factor.primeFactor(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (String)  -- returns a string representation of the multiplication of primes of 'n'.
    **/
    public static function primeFactor(n:Number):String {
        var bFlag:Boolean;

        n |= 0;
        if (n==1) return "1";

        var temp:Number = n;
        var delim:String = "*";
        var sFactor:String = "";

        while (1) {
            if (temp%2==0) {
                temp /= 2;
                sFactor += 2+delim;
            }
            else break;
        }

        var num:Number = 3;

        while (1<temp) {
            bFlag = true;
            while (bFlag) {
                if (temp%num==0) {
                    temp /= num;
                    sFactor += num+delim;
                }
                else bFlag = false;
            }
            num += 2;
        }

        return sFactor.substr(0, -1);
    }

      // 17. totient ------------------------------------

    /**
     * @method  totient
     * @description  Defines total of relative primes of 'n'.
     * @usage  <pre>Factor.totient(n);</pre>
     * @param   n   (Number)  -- a positive integer.
     * @return  (Number)  -- returns total of relative primes of 'n'.
    **/
    public static function totient(n:Number):Number {
        var k:Number = 1;
        var j:Number;

        if (n%2==0) j++;
        for (j=3;j<=n;j+=2) if (Factor.isPrime(j)) k++;

        return k;
    }

}// class
}//package

