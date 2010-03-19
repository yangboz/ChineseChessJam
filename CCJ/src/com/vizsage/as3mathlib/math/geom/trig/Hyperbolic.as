package com.vizsage.as3mathlib.math.geom.trig {
/**
 * @class       com.vizsage.as3mathlib.math.geom.trig.Hyperbolic
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static behaviours of the Hyperbolic Class.
 *              <p>
 *		        Provides methods for calculating hyperbolic trigonometric
 *              functions.
 *		        <p>
 * @usage       <pre>Hyperbolic.classMethod(hypParam)</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright © 2002, Brandon Williams [brandon@plotdev.com]
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
 *       Hyperbolic()
 *           1. sinh(n)
 *           2. asinh(n)
 *           3. cosh(n)
 *           4. acosh(n)
 *           5. tanh(n)
 *           6. atanh(n)
 *           7. sech(n)
 *           8. asech(n)
 *           9. csch(n)
 *           10. acsch(n)
 *           11. coth(n)
 *           12. acoth(n)
 *           13. versh(n)
 *           14. coversh(n)
 *           15. haversh(n)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Hyperbolic  {
	/**
	 * @property none  -- no class properties.
	**/

    public function Hyperbolic() {
        //trace ("Hyperbolic  Class loaded");
    }

      // 1. sinh ---------------------------------------

    /**
     * @method  sinh
     * @description  Calculates the hyperbolic sine = (Eª-E-ª)/2 of the passed angle.
     * @usage  <pre>Hyperbolic.sinh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic sine.
    **/
    public static function sinh(n:Number):Number {
        return (Math.exp(n)-Math.exp(-n))/2;
    }

      // 2. asinh --------------------------------------

    /**
     * @method  asinh
     * @description  Calculates the hyperbolic arcsine = ln(n+sqrt(n²+1) of the passed angle.
     * @usage  <pre>Hyperbolic.sinh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic arcsine.
    **/
    public static function asinh(n:Number):Number {
        return Math.log(n+Math.sqrt(n*n+1));
    }

      // 3. cosh ---------------------------------------

    /**
     * @method  cosh
     * @description  Calculates the hyperbolic cosine = (Eª+E-ª)/2 of the passed angle.
     * @usage  <pre>Hyperbolic.sinh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic cosine.
    **/
    public static function cosh(n:Number):Number {
        return (Math.exp(n)+Math.exp(-n))/2;
    }

      // 4. acosh --------------------------------------

    /**
     * @method  acosh
     * @description  Calculates the hyperbolic arccosine = ln(n+sqrt(n²-1) of the passed angle.
     * @usage  <pre>Hyperbolic.acosh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic arccosine.
    **/
    public static function acosh(n:Number):Number {
        return Math.log(n+Math.sqrt(n*n-1));
    }

      // 5. tanh ---------------------------------------

    /**
     * @method  tanh
     * @description  Calculates the hyperbolic tangent = sinh(n)/cosh(n) = (Eª-E-ª)/(Eª+E-ª) of the passed angle.
     * @usage  <pre>Hyperbolic.tanh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic tangent.
    **/
    public static function tanh(n:Number):Number {
        var t1:Number = Math.exp(n);
        var t2:Number = Math.exp(-n);

        return (t1-t2)/(t1+t2);
    }

      // 6. atanh --------------------------------------

    /**
     * @method  atanh
     * @description  Calculates the hyperbolic arctangent = ln((1+n)/(1-n))/2 of the passed angle.
     * @usage  <pre>Hyperbolic.atanh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic arctangent.
    **/
    public static function atanh(n:Number):Number {
        return Math.log((1+n)/(1-n))/2;
    }

      // 7. sech ---------------------------------------

    /**
     * @method  sech
     * @description  Calculates the hyperbolic secant = 1/cosh(n) = 1/(Eª+E-ª)/2 of the passed angle.
     * @usage  <pre>Hyperbolic.sech(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic secant.
    **/
    public static function sech(n:Number):Number {
        return (1/Hyperbolic.cosh(n));
    }

      // 8. asech --------------------------------------

    /**
     * @method  asech
     * @description  Calculates the hyperbolic arcsecant = acosh(1/n) = ln((1/n)+sqrt((1/n)²-1) of the passed angle.
     * @usage  <pre>Hyperbolic.asech(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic arcsecant.
    **/
    public static function asech(n:Number):Number {
        return (Hyperbolic.acosh(1/n));
    }

      // 9. csch ---------------------------------------

    /**
     * @method  csch
     * @description  Calculates the hyperbolic cosecant = 1/sinh(n) = 1/((Eª-E-ª)/2) of the passed angle.
     * @usage  <pre>Hyperbolic.csch(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic cosecant.
    **/
    public static function csch(n:Number):Number {
        return (1/Hyperbolic.sinh(n));
    }

      // 10. acsch -------------------------------------

    /**
     * @method  acsch
     * @description  Calculates the hyperbolic arccosecant = asinh(1/n) = ln((1/n)+sqrt((1/n)²+1) of the passed angle.
     * @usage  <pre>Hyperbolic.acsch(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic arccosecant.
    **/
    public static function acsch(n:Number):Number {
        return (Hyperbolic.asinh(1/n));
    }

      // 11. coth --------------------------------------

    /**
     * @method  coth
     * @description  Calculates the hyperbolic cotangent = 1/tanh(n) = 1/(sinh(n)/cosh(n)) = 1/((Eª-E-ª)/(Eª+E-ª)) of the passed angle.
     * @usage  <pre>Hyperbolic.coth(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic cotangent.
    **/
    public static function coth(n:Number):Number {
        return (1/Hyperbolic.tanh(n));
    }

      // 12. acoth -------------------------------------

    /**
     * @method  acoth
     * @description  Calculates the hyperbolic arccotangent = atanh(1/n) = ln((1+(1/n))/(1-(1/n)))/2 of the passed angle.
     * @usage  <pre>Hyperbolic.acoth(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic arccotangent.
    **/
    public static function acoth(n:Number):Number {
        return (Hyperbolic.atanh(1/n));
    }

      // 13. versh -------------------------------------

    /**
     * @method  versh
     * @description  Calculates the hyperbolic versine = 1-0.5*(exp(n)+exp(-n)) of the passed angle.
     * @usage  <pre>Hyperbolic.versh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic versine.
    **/
    public static function versh(n:Number):Number {
        return 1-0.5*(Math.exp(n)+Math.exp(-n));
    }

      // 14. coversh -----------------------------------

    /**
     * @method  coversh
     * @description  Calculates the hyperbolic coversine = 1-0.5*(exp(n)-exp(-n)) of the passed angle.
     * @usage  <pre>Hyperbolic.coversh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic coversine.
    **/
    public static function coversh(n:Number):Number {
        return 1-0.5*(Math.exp(n)-Math.exp(-n));
    }

      // 15. haversh -----------------------------------

    /**
     * @method  haversh
     * @description  Calculates the hyperbolic haversine = 0.5*(1-0.5*(exp(n)+exp(-n))) of the passed angle.
     * @usage  <pre>Hyperbolic.haversh(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the hyperbolic haversine.
    **/
    public static function haversh(n:Number):Number {
        return 0.5*(1-0.5*(Math.exp(n)+Math.exp(-n)));
    }

}// class
}//package

