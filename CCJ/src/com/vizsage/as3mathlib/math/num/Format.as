package com.vizsage.as3mathlib.math.num {
/**
 * @class       com.vizsage.as3mathlib.math.num.Format
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static behaviours of the Format Class.
 * @usage       <code>Format.classMethod(classProp);</code>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright © 2001, Robert Penner  [www.robertpenner.com]
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
 *       Format()
 *           1.  sign(n)
 *           2.  placesRound(a, b)
 *           3.  randomBetween(a, b)
 *           4.  product(arr)
 *           5.  sum(arr)
 *           6.  fp(n)
 *           7.  maxSort(arr, bList)
 *           8.  minSort(arr, bList)
 *           9.  isEven(n)
 *           10. isOdd(n)
 *           11. dbleEpsilon()
 *           12. round2(num)
 *           13. formatDecimals(num, digits)
 *           14. toScientific(num, sigDigs)
 *           15. numCurrency(input, dig, bEuro, bCurr, curr)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

public class Format  {
	/**
	 * @property none -- no class properties.
	**/

    public function Format() {
        //trace ("Format Class loaded");
    }

      // 1. sign ---------------------------------------

    /**
     * @method  sign
     * @description  Defines the sign of the number.
     * @usage  <pre>Format.sign(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the sign of the number.
    **/
    public static function sign(n:Number):Number {
        return n==0 ? 0 : (n>0 ? 1 : -1);
    }

      // 2. placesRound --------------------------------

    /**
     * @method  placesRound
     * @description  Rounds 'a' to 'b' number of decimal places.
     * @usage  <pre>Format.placesRound(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a positive integer.
     * @return  (Number)  -- returns a number rounded to 'b' decimal places.
    **/
    public static function placesRound(a:Number, b:Number):Number {
        return (Math.round(a*Math.pow(10, b))/Math.pow(10, b));
    }

      // 3. randomBetween ------------------------------

    /**
     * @method  randomBetween
     * @description  Defines a random number between 'a' and 'b'.
     * @usage  <pre>Format.randomBetween(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns a random number between 'a' and 'b'.
    **/
    public static function randomBetween(a:Number, b:Number):Number {
        var greater:Number = Math.max(a, b);
        var smaller:Number = Math.min(a, b);

        return (Math.random()*(greater-smaller)+smaller);
    }

      // 4. product ------------------------------------

    /**
     * @method  product
     * @description  Calculates the product of 'arr' elements.
     * @usage  <pre>Format.product(arr);</pre>
     * @param   arr   (Array)  -- a list of real numbers.
     * @return  (Number)  -- returns the product of 'arr' elements.
    **/
    public static function product(arr:Array):Number {
        var k:Number = 1;
        var h:Number;

        for (h=0;h<arr.length;h++) k *= arr[h];

        return k;
    }

      // 5. sum ----------------------------------------

    /**
     * @method  sum
     * @description  Calculates the sum of 'arr' elements.
     * @usage  <pre>Format.sum(arr);</pre>
     * @param   arr   (Array)  -- a list of real numbers.
     * @return  (Number)  -- returns the sum of 'arr' elements.
    **/
    public static function sum(arr:Array):Number {
        var k:Number = 0;
        var h:Number;

        for (h=0;h<arr.length;h++) k += arr[h];

        return k;
    }

      // 6. fp -----------------------------------------

    /**
     * @method  fp
     * @description  Defines the decimal portion of a floating point number.
     * @usage  <pre>Format.fp(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the decimal portion of a floating point number.
    **/
    public static function fp(n:Number):Number {
        return n-Math.floor(n);
    }

      // 7. maxSort ------------------------------------

    /**
     * @method  maxSort
     * @description  Definess max of 'arr', or max2min order of 'arr' if 'bList'
     *               is passed.
     * @usage  <pre>Format.maxSort(arr, bList);</pre>
     * @param   arr   (Array)  -- a list of real numbers.
     * @param   bList   (Boolean)  -- optional Boolean to define return.
     * @return  (Array)  -- returns max of 'arr', or max2min order of 'arr' if 'bList' is passed.
    **/
    public static function maxSort(arr:Array, bList:Boolean):Array {
        var b:Number, c:Number;

        if (bList) 	return arr.sort(function(b:Number, c:Number):Number{return c-b});
        else 		return arr.sort(function(b:Number, c:Number):Number{return c-b})[0];
    }

      // 8. minSort ------------------------------------

    /**
     * @method  minSort
     * @description  Defines min of 'arr', or min2max order of 'arr' if 'bList'
     *               is passed.
     * @usage  <pre>Format.minSort(arr, bList);</pre>
     * @param   arr   (Array)  -- a list of real numbers.
     * @param   bList   (Boolean)  -- optional Boolean to define return.
     * @return  (Array)  -- returns min of 'arr', or min2max order of 'arr' if 'bList' is passed.
    **/
    public static function minSort(arr:Array, bList:Boolean):Array {
        var b:Number, c:Number;

        if (bList) 	return arr.sort(function(b:Number, c:Number):Number{return b-c});
        else 		return arr.sort(function(b:Number, c:Number):Number{return b-c})[0];
    }

      // 9. isEven -------------------------------------

    /**
     * @method  isEven
     * @description  Boolean for 'isEven' integer condition.
     * @usage  <pre>Format.isEven(n);</pre>
     * @param   n   (Number)  -- a positive or negative integer.
     * @return  (Boolean)
    **/
    public static function isEven(n:Number):Boolean {
        return (n%2==0);
    }

      // 10. isOdd -------------------------------------

    /**
     * @method  isOdd
     * @description  Boolean for 'isOdd' integer condition.
     * @usage  <pre>Format.isOdd(n);</pre>
     * @param   n   (Number)  -- a positive or negative integer.
     * @return  (Boolean)
    **/
    public static function isOdd(n:Number):Boolean {
        return (n%2) ? true : false;
    }

      // 11. dbleEpsilon -------------------------------

    /**
     * @method  dbleEpsilon
     * @description  Defines the smallest number such that 1 + mchEps > 1.
     * @usage  <pre>Format.dbleEpsilon();</pre>
     * @return  (Number)  -- returns machine precision.
    **/
    public static function dbleEpsilon():Number {
        var temp1:Number = 1.0;
        var temp2:Number, mchEps:Number;

        do {
            mchEps = temp1;
            temp1 /= 2;
            temp2 = 1.0+temp1;
        }
        while (temp2>1.0);

        return mchEps;
    }

      // 12. round2 ------------------------------------

    /**
     * @method  round2
     * @description  Like Math.round, but rounds negative numbers down (-5.5 -> -6).
     *               Math.round() actually rounds negative numbers up (-5.5 -> -5).
     * @usage  <pre>Format.round2(num);</pre>
     * @param   num   (Number)  -- a real number.
     * @return  (Number)  -- returns correctly rounded positive or negative numbers.
    **/
    public static function round2(num:Number):Number {
        if (num<0) {
            var isNegative:Boolean = true;

            num *= -1;
        }

        return isNegative ? -Math.round(num) : Math.round(num);
    } // Robert Penner - May 2001

      // 13. formatDecimals ----------------------------

    /**
     * @method  formatDecimals
     * @description  Formats a number into specified number of decimal places and 0 pad right.
     * @usage  <pre>Format.formatDecimals(num, digits);</pre>
     * @param   num   (Number)  -- a real number.
     * @param   digits   (Number)  -- a positive integer.
     * @return  (String)  -- returns a string representation of a number into specified number of decimal places.
    **/
    public static function formatDecimals(num:Number, digits:Number):String {
        //if no decimal places needed, we're done
        if (digits<=0) return String(Math.round(num));

        //round the number to specified decimal places
        //e.g. 12.3456 to 3 digits (12.346) -> mult. by 1000, round, div. by 1000
        var tenToPower:Number = Math.pow(10, digits);
        var cropped:String = String(Math.round(num*tenToPower)/tenToPower);

        //add decimal point if missing
        if (cropped.indexOf(".")==-1) {
            cropped += ".0";  //e.g. 5 -> 5.0 (at least one zero is needed)
        }

        //finally, force correct number of zeroes; add some if necessary
        var halves:Array = cropped.split("."); //grab numbers to the right of the decimal
        //compare digits in right half of string to digits wanted
        var zerosNeeded:Number = digits-halves[1].length; //number of zeros to add
        var j:Number;

        for (j=1;j<=zerosNeeded;j++) cropped += "0";

        return cropped;
    } // Robert Penner - May 2001

      // 14. toScientific ------------------------------

    /**
     * @method  toScientific
     * @description  Convert any number to scientific notation with specified
     *               significant digits. (e.g.) .012345 -> 1.2345e-2 -- but 6.34e0
     *               is displayed "6.34" -- requires 'formatDecimals' method.
     * @usage  <pre>Format.toScientific(num, sigDigs);</pre>
     * @param   num   (Number)  -- a real number.
     * @param   sigDigs   (Number)  -- a positive integer.
     * @return  (String)  -- returns a string representation of scientific notation with specified significant digits.
    **/
    public static function toScientific(num:Number, sigDigs:Number):String {
        //find exponent using logarithm
        //e.g. log10(150) = 2.18 -- round down to 2 using floor()
        var exponent:Number = Math.floor(Math.log(Math.abs(num))/Math.LN10);

        if (num==0) exponent = 0; //handle glitch if the number is zero

        //find mantissa (e.g. "3.47" is mantissa of 3470; need to divide by 1000)
        var tenToPower:Number = Math.pow(10, exponent);
        var mantissa:Number = num/tenToPower;

        //force significant digits in mantissa
        //e.g. 3 sig digs: 5 -> 5.00, 7.1 -> 7.10, 4.2791 -> 4.28
        var mant:String = Format.formatDecimals(mantissa, sigDigs-1); //use custom f\\unction

        // it is possible that by rounding in the step above, we've increased
        // the number to XX.XXX, e.g. 9.999999 went to 10.00
        // so we need to check for this condition
        var mantNum:Number = Number(mant);

        if (mantNum>=10 || mantNum<=-10) {
            mantNum /= 10;
            mant = Format.formatDecimals(mantNum, sigDigs-1);
            exponent++;
        }

        var output:String = mant;

        //if exponent is zero, don't include e
        if (exponent!=0) output += "e"+String(exponent);

        return (output);
    } // Robert Penner - May 2001

      // 15. numCurrency -------------------------------


    // 15. numCurrency
    /**
     * @method  numCurrency
     * @description  Unfinished method that introduces European formatting. I
     *               have included 'numCurrency2' that doesn't handle European
     *               formatting -- both versions are causing errors presently.
     * @usage  <pre>Format.numCurrency(input, dig, bEuro, bCurr, sCurr);</pre>
     * @param   input   (String)  -- allows for direct textfield input.
     * @param   dig   (Number)  -- a positive integer.
     * @param   bEuro   (Boolean)  -- if true, reverses delimit_arr.
     * @param   bCurr   (Boolean)  -- if false, returns a comma-delineated number.
     * @param   sCurr   (String)  -- country currency symbol.
     * @return  (String)  -- returns a string representation of the formatted currency.
    **/
    public static function numCurrency(input:String, dig:Number, bEuro:Boolean, bCurr:Boolean, sCurr:String):String {
	    var delimit_arr:Array = [".", ", "];
	    if (bEuro) delimit_arr.reverse();
	    var temp_arr:Array = input.split(delimit_arr[0]);
	    var num:String = temp_arr[0];
	    if (num.charAt(0)=="-") {
	        var bNeg:Boolean = true;
	        num = num.slice(1);
	    }
	    var mod:Number = num.length%3;
	    var treble:String = num.slice(0, mod);
	    var j:Number;
	    var output:String;
		var round:String;
		var float:Number;
		
	    for (j=mod;j<=num.length-3;j+=3) {
	        if (j!=0) treble += delimit_arr[1];
	        treble += num.slice(j, j+3);
	    }
	    if (bNeg) treble = "-"+treble;
	    if (temp_arr[1]) {
	        var frac:String = temp_arr[1];
	        if (bCurr) {
	            if (frac.length==1) {
	                frac += "0";
	            }
	            else if (frac.length>2) {
	                round = frac.charAt(2);
	                frac = frac.slice(0, 2);
	                float = parseInt(round);
	                if (float>=5) {
	                    frac = frac.charAt(0)+(parseInt(frac.charAt(1))+1);
	                }
	            }
	            output = sCurr+" "+treble+delimit_arr[0]+frac;
	        }
	        else {
	            if (frac.length>=dig) {
	                round = frac.charAt(dig);
	                frac  = frac.slice(0, dig);
				    float = parseInt(round);
				    if (float>=5) frac = frac.valueOf() + 1;
	            }
	            output = treble+delimit_arr[0]+frac;
	        }
	    }
	    else {
	        if (bCurr) output = sCurr+" "+treble+delimit_arr[0]+"00";
	        else output = treble;
	    }

		return output;
    }


      // 15a. numCurrency2 -----------------------------

	/**
	 * @method  numCurrency2
	 * @description  Working version for currency display that doesn't handle
	 *               European formatting.
	 * @usage  <pre>Format.numCurrency(input, dig, curr);</pre>
	 * @param   input   (String)  -- allows for direct textfield input.
	 * @param   dig   (Number)  -- a positive integer.
	 * @param   curr   (Array)  -- ["XYZ", "Country Name", exchangeRateNum, decSeparatorNum(0-3), trebSeparatorNum(0-3)]
	 * @return  (String)  -- returns a string representation of the formatted currency.
	**/
	public static function numCurrency2(input:String, dig:Number, curr:Array):String {
	    var delimit_arr:Array = [", ", ".", " ", "'"];
	    var temp:Array;

	    if (! isNaN(dig)) {
	        temp = delimit_arr.splice(curr[3], 1);
	        delimit_arr.unshift(temp);
	    }
	    else if (curr) {
	        temp = delimit_arr.splice(curr[4], 1);
	        delimit_arr.unshift(temp);
	    }

	    var temp_arr:Array = input.split(delimit_arr[0]);
	    var num:String = temp_arr[0];

	    if (num.charAt(0)=="-") {
	        var bNeg:Boolean = true;
	        num = num.slice(1);
	    }

	    var mod:Number = num.length%3;
	    var treble:String = num.slice(0, mod);
	    var j:Number;
	    var output:String;
		var round:String;
		var float:Number;

	    for (j=mod;j<=num.length-3;j+=3) {
	        if (j!=0) treble += delimit_arr[1];
	        treble += num.slice(j, j+3);
	    }
	    if (bNeg) treble = "-"+treble;
	    if (temp_arr[1]) {
	        var frac:String = temp_arr[1];
	        if (curr) {
	            if (frac.length==1) {
	                frac += "0";
	            }
	            else if (frac.length>2) {
	                round 	= frac.charAt(2);
	                frac 	= frac.slice(0, 2);
	                float 	= parseInt(round);
	                if (float>=5) frac = frac.charAt(0)+(parseInt(frac.charAt(1))+1);
	            }
	            output = curr[0]+" "+treble+delimit_arr[0]+frac;
	        }
	        else {
	            if (frac.length>=dig) {
	                round 	= frac.charAt(dig);
	                frac 	= frac.slice(0, dig);
				    float 	= parseInt(round);
				    if (float>=5) frac = frac.valueOf() + 1;
	            }
	            output = treble+delimit_arr[0]+frac;
	        }
	    }
	    else {
	        if (curr) output = curr[0]+" "+treble+delimit_arr[0]+"00";
	        else output = treble;
	    }

		return output;
    }

}// class
}//package

