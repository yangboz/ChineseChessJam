package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.Ray
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Ray Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty.
 * @usage       <pre>var inst:Ray = new Ray(start, dir, distMult);</pre>
 * @param       start (Vector)  -- a position Vector object.
 * @param       dir (Vector)  -- a direction Vector object.
 * @param       distMult (Number)  -- a scalar value for this instance's magnitude.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Point
 *                com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.util.LightSource
 *                com.vizsage.as3mathlib.math.geom.util.Intersection
 *                com.vizsage.as3mathlib.math.geom.util.Transformation
 *                com.vizsage.as3mathlib.types.Col.as
 * -----------------------------------------------
 * AS2 revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
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
 *       Ray(start, dir, distMult)
 *             1.  copy()
 *             2.  toString()
 *             3.  transform(trans)
 *             4.  transformed(trans)
 *             5.  tracer(objs, giveUpAt)
 *             6.  traceForColor(objs, lights, traceLevel, effect)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This class is under construction .. it presently loads
 *       without error, but the testing environment is incomplete. There are
 *       traces and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.util.LightSource;
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Transformation;
import com.vizsage.as3mathlib.types.Col;
import flash.display.MovieClip;
import flash.geom.ColorTransform;

public class Ray  {
	/**
	 * @property $start (Vector)  -- start position of vector in 3-space.
	 * @property $dir (Vector)  -- direction of vector in 3-space.
	 * @property $distMult (Number)  -- scaler for ray magnitude.
	 * @property $isShadowTest (Boolean)  -- default is 'false'.
	 * @property $trans (Transformation)  -- a Transformation object.
	 * @property $ACCURACY (Number)  -- static -- precision for calculations -- 1e-8.
	**/
    public var $start:Vector;
    public var $dir:Vector;
    public var $distMult:Number;
    public var $isShadowTest:Boolean;
    public var $trans:Transformation;
    public static var $ACCURACY:Number = .00000001;

    // constructor
    public function Ray(start:Vector, dir:Vector, distMult:Number) {
        trace ("Ray Class fired");
    	$start = start;
    	$dir = Vector.normalizer(dir);
    	distMult ? $distMult = distMult : $distMult = 1;
    	$isShadowTest = false;
    }

      // 1. copy ------------------------------------------------------------

    /**
     * @method  copy
     * @description  Makes a copy of the class instance properties.
     * @usage  <pre>inst.copy();</pre>
     * @return  (Ray)  -- returns a copy of the class instance.
    **/
    public function copy():Ray {
    	var toReturn:Ray = new Ray($start.copy(), $dir.copy(), $distMult);

    	toReturn.$isShadowTest = $isShadowTest;

    	return toReturn;
    }

      // 2. toString ------------------------------------------------------------

    /**
     * @method  toString
     * @description  Creates a descriptive string containing class Vector properties.
     * @usage  <pre>inst.toString();</pre>
     * @return  (String)  -- returns a string containing class Vector properties.
    **/
    public function toString():String {
    	return "[Ray from "+$start+" in the direction of "+$dir+"]";
    }

      // 3. transform ------------------------------------------------------------

    /**
     * @method  transform
     * @description  Transforms this instance using passed 'trans' Transformation object.
     * @usage  <pre>inst.transform(trans);</pre>
     * @param   trans   (Transformation)  -- a Transformation object.
     * @return  (void)
    **/
    public function transform(trans:Transformation):void {
    	$start.transform(trans);
    	$dir.transform(trans, true);

    	var dirLength:Number = $dir._len;

    	$distMult /= dirLength;
    	$dir = Vector.scaler($dir, 1/dirLength); // (normalize)
    }

      // 4. transformed ------------------------------------------------------------

    /**
     * @method  transformed
     * @description  Creates a new transformed Ray object.
     * @usage  <pre>inst.transformed(trans);</pre>
     * @param   trans   (Transformation)  -- a Transformation object.
     * @return  (Ray)  -- returns a new transformed Ray object.
    **/
    public function transformed(trans:Transformation):Ray {
    	var toReturn:Ray = copy();

    	toReturn.$distMult = 1;
    	toReturn.transform(trans);

    	return toReturn;
    }

      // 5. tracer ------------------------------------------------------------

    /**
     * @method  tracer
     * @description  Trace this instance's path for intersection(s) with passed shape objects.
     * @usage  <pre>inst.tracer(obs, giveUpAt);</pre>
     * @param   objs_arr   (Array)  -- a list of shape objects.
     * @param   giveUpAt   (Number)  -- tests against newly created list of intersections' $depth property.
     * @return  (Intersection)  -- returns a new Intersection object.
    **/
    public function tracer(objs_arr:Array, giveUpAt:Number):Intersection {
    	var winningIsect:Intersection = new Intersection(-1, this, null);
    	var intersections:Array = [];
    	var a:Number, b:Number;

    	for (a=0;a<objs_arr.length;a++) {
    		intersections = objs_arr[a].findIntersections(this);
    		for (b=0;b<intersections.length;b++) {
    			if (intersections[b].$depth>Ray.$ACCURACY) {
    				if (winningIsect.$depth==-1 || intersections[b].$depth<winningIsect.$depth) {
    					winningIsect = intersections[b];
    					if ($isShadowTest && intersections[b].$depth<=giveUpAt) return winningIsect;
    				}
    				break;
    			}
    		}
    	}

    	return winningIsect;
    }

      // 6. traceForColor ------------------------------------------------------------

    /**
     * @method  traceForColor
     * @description  Creates a new Col object by calling super's 'getColorAt' method.
     * @usage  <pre>inst.traceForColor(objs, lights, traceLevel, effect, clip)</pre>
     * @param   objs_arr   (Array)  -- a list of shape objects.
     * @param   lights_arr   (Array)  -- a list of LightSource objects.
     * @param   traceLevel   (Number)  -- a maximum value for traces.
     * @param   effect   (Number)  -- -- a real number passed to test against super's $bailout property.
     * @param   clip   (MovieClip)  -- scope MovieClip object.
     * @return  (Col)  -- returns a new Col object.
    **/
    public function traceForColor(objs_arr:Array, lights_arr:Array, traceLevel:Number, effect:Number, clip:MovieClip):ColorTransform {
    	throw new Error("AS2-AS3 Transition Error: Color changed to ColorTransform and we haven't fixed it yet");
    	/*
    	var isect:Intersection = new Intersection(-1, this, null);
    	isect = tracer(objs_arr, traceLevel);
		var target:Col = new Col(clip);

        if (isect.$depth==-1) return new Col(target, 0, 0, 0);

    	return isect.$objectStack[0].getColorAt(isect, objs_arr, lights_arr, traceLevel, effect);*/
    	return null;
    }

}// class
}//package

