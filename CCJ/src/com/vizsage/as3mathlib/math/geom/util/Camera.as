package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.Camera
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Camera Class.
 *              <p>
 *		        Provides utility methods for the IObj interface based on JS
 *              RayTracer2 by John Haggerty.
 * @usage       <pre>var inst:Camera = new Camera(loc, dir, right, down);</pre>
 * @param       loc (Vector)  -- a position Vector object.
 * @param       dir (Vector)  -- a direction Vector object.
 * @param       right (Vector)  -- a direction Vector object.
 * @param       down (Vector)  -- a direction Vector object.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.util.LightSource
 *                com.vizsage.as3mathlib.math.geom.util.Ray
 *                com.vizsage.as3mathlib.math.geom.util.Texture
 *                com.vizsage.as3mathlib.math.geom.util.Transformation
 *                com.vizsage.as3mathlib.types.Col
 *                com.vizsage.as3mathlib.types.Obj
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
 *   Functions:
 *       Camera(loc, dir, right, down)
 *             1.  transform(trans)
 *             2.  trace(object_arr, light_arr, xAmnt, yAmnt)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This class is under construction .. it presently loads
 *       without error, but the testing environment is incomplete. There are
 *       traces and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.util.LightSource;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.math.geom.util.Texture;
import com.vizsage.as3mathlib.math.geom.util.Transformation;
import com.vizsage.as3mathlib.types.Col;
import com.vizsage.as3mathlib.types.Obj;
import flash.geom.ColorTransform;

public class Camera  {
	/**
	 * @property $loc (Vector)  -- a position Vector object.
	 * @property $dir (Vector)  -- a direction Vector object.
	 * @property $right(Vector)  -- a direction Vector object.
	 * @property $down (Vector)  -- a direction Vector object.
	**/
    public var $loc:Vector;
    public var $dir:Vector;
    public var $right:Vector;
    public var $down:Vector;

    // constructor
    public function Camera(loc:Vector, dir:Vector, right:Vector, down:Vector) {
	    if (typeof(loc)  =="undefined") 	$loc   = Vector.OO;
	    if (typeof(dir)  =="undefined") 	$dir   = Vector.ZZ;
	    if (typeof(right)=="undefined") 	$right = Vector.scaler(Vector.XX, 4/3);
	    if (typeof(down) =="undefined") 	$down  = Vector.neg(Vector.YY);
	    $loc = loc;
	    $dir = dir;
	    $right = right;
	    $down = down;
    }

      // 1. transform ----------------------------------

    /**
     * @method  transform
     * @description   Transforms this instance's properties.
     * @usage  <pre>inst.transform(trans);</pre>
     * @param   trans   (Transformation)  -- a Transformation object.
     * @return  (void)
    **/
    public function transform(trans:Transformation):void {
	    $loc.transform	(trans);
	    $dir.transform	(trans, true);
	    $right.transform(trans, true);
	    $down.transform	(trans, true);
    }

      // 2. trace --------------------------------------

    /**
     * @method  trace
     * @description  Create a new Col object from Ray class instance's
     *               'traceForClor' method, which in turn calls super's
     *               'getColorAt' method.
     * @usage  <pre>inst.trace(object_arr, light_arr, xAmnt, yAmnt);</pre>
     * @param   object_arr   (Array)  -- a list of shape objects.
     * @param   light_arr   (Array)  -- a list of LightSource objects.
     * @param   xAmnt   (Number)  -- a real number.
     * @param   yAmnt   (Number)  -- a real number.
     * @return  (Col)  -- returns a new Col object.
    **/
    public function trace(object_arr:Array, light_arr:Array, xAmnt:Number, yAmnt:Number):ColorTransform {/*
	    var ray:Ray = new Ray
	    (
		    $loc,
		    Vector.adder(Vector.adder($dir, Vector.scaler($right, (xAmnt-.5))), Vector.scaler($down, (yAmnt-.5)))
	    );

	    return ray.traceForColor(object_arr, light_arr, 1, 1);*/
	    throw new Error("AS2-AS3 Transition Error: Color changed to ColorTransform and we haven't fixed it yet");
    }

}// class
}//package

