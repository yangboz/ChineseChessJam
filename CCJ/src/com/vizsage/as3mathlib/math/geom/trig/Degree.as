package com.vizsage.as3mathlib.math.geom.trig {
/**
 * @class       com.vizsage.as3mathlib.math.geom.trig.Degree
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static behaviours of the Degree Class.
 *              <p>
 *		        Provides methods for calculating the main circular trigonometric
 *              functions by passing the angle input in degrees for sin, cos, and
 *              tan, and returning degrees for asin, acos, atan, and atan2.
 * @usage       <pre>Degree.classMethod(n);</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright © 2002, Robert Penner  [www.robertpenner.com]
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
 *       Degree()
 *           1.  sinD(n)
 *           2.  cosD(n)
 *           3.  tanD(n)
 *           4.  asinD(n)
 *           5.  acosD(n)
 *           6.  atanD(n)
 *           7.  atan2D(y, x)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Degree  {
	/**
	 * @property none  -- no class properties.
	**/

    public function Degree() {
        //trace ("Degree Class loaded");
    }

      // 1. sinD ---------------------------------------

    /**
     * @method  sinD
     * @description  Calculates the sine of the passed angle.
     * @usage  <pre>Degree.sinD(n);</pre>
     * @param   n   (Number)  -- a value representing angle in degrees.
     * @return  (Number)  -- returns the sine of the passed angle, a number between -1 and 1 inclusive.
    **/
    public static function sinD(n:Number):Number {
        return Math.sin(n*(Math.PI/180));
    }

      // 2. cosD ---------------------------------------

    /**
     * @method  cosD
     * @description  Calculates the cosine of the passed angle.
     * @usage  <pre>Degree.cosD(n);</pre>
     * @param   n   (Number)  -- a value representing angle in degrees.
     * @return  (Number)  -- returns the cosine of the passed angle, a number between -1 and 1 inclusive.
    **/
    public static function cosD(n:Number):Number {
        return Math.cos(n*(Math.PI/180));
    }

      // 3. tanD ---------------------------------------

    /**
     * @method  tanD
     * @description  Calculates the tangent of the passed angle.
     * @usage  <pre>Degree.tanD(n);</pre>
     * @param   n   (Number)  -- a value representing angle in degrees.
     * @return  (Number)  -- returns the tangent of the passed angle.
    **/
    public static function tanD(n:Number):Number {
        return Math.tan(n*(Math.PI/180));
    }

      // 4. asinD --------------------------------------

    /**
     * @method  asinD
     * @description  Calculates the arcsine of the passed angle.
     * @usage  <pre>Degree.asinD(n);</pre>
     * @param   n   (Number)  -- a value between -1 and 1 inclusive.
     * @return  (Number)  -- returns the arcsine of the passed angle in degrees.
    **/
    public static function asinD(n:Number):Number {
        return Math.asin(n)*(180/Math.PI);
    }

      // 5. acosD --------------------------------------

    /**
     * @method  acosD
     * @description  Calculates the arccosine of the passed angle.
     * @usage  <pre>Degree.acosD(n);</pre>
     * @param   n   (Number)  -- a value between -1 and 1 inclusive.
     * @return  (Number)  -- returns the arccosine of the passed angle in degrees.
    **/
    public static function acosD(n:Number):Number {
        return Math.acos(n)*(180/Math.PI);
    }

      // 6. atanD --------------------------------------

    /**
     * @method  atanD
     * @description  Calculates the arctangent of the passed angle.
     * @usage  <pre>Degree.atanD(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the arctangent of the passed angle, a number between -Math.PI/2 and Math.PI/2 inclusive.
    **/
    public static function atanD(n:Number):Number {
        return Math.atan(n)*(180/Math.PI);
    }

      // 7. atan2D -------------------------------------

    /**
     * @method  atan2D
     * @description  Calculates the arctangent2 of the passed angle.
     * @usage  <pre>Degree.atan2D(y, x);</pre>
     * @param   y   (Number)  -- a value representing y-axis of angle vector.
     * @param   x   (Number)  -- a value representing x-axis of angle vector.
     * @return  (Number)  -- returns the arctangent2 of the passed angle.
    **/
    public static function atan2D(y:Number, x:Number):Number {
        return Math.atan2(y, x)*(180/Math.PI);
    }

}// class
}//package

