package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.LightSource
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the LightSource Class.
 *              <p>
 *		        Provides utlity methods for the IObj interface based on JS
 *              RayTracer2 by John Haggerty.
 * @usage       <pre>var inst:LightSource = new LightSource(ray, color);</pre>
 * @param       ray (Vector)  -- a position Vector object.
 * @param       color (Col)  -- a Col object.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.util.Intersection
 *                com.vizsage.as3mathlib.math.geom.util.Ray
 *                com.vizsage.as3mathlib.math.geom.util.Transformation
 *                com.vizsage.as3mathlib.types.Col
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright [wisolutions2002@shaw.ca]
 * JS  original copyright © 2003, John Haggerty  [http://www.slimeland.com/]
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
 *       LightSource(pos, color)
 *             1.  transform(trans)
 *             2.  copy()
 *             3.  getLightColorAt(objs, pos)
 *             4.  sCurve(x) - static
 *             5.  samplePoint(objs, point, pos)
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
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.math.geom.util.Transformation;
import com.vizsage.as3mathlib.types.Col;
import flash.geom.ColorTransform;
import mx.rpc.mxml.Concurrency;

public class LightSource  {
	/**
	 * @property $pos (Vector)  -- a position Vector object.
	 * @property $v1 (Vector)  -- a direction Vector object used to define area light.
	 * @property $v2 (Vector)  -- a direction Vector object used to define area light.
	 * @property $dir (Vector)  -- a direction Vector object used to define spot light.
	 * @property $color (Col)  -- a Col object.
	 * @property $tColor (Col)  -- a target Col object.
	 * @property $sampleV1 (Boolean)  -- default is 'false', used to flag area light method steps.
	 * @property $sampleV2(Boolean)  -- default is 'false', used to flag area light method steps.
	 * @property $spotLight (Boolean)  -- default is 'false', used to flag spot light method steps.
	 * @property $minSampleDepth (Number)  -- a positive integer 0 ++.
	 * @property $maxSampleDepth (Number)  -- a positive integer.
	 * @property $innerAngleCos (Number)  -- a real number between 0 and 1.
	 * @property $outerAngleCos (Number)  -- a real number between 0 and 1.
	 * @property $outerAngle (Number)  -- a real number.
	 * @property $angleDiff (Number)  -- a real number.
	 * @property $jitterAmnt (Number)  -- a real number.
	 * @property $trans (Transformation)  -- a Transformation object.
	 * @property $objStack (Array)  -- a list of shape objects.
	**/
    public var $pos:Vector;
    public var $v1:Vector;
    public var $v2:Vector;
    public var $dir:Vector;
    public var $color:ColorTransform;
    public var $tColor:Col;
    public var $sampleV1:Boolean;
    public var $sampleV2:Boolean;
    public var $spotLight:Boolean;
    public var $minSampleDepth:Number;
    public var $maxSampleDepth:Number;
    public var $innerAngleCos:Number;
    public var $outerAngleCos:Number;
    public var $outerAngle:Number;
    public var $angleDiff:Number;
    public var $jitterAmnt:Number;
    public var $trans:Transformation;

    // constructor
    public function LightSource(pos:Vector, color:ColorTransform) {
    	$pos = pos;
    	$color = color;

    	// area light stuff
    	$sampleV1 = $sampleV2 = false;
    	$v1 = $v2 = Vector.OO.copy();
    	$minSampleDepth = $maxSampleDepth = $jitterAmnt = 0;

    	// spot light stuff
    	$spotLight = false;
    	$dir = Vector.XX.copy();
    	$innerAngleCos = -1;
    	$outerAngle = Math.PI;
    	$outerAngleCos = -1;
    	$angleDiff = 0;
    }

      // 1. transform ------------------------------------------------------------

    /**
     * @method  transform
     * @description   Transforms this instance's Vector objects.
     * @usage  <pre>inst.transform(trans);</pre>
     * @param   trans   (Transformation)  -- a Transformation object.
     * @return  (void)
    **/
    public function transform(trans:Transformation):void {
    	$pos.transform(trans, true);
    	if ($sampleV1) $v1.transform(trans, true);
    	if ($sampleV2) $v2.transform(trans, true);
    	if ($spotLight) $dir.transform(trans, true);
    };

      // 2. copy ------------------------------------------------------------

    /**
     * @method  copy
     * @description  Creates a copy of this instance's properties.
     * @usage  <pre>inst.copy();</pre>
     * @return  (LightSource)  -- returns a new LightSource object, a copy of this instance's properties.
    **/
    public function copy():LightSource {
    	var newColor:ColorTransform = new ColorTransform();
    	newColor.concat($color);
    	return new LightSource($pos.copy(), newColor);
    };

      // 3. getLightColorAt ------------------------------------------------------------

    /**
     * @method  getLightColorAt
     * @description  Called by super's 'getColorAt' method to define a new Col object.
     * @usage  <pre>inst.getLightColorAt(objs, pos);</pre>
     * @param   objs   (Array)  -- a list of shape objects.
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Col)  -- returns a new Col object.
    **/
    public function getLightColorAt(objs:Array, pos:Vector):ColorTransform {
    	throw new Error("AS2-AS3 Transition Error: Color changed to ColorTransform and we haven't fixed it yet");
    	/*
    	var toReturn:Col;
    	var cosineAngle:Number;
    	$tColor = new Col(this);

    	if ($spotLight) cosineAngle = Vector.dot(Vector.normalizer(Vector.adder(pos, Vector.neg($pos))), $dir);
    	if ($spotLight && cosineAngle<$outerAngleCos) return new Col($tColor, 0, 0, 0);
    	if ($sampleV1 || $sampleV2) {
    		toReturn = new Col($tColor, 0, 0, 0);

    		var numPointsSampled:Number = 0;
    		var foundBlockedPath:Boolean = false;
    		var foundUnblockedPath:Boolean = false;
    		var foundPartiallyBlockedPath:Boolean = false;
    		var thisSample:Col;
    		var maxDepthNumCellsMinusOne:Number = Math.pow(2, $maxSampleDepth), cellSize = 1/(maxDepthNumCellsMinusOne+1), xOffsetAmnt = .5, yOffsetAmnt = .5, cellSkip;

    		if (!$sampleV1) xOffsetAmnt = 0;
    		if (!$sampleV2) xOffsetAmnt = 0;

    		var stepXRes:Number = 1;
    		var stepYRes:Number = 1;
    		var depth:Number;
    		var y:Number;

    		for (depth=0;depth<=$maxSampleDepth;depth++) {
    			if ($sampleV1) stepXRes = Math.pow(2, depth)+1;
    			if ($sampleV2) stepYRes = Math.pow(2, depth)+1;
    			cellSkip = maxDepthNumCellsMinusOne/Math.pow(2, depth);
    			if (depth>$minSampleDepth && (!foundPartiallyBlockedPath && (foundBlockedPath!=foundUnblockedPath))) break;
    			for (y=0;y<stepYRes;y++) {
    				var x:Number = 0;
    				var xStep:Number = 1;

    				if (y%2==0 && depth!=0) {
    					x = 1;
    					xStep = 2;
    				}
    				for (;x<stepXRes;x+=xStep) {
    					if ($jitterAmnt!=0) {
    						if ($sampleV1) xOffsetAmnt = .5+(Math.random()-.5)*$jitterAmnt;
    						if ($sampleV2) yOffsetAmnt = .5+(Math.random()-.5)*$jitterAmnt;
    					}
    					thisSample = samplePoint(objs, Vector.adder
    					(
    						Vector.adder
    						(
    							$pos,
    							Vector.scaler($v1, ((x*cellSkip+xOffsetAmnt)*cellSize)*2-1)
    						),
    						Vector.scaler($v2, ((y*cellSkip+yOffsetAmnt)*cellSize)*2-1)
    					    ), pos
    					);
    					if (thisSample==$color) foundUnblockedPath = true;
    					else if (thisSample.r==0 && thisSample.g==0 && thisSample.b==0) foundBlockedPath = true;
    					else foundPartiallyBlockedPath = true;
    					toReturn = toReturn.adds(thisSample);
    					++numPointsSampled;
    				}
    			}
    		}
    		toReturn = toReturn.scalar(1/numPointsSampled);
    	}
    	else toReturn = samplePoint(objs, $pos, pos);
    	if ($spotLight && cosineAngle<$innerAngleCos) {
    		var theAngle:Number = Math.acos(cosineAngle);

    		toReturn = toReturn.scalar(LightSource.sCurve(($outerAngle-theAngle)/$angleDiff));
    	}

    	return toReturn;
    	*/
    	return null;
    }

      // 4. sCurve ------------------------------------------------------------

    /**
     * @method  sCurve
     * @description  Static -- Creates a derivative for a 3rd degree polynomial graph.
     * @usage  <pre>inst.sCurve(x);</pre>
     * @param   x   (Number)  -- a real number.
     * @return  (Number)  -- a real number, a derivative for a 3rd degree polynomial graph.
    **/
    public static function sCurve(x:Number):Number {
        return x*x*(3-2*x);
    }

      // 5. samplePoint ------------------------------------------------------------

    // - needs to be rewritten if transparency is ever supported;

    /**
     * @method  samplePoint
     * @description  Checks for any intersection at all between 'point' and 'pos' Vector objects.
     * @usage  <pre>inst.samplePoint(objs, point, pos);</pre>
     * @param   objs   (Array)  -- a list of shape objects.
     * @param   point   (Vector)  -- a position Vector object.
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Col)  -- returns a new Col object.
    **/
    public function samplePoint(objs:Array, point:Vector, pos:Vector):ColorTransform {
    	throw new Error("AS2-AS3 Transition Error: Color changed to ColorTransform and we haven't fixed it yet"); return null; 
    	/*
    	var distV:Vector = Vector.adder(point, Vector.neg(pos));
    	var shadowRay:Ray = new Ray(pos, distV);
    	$tColor = new Col(this);

    	shadowRay.$isShadowTest = true;

        var dist:Number = distV._len;
       	var shadowIsect:Intersection = shadowRay.tracer(objs, dist);

    	if (shadowIsect.$depth!=-1 && shadowIsect.$depth<=dist) return new Col($tColor, 0, 0, 0);
    	else return $color;
    	*/
    }

}// class
}//package

