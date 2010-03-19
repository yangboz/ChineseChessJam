package com.vizsage.as3mathlib.math.geom.trig {
/**
 * @class       com.vizsage.as3mathlib.math.geom.trig.Circular
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static behaviours of the Circular Class.
 *              <p>
 *		        Provides methods for the circular trigonometric functions that are
 *              not included in the core Math object.
 * @usage       <pre>Circular.circMethod(circParam);</pre>
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
 *       Circular()
 *           1.  sec(n)
 *           2.  asec(n)
 *           3.  csc(n)
 *           4.  acsc(n)
 *           5.  cot(n)
 *           6.  acot(n)
 *           7.  vers(n)
 *           8.  covers(n)
 *           9.  havers(n)
 *           10. cohavers(n)
 *           11. exsec(n)
 *           12. coexsec(n)
 *           13. avers(n)
 *           14. acovers(n)
 *           15. ahavers(n)
 *           16. aexsec(n)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Circular  {
	/**
	 * @property none  -- no class properties.
	**/

    public function Circular() {
        //trace ("Circular Class loaded");
    }

      // 1. sec ----------------------------------------

    /**
     * @method  sec
     * @description  Calculates the secant of the passed angle.
     * @usage  <pre>Circular.sec(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the secant of the passed angle.
    **/
    public static function sec(n:Number):Number {
        return (1/Math.cos(n));
    }

      // 2. arcsecant ----------------------------------

    /**
     * @method  asec
     * @description  Calculates the arcsecant of the passed angle.
     * @usage  <pre>Circular.asec(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the arcsecant of the passed angle.
    **/
    public static function asec(n:Number):Number {
        return (Math.acos(1/n));
    }

      // 3. cosecant -----------------------------------

    /**
     * @method  csc
     * @description  Calculates the cosecant of the passed angle.
     * @usage  <pre>Circular.csc(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the cosecant of the passed angle.
    **/
    public static function csc(n:Number):Number {
        return (1/Math.sin(n));
    }

      // 4. arccosecant --------------------------------

    /**
     * @method  acsc
     * @description  Calculates the arccosecant of the passed angle.
     * @usage  <pre>Circular.acsc(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the arccosecant of the passed angle.
    **/
    public static function acsc(n:Number):Number {
        return (Math.asin(1/n));
    }

      // 5. cotangent ----------------------------------

    /**
     * @method  cot
     * @description  Calculates the cotangent of the passed angle.
     * @usage  <pre>Circular.cot(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the cotangent of the passed angle.
    **/
    public static function cot(n:Number):Number {
        return (1/Math.tan(n));
    }

      // 6. arccotangent -------------------------------

    /**
     * @method  acot
     * @description  Calculates the arccotangent of the passed angle.
     * @usage  <pre>Circular.acot(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the arccotangent of the passed angle.
    **/
    public static function acot(n:Number):Number {
        return (Math.atan(1/n));
    }

      // 7. versine ------------------------------------

    /**
     * @method  vers
     * @description  Calculates the versine of the passed angle.
     * @usage  <pre>Circular.vers(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the versine of the passed angle.
    **/
    public static function vers(n:Number):Number {
        return 1-Math.cos(n);
    }

      // 8. coversine ----------------------------------

    /**
     * @method  covers
     * @description  Calculates the coversine of the passed angle.
     * @usage  <pre>Circular.covers(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the coversine of the passed angle.
    **/
    public static function covers(n:Number):Number {
        return 1-Math.sin(n);
    }

      // 9. haversine ----------------------------------

    /**
     * @method  havers
     * @description  Calculates the haversine of the passed angle.
     * @usage  <pre>Circular.havers(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the haversine of the passed angle.
    **/
    public static function havers(n:Number):Number {
        return 0.5*(1-Math.cos(n));
    }

      // 10. cohaversine -------------------------------

    /**
     * @method  cohavers
     * @description  Calculates the cohaversine of the passed angle.
     * @usage  <pre>Circular.cohavers(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the cohaversine of the passed angle.
    **/
    public static function cohavers(n:Number):Number {
        return 0.5*(1-Math.sin(n));
    }

      // 11. exsecant ----------------------------------

    /**
     * @method  exsec
     * @description  Calculates the exsecant of the passed angle.
     * @usage  <pre>Circular.exsec(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the exsecant of the passed angle.
    **/
    public static function exsec(n:Number):Number {
        return 1/Math.cos(n)-1;
    }

      // 12. coexsecant --------------------------------

    /**
     * @method  coexsec
     * @description  Calculates the coexsecant of the passed angle.
     * @usage  <pre>Circular.coexsec(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the coexsecant of the passed angle.
    **/
    public static function coexsec(n:Number):Number {
        return 1/Math.sin(n)-1;
    }

      // 13. arcversine --------------------------------

    /**
     * @method  avers
     * @description  Calculates the arcversine of the passed angle.
     * @usage  <pre>Circular.avers(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the arcversine of the passed angle.
    **/
    public static function avers(n:Number):Number {
        return Math.atan(Math.sqrt(2*n-n*n)/(1-n));
    }

      // 14. arccoversine ------------------------------

    /**
     * @method  acovers
     * @description  Calculates the arccoversine of the passed angle.
     * @usage  <pre>Circular.acovers(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the arccoversine of the passed angle.
    **/
    public static function acovers(n:Number):Number {
        return Math.atan((1-n)/Math.sqrt(2*n-n*n));
    }

      // 15. archaversine ------------------------------

    /**
     * @method  ahavers
     * @description  Calculates the archaversine of the passed angle.
     * @usage  <pre>Circular.ahavers(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the archaversine of the passed angle.
    **/
    public static function ahavers(n:Number):Number {
        return Math.atan(2*Math.sqrt(n-n*n)/(1-2*n));
    }

      // 16. arcexsecant -------------------------------

    /**
     * @method  aexsec
     * @description  Calculates the arcexsecant of the passed angle.
     * @usage  <pre>Circular.aexsec(n);</pre>
     * @param   n   (Number)  -- a value representing angle in radians.
     * @return  (Number)  -- returns the arcexsecant of the passed angle.
    **/
    public static function aexsec(n:Number):Number {
        return Math.atan(Math.sqrt(n*n+2*n));
    }

}// class
}//package

