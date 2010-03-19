package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.Noise
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Noise Class.
 *              <p>
 *              Possible input values are (.8296815753293, 11). Don't go high with
 *              the second argument; it's exponential. Creation of a Noise object
 *              can be very slow; evaluation of one isn't all that speedy either.
 *              This class includes duplication of method strategy to support
 *              existing applications.
 * @usage       <pre>var inst:Noise = new Noise(seedNum, power);</pre>
 * @param       seedNum (Number)  -- a real number between 0 and 1.
 * @param       power (Number)  -- creates a multiple of 2.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 * -----------------------------------------------
 * AS2 revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright � 2002, Andrew Phelps  [Rochester Institute of Technology]
 * JS  original copyright � 2003, John Haggerty  [http://www.slimeland.com/]
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
 *       Noise(seedNum, power)
 *           1.  init(seedNum, arraySizePower)
 *           2.  rand(seedNum) - static
 *           3.  interpolate(g, h, amnt) - static
 *           4.  cubicWave(x) - static
 *           5.  getVal(gradient, x, y, z) - static
 *           6.  evaluate(pos)
 *           7.  noise1D(x) - static
 *           8.  noise2D(x, y) - static
 *           9.  noise3D(x, y, z) - static
 *           10. smoothNoise2D(x, y) - static
 *           11. interpolate2(g, h, x) - static
 *           12. interpolatedNoise2D(x, y) - static
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: possible values are (.8296815753293, 11). Don't go high with the second argument; it's exponential.
 * Warning: creation of a Noise object can be very slow; evaluation of one isn't all that speedy either.
 * This class includes duplication of method strategy.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;

public class Noise  {
	/**
	 * @property $seed (Number)  -- a calculated random number between 0 and 1.
	 * @property $arraySize (Number)  -- a power of 2 based on passed 'power' argument.
	 * @property $gradients (Array)  -- an array to hold gradient values.
	 * @property $permutation (Array)  -- an array to hold permutation values.
	 * @property $BIGNUM (Number)  -- static -- Math.pow(2, 11)-1.
	**/
    public var $seed:Number;
	public var $arraySize:Number;
	public var $gradients:Array = [];
	public var $permutation:Array = [];
	public static var $BIGNUM:Number = 48271; //Math.pow(2, 11)-1

    // constructor
    public function Noise(seedNum:Number, power:Number) {
        //trace ("Noise Class loaded");
        this.init(seedNum, power);
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Initializes this instance's properties.
     * @usage  <pre>inst.init(seedNum, power);</pre>
     * @param   seedNum   (Number)  -- a real number between 0 and 1.
     * @param   power   (Number)  -- a real number for exponentiation.
     * @return  (void)
    **/
    private function init(seedNum:Number, power:Number):void {
        var val1:Number, val2:Number, val3:Number;
        var len:Number, j:Number, temp:Number, switchWith:Number;

	    $arraySize = Math.pow(2, power);

	    for (j=0;j<$arraySize;j++) {
		    val1 = ($seed=Noise.rand(seedNum))*2-1;
		    val2 = ($seed=Noise.rand(seedNum))*2-1;
		    val3 = ($seed=Noise.rand(seedNum))*2-1;
		    $gradients.push(new Vector(val1, val2, val3));
		    len = $gradients[j]._lenSq;
		    if (len>1 || len==0) j--; // skip this one
		    else $gradients[j].normalize($gradients[j]);
		    $permutation.push(j);
	    }

	    // find a permutation
	    for (j=0;j<$arraySize;j++) {
		    $seed = Noise.rand(seedNum);
		    switchWith = j+Math.floor(($arraySize-j)*$seed);
		    temp = $permutation[j];
		    $permutation[j] = $permutation[switchWith];
		    $permutation[switchWith] = temp;
	    }
	    // duplicate arrays onto selves (avoids operations later)
	    for (j=$arraySize;j<$arraySize*2;j++) {
		    $gradients[j] = $gradients[j-$arraySize];
		    $permutation[j] = $permutation[j-$arraySize];
	    }
    }

      // 2. rand ---------------------------------------

    /**
     * @method  rand
     * @description  Random number generator.
     * @usage  <pre>Noise.rand(seedNum);</pre>
     * @param   seedNum   (Number)  -- a real number between 0 and 1.
     * @return  (Number)  -- returns decimal portion of base calculation.
    **/
    public static function rand(seedNum:Number):Number {
	    var base:Number = Noise.$BIGNUM*seedNum;

	    return base-Math.floor(base);
    }

      // 3. interpolate --------------------------------

    /**
     * @method  interpolate
     * @description  Interpolates input by adding to g the result of multiplying
     *               amnt by the difference between h and g.
     * @usage  <pre>Noise.interpolate(g, h, amnt);</pre>
     * @param   g   (Number)  -- a real number.
     * @param   h   (Number)  -- a real number.
     * @param   amnt   (Number)  -- a real number.
     * @return  (Number)  -- returns an interpolated number.
    **/
    public static function interpolate(g:Number, h:Number, amnt:Number):Number {
	    return g+amnt*(h-g);
    }

      // 4. cubicWave ----------------------------------

    /**
     * @method  cubicWave
     * @description  Defines a 'cubic wave' for further use in 'interpolation'.
     * @usage  <pre>Noise.cubicWave(x);</pre>
     * @param   x   (Number)  -- a real number.
     * @return  (Number)  -- returns a real number.
    **/
    public static function cubicWave(x:Number):Number {
	    return x*x*(3-2*x);
    }

      // 5. getVal -------------------------------------

    /**
     * @method  getVal
     * @description  Calculates unit box corner vector multiplication.
     * @usage  <pre>Noise.getVal(gradient, x, y, z);</pre>
     * @param   gradient   (Vector)  -- a direction Vector object.
     * @param   x   (Number)  -- a real number.
     * @param   y   (Number)  -- a real number.
     * @param   z   (Number)  -- a real number.
     * @return  (Number)  -- returns the result of vector multiplication.
    **/
    public static function getVal(gradient:Vector, x:Number, y:Number, z:Number):Number {
	    return gradient.x*x+gradient.y*y+gradient.z*z;
    }

      // 6. evaluate -----------------------------------

    /**
     * @method  evaluate
     * @description  Defines unit box, interpolates each corner, then interpolates
     *               those results.
     * @usage  <pre>inst.evaluate(pos);</pre>
     * @param   pos   (Vector)  -- a direction Vector object.
     * @return  (Number)  -- returns the interpolated results.
    **/
    public function evaluate(pos:Vector):Number {
        var x1:Number, y1:Number, z1:Number;
	    var x2:Number, y2:Number, z2:Number;
	    var sx:Number, sy:Number, sz:Number;
	    var tx:Number, ty:Number, tz:Number;
	    var ix:Number, iy:Number, iz:Number;
	    var bz1:Number, bz2:Number;
	    var by1z1:Number, by2z1:Number, by1z2:Number, by2z2:Number;
	    var a:Number, b:Number, c:Number, d:Number, e:Number, f:Number;
	    var bitMask:Number = $arraySize-1;

	    // get integral x, y, z values of the corners of this unit box; also get distances from the sides of the box
	    x1 = Math.floor(pos.x);   sx = pos.x-x1;
	    y1 = Math.floor(pos.y);   sy = pos.y-y1;
	    z1 = Math.floor(pos.z);   sz = pos.z-z1;
	    x2 = x1+1;                tx = sx-1;
	    y2 = y1+1;                ty = sy-1;
	    z2 = z1+1;                tz = sz-1;

	    // values used for cubic interpolation
	    ix = Noise.cubicWave(sx);
	    iy = Noise.cubicWave(sy);
	    iz = Noise.cubicWave(sz);

	    // binary ands: performs a modulo operation with $arraySize since $arraySize is 2^something.
	    x1 = x1&bitMask;
	    y1 = y1&bitMask;
	    z1 = z1&bitMask;
	    x2 = x2&bitMask;
	    y2 = y2&bitMask;
	    z2 = z2&bitMask;

	    // get a random value between 0 and $arraySize*2 pertaining to this point in space
	    bz1 = $permutation[z1];
	    bz2 = $permutation[z2];

	    by1z1 = $permutation[y1+bz1];
	    by2z1 = $permutation[y2+bz1];
	    by1z2 = $permutation[y1+bz2];
	    by2z2 = $permutation[y2+bz2];

	    // calculate value from each corner of the surrounding unit box and interpolate
	    a = Noise.getVal($gradients[x1+by1z1], sx, sy, sz);
	    b = Noise.getVal($gradients[x2+by1z1], tx, sy, sz);
	    c = Noise.interpolate(a, b, ix);

	    a = Noise.getVal($gradients[x1+by2z1], sx, ty, sz);
	    b = Noise.getVal($gradients[x2+by2z1], tx, ty, sz);
	    d = Noise.interpolate(a, b, ix);

	    e = Noise.interpolate(c, d, iy);

	    a = Noise.getVal($gradients[x1+by1z2], sx, sy, tz);
	    b = Noise.getVal($gradients[x2+by1z2], tx, sy, tz);
	    c = Noise.interpolate(a, b, ix);

	    a = Noise.getVal($gradients[x1+by2z2], sx, ty, tz);
	    b = Noise.getVal($gradients[x2+by2z2], tx, ty, tz);
	    d = Noise.interpolate(a, b, ix);

	    f = Noise.interpolate(c, d, iy);

	    return (Noise.interpolate(e, f, iz)+1)/2; // (...+1)/2 since we want a number from 0 to 1, by default it should be -1 to 1
    }

      // Alternative strategy (7 - 12)

      // 7. noise1D ------------------------------------

    /**
     * @method  noise1D
     * @description  Creates noise using one passed argument, prime numbers, and
     *               bitwise XOR operations.
     * @usage  <pre>Noise.noise1D(x);</pre>
     * @param   x   (Number)  -- a real number.
     * @return  (Number)  -- returns the resulting noise value.
    **/
    public static function noise1D(x:Number):Number {
        x = (x<<13)^x;

        return (1.000-((x*(x*x*15731+789221)+1376312589)&0x7FFFFFFF)/1073741824.0);
    }

      // 8. noise2D ------------------------------------

    /**
     * @method  noise2D
     * @description  Creates noise using two passed arguments, prime numbers, and
     *               bitwise XOR operations.
     * @usage  <pre>Noise.noise2D(x, y);</pre>
     * @param   x   (Number)  -- a real number.
     * @param   y   (Number)  -- a real number.
     * @return  (Number)  -- returns the resulting noise value.
    **/
    public static function noise2D(x:Number, y:Number):Number {
        var n:Number;

        n = x+y*17;
        n = (n<<13)^n;

        return (1.000-((n*(n*n*15731+789221)+1376312589)&0x7FFFFFFF)/1073741824.0);
    }

      // 9. noise3D ------------------------------------

    /**
     * @method  noise3D
     * @description  Creates noise using three passed arguments, prime numbers, and
     *               bitwise XOR operations.
     * @usage  <pre>Noise.noise3D(x, y, z);</pre>
     * @param   x   (Number)  -- a real number.
     * @param   y   (Number)  -- a real number.
     * @param   z   (Number)  -- a real number.
     * @return  (Number)  -- returns the resulting noise value.
    **/
    public static function noise3D(x:Number, y:Number, z:Number):Number {
        var n:Number;

        n = Math.floor(x+y*57+z*131);
        n = (n<<13)^n;

        return (1.000-((n*(n*n*15731+789221)+1376312589)&0x7FFFFFFF)*0.000000000931322574615478515625);
    }

      // 10. smoothNoise2D -----------------------------

    /**
     * @method  smoothNoise2D
     * @description  Calculates layered noise for the unit box, called from 'interpolatedNoise2D'.
     * @usage  <pre>Noise.smoothNoise2D(x, y);</pre>
     * @param   x   (Number)  -- a real number.
     * @param   y   (Number)  -- a real number.
     * @return  (Number)  -- returns addition result for method operations.
    **/
    public static function smoothNoise2D(x:Number, y:Number):Number {
	    var corners:Number, sides:Number, center:Number;
        var xMinus1:Number = x-1;
        var yMinus1:Number = y-1;
        var xPlus1:Number = x+1;
        var yPlus1:Number = y+1;
        var maxH:Number = 0;
        var maxV:Number = 0;

        // uncomment for non-wrapped clamp
        corners = (Noise.noise2D(xMinus1, yMinus1)+Noise.noise2D(x+1, yMinus1)+Noise.noise2D(xMinus1, yPlus1)+Noise.noise2D(xPlus1, yPlus1))/16;
        sides = (Noise.noise2D(xMinus1, y)+Noise.noise2D(xPlus1, y)+Noise.noise2D(x, yMinus1)+Noise.noise2D(x, yPlus1))/8;
        center = Noise.noise2D(x, y)/4;

        return corners+sides+center;
        /*
        // uncomment for wrapped clamp
        xMinus1 = x-1;
        if (xMinus1<0) x = maxH;
        yMinus1 = y-1;
        if (yMinus1<0) y = maxV;
        xPlus1 = x+1;
        if (xPlus1>maxH) xPlus1 = 0;
        yPlus1 = y+1;
        if (yPlus1>maxV) yPlus1 = 0;

        corners = (Noise.noise2D(xMinus1, yMinus1)+Noise.noise2D(xPlus1, yMinus1)+Noise.noise2D(xMinus1, yPlus1)+Noise.noise2D(xPlus1, yPlus1))/16;
        sides = (Noise.noise2D(xMinus1, y)+Noise.noise2D(xPlus1, y)+Noise.noise2D(x, yMinus1)+Noise.noise2D(x, yPlus1))/8;
        center = Noise.noise2D(x, y)/4;

        return corners+sides+center;
        */
    }

      // 11. interpolate2 ------------------------------

    /**
     * @method  interpolate2
     * @description  Interpolates input by adding to a percentage of g the result
     *               of multiplying h and f.
     * @usage  <pre>Noise.interpolate2(g, h, x);</pre>
     * @param   g   (Number)  -- a real number.
     * @param   h   (Number)  -- a real number.
     * @param   x   (Number)  -- a real number.
     * @return  (Number)  -- returns the interpolated result.
    **/
    public static function interpolate2(g:Number, h:Number, x:Number):Number {
        var ft:Number = x*Math.PI;
        var f:Number = (1-Math.cos(ft))*.5;

        return g*(1-f)+h*f;
    }

      // 12. interpolatedNoise2D -----------------------

    /**
     * @method  interpolatedNoise2D
     * @description  Final interpolation of the results accumulated from method calculations.
     * @usage  <pre>Noise.interpolatedNoise2D(x, y);</pre>
     * @param   x   (Number)  -- a real number.
     * @param   y   (Number)  -- a real number.
     * @return  (Number)  -- returns the final interpolated result.
    **/
    public static function interpolatedNoise2D(x:Number, y:Number):Number {
        var maxH:Number = 10;
        var maxV:Number = 10;
        var intX:Number, fracX:Number;
        var intY:Number, fracY:Number;
        var v1:Number, v2:Number, v3:Number, v4:Number;
        var i1:Number, i2:Number;

        if (x>maxH) x = 0;
        if (y>maxV) y = 0;
        if (x<0) x = maxH;
        if (y<0) y = maxV;

        intX = Math.floor(x);
        fracX = x-intX;
        intY = Math.floor(y);
        fracY = y-intY;

        v1 = Noise.smoothNoise2D(intX, intY);
        v2 = Noise.smoothNoise2D(intX+1, intY);
        v3 = Noise.smoothNoise2D(intX, intY+1);
        v4 = Noise.smoothNoise2D(intX+1, intY+1);
        i1 = Noise.interpolate2(v1, v2, fracX);
        i2 = Noise.interpolate2(v3, v4, fracX);

        return Noise.interpolate2(i1, i2, fracY);
    }

}// class
}//package

