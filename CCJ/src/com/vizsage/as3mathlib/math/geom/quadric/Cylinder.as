package com.vizsage.as3mathlib.math.geom.quadric {
/**
 * @class       com.vizsage.as3mathlib.math.geom.quadric.Cylinder
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Cylinder Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty. Since the interface doesn't permit overloading
 *              methods, I've added the 'getNormalAt' method to define the normal
 *              to the passed intersection and 'pos' Vector object, and I've changed
 *              'getNormalAtUntransformed' into an abstract method that supports
 *              the interface but doesn't get called. This is a workaround and may
 *              change with testing.
 * @usage       <pre>var inst:Cylinder = new Cylinder(end1, end1, rad, open);</pre>
 * @param       end1 (Vector)  -- a position Vector object defining the center of one end of the cylinder.
 * @param       end2 (Vector)  -- a position Vector object defining the center of the other end of the cylinder.
 * @param       rad (Number)  -- a real number for radius of the cylinder barrel.
 * @param       open (Boolean)  -- default is 'false', cylinder ends are closed.
 * -----------------------------------------------
 * Latest update: August 2, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.polytope.Box
 *                com.vizsage.as3mathlib.math.geom.util.Intersection
 *                com.vizsage.as3mathlib.math.geom.util.Ray
 *                com.vizsage.as3mathlib.types.IObj
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
 *       Cylinder(end1, end2, rad, open)
 *             1.  copy()
 *             2.  initialize()
 *             3.  findIntersectionsUntransformed(ray)
 *             4.  isPointInsideUntransformed(pos)
 *             5.  getNormalAtUntransformed(pos)
 *             6.  getNormalAt(pos, isect)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This Obj subclass is under construction .. it presently loads
 *       without error, but the testing environment is incomplete, and
 *       method inheritance has yet to be refined. There are traces
 *       and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.polytope.Box;
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.types.IObj;
import com.vizsage.as3mathlib.types.Obj;

public class Cylinder extends Obj implements IObj {
	/**
	 * @property $end1 (Vector)  -- a position Vector object defining the center of one end of the cylinder.
	 * @property $end2 (Vector)  -- a position Vector object defining the center of the other end of the cylinder.
	 * @property $negEnd1 (Vector)  -- a Vector object defining negative of $end1.
	 * @property $negEnd2 (Vector)  -- a Vector object defining negative of $end1.
	 * @property $normAxis (Vector)  -- a Vector object defining the normal to the cylinder barrel axis.
	 * @property $negNormAxis (Vector)  -- a Vector object defining negative of $normAxis.
	 * @property $rad (Number)  -- a real number for radius of the cylinder barrel.
	 * @property $radSquared (Number)  -- a real number for square of the radius.
	 * @property $open (Boolean)  -- default is 'false', cylinder ends are closed.
	 * @property $boundedBy (Box)  -- bounding box object.
	**/
    public var $end1:Vector;
    public var $end2:Vector;
    public var $negEnd1:Vector;
    public var $negEnd2:Vector;
    public var $normAxis:Vector;
    public var $negNormAxis:Vector;
    public var $rad:Number;
    public var $radSquared:Number;
    public var $open:Boolean;

    // constructor
    public function Cylinder(end1:Vector, end2:Vector, rad:Number, open:Boolean) {
	    $end1 = end1;
    	$end2 = end2;
    	$rad = rad;
    	$open = open;
    	this.setupDefaultModifiers();
    }

      // 1. copy ---------------------------------------

    /**
     * @method  copy
     * @description  Copies super's properties with its 'copyModifiers' method.
     * @usage  <pre>inst.copy();</pre>
     * @return  (Obj)  -- returns a new Cylinder object populated with super's properties.
    **/
    override public function copy():Obj {
    	return this.copyModifiers(new Cylinder($end1.copy(), $end2.copy(), $rad, $open));
    }

      // 2. initialize ---------------------------------

    /**
     * @method  initialize
     * @description  Initializes this instance's bounding box and its super's
     *               low-level properties, and defines $radSquared, $negEnd1,
     *               $negEnd2, $normAxis, and $negNormAxis properties.
     * @usage  <pre>inst.initialize();</pre>
     * @return  (void)
    **/
    override public function initialize():void {
    	$negEnd1 = Vector.neg($end1);
    	$negEnd2 = Vector.neg($end2);
    	$normAxis = Vector.normalizer(Vector.adder($end2, $negEnd1));
    	$negNormAxis = Vector.neg($normAxis);
    	$radSquared = $rad*$rad;

    	var v1:Vector = $end1.copy();
    	var v2:Vector = $end2.copy();
    	var temp:Number;
    	var cosines:Vector;
    	var capBound:Vector;

    	if (v1.x>v2.x) {
    		temp = v1.x;
    		v1.x = v2.x;
    		v2.x = temp;
    	}
    	if (v1.y>v2.y) {
    		temp = v1.y;
    		v1.y = v2.y;
    		v2.y = temp;
    	}
    	if (v1.z>v2.z) {
    		temp = v1.z;
    		v1.z = v2.z;
    		v2.z = temp;
    	}
    	cosines = new Vector(Vector.dot(Vector.XX, $normAxis), Vector.dot(Vector.YY, $normAxis), Vector.dot(Vector.ZZ, $normAxis));
    	capBound = Vector.scaler(new Vector(Math.sqrt(1-cosines.x*cosines.x), Math.sqrt(1-cosines.y*cosines.y), Math.sqrt(1-cosines.z*cosines.z)), $rad);
    	$boundedBy = new Box(Vector.adder(Vector.neg(capBound), v1), Vector.adder(capBound, v2), true);
    	this.generalLowLevelObjectInitialization();
    }

      // 3. findIntersectionsUntransformed -------------

    /**
     * @method  findIntersectionsUntransformed
     * @description  Calculates enter and exit intersections, if any, defined by
     *               'ray' tracer.
     * @usage  <pre>inst.findIntersectionsUntransformed(ray);</pre>
     * @param   ray   (Ray)  -- tracer object that defines its point and direction in 3-space.
     * @return  (Array)  -- returns a list of Intersection objects, or an empty list.
    **/
    override public function findIntersectionsUntransformed(ray:Ray):Array {
    	var isects:Array  = [];
    	var rayStartMinusThisEnd1:Vector = Vector.adder(ray.$start, $negEnd1);
    	var a:Number;
        var b:Number;
        var c:Number;
        var t:Number;
        var discriminant:Number;
    	var nearestPointOnAxis:Vector;
        var pos:Vector;
        var u:Vector;
        var v:Vector;

    	// caps
    	if (!$open) {
    		a = Vector.dot(ray.$dir, $normAxis);
    		if (a!=0) {
    			b = Vector.dot($normAxis, rayStartMinusThisEnd1);
    			t = -b/a;
    			if (Vector.adder(Vector.adder(ray.$start, Vector.scaler(ray.$dir, t)), $negEnd1)._lenSq<=$radSquared) {
    				isects[0] = new Intersection(t, ray, this);
    				isects[0].data = 1; // remember that this is on a cap of the cylinder for normal calculation
    			}

    			b = Vector.dot($negNormAxis, Vector.adder(ray.$start, $negEnd2));
    			t = b/a;
    			if (Vector.adder(Vector.adder(ray.$start, Vector.scaler(ray.$dir, t)), $negEnd2)._lenSq<=$radSquared) {
    				isects[isects.length] = new Intersection(t, ray, this);
    				isects[isects.length-1].$data = 2;
    			}
    		}
    	}
    	// cylinder
    	if (isects.length<2) {
    		u = Vector.adder(ray.$dir, Vector.scaler($normAxis, -Vector.dot(ray.$dir, $normAxis)));
    		v = Vector.adder(rayStartMinusThisEnd1, Vector.scaler($normAxis, -Vector.dot(rayStartMinusThisEnd1, $normAxis)));

    		a = Vector.dot(u, u);
    		// a=b=c=0 means that the ray is travelling right along the cylinder's side. (not positive c would be zero, but i think so; it would make sense mathematically: infinite solutions.)
    		if (a!=0) {
    			b = 2*Vector.dot(u, v);
    			c = Vector.dot(v, v)-$radSquared;
    			discriminant = b*b-4*a*c;
    			if (discriminant==0) {
    				t = -b/(2*a);
    				pos = Vector.adder(ray.$start, Vector.scaler(ray.$dir, t));
    				if ((Vector.dot($normAxis, Vector.adder(pos, $negEnd1))>0) &&
    				    (Vector.dot($negNormAxis, Vector.adder(pos, $negEnd2))>0)) {
    					isects[isects.length] = new Intersection(t, ray, this);
    			    }
    			}
    			else if (discriminant>0) {
    				var sqrtDiscriminant:Number = Math.sqrt(discriminant);
    				var oneOverTwoA:Number = 1/(2*a);

    				t = (-sqrtDiscriminant-b)*oneOverTwoA;
    				pos = Vector.adder(ray.$start, Vector.scaler(ray.$dir, t));
    				if ((Vector.dot($normAxis, Vector.adder(pos, $negEnd1))>0) &&
    				    (Vector.dot($negNormAxis, Vector.adder(pos, $negEnd2))>0)) {
    					isects[isects.length] = new Intersection(t, ray, this);
    				}
    				if (isects.length<2) {
    					t = (sqrtDiscriminant-b)*oneOverTwoA;
    					pos = Vector.adder(ray.$start, Vector.scaler(ray.$dir, t));
    					if ((Vector.dot($normAxis, Vector.adder(pos, $negEnd1))>0) &&
    					    (Vector.dot($negNormAxis, Vector.adder(pos, $negEnd2))>0)) {
    						isects[isects.length] = new Intersection(t, ray, this);
    					}
    				}
    			}
    		}
    	}
    	// sort
    	if (isects.length>1 && isects[1].$depth<isects[0].$depth) {
    		var temp:Intersection = isects[1];
    		isects[1] = isects[0];
    		isects[0] = temp;
    	}

    	return isects;
    }

      // 4. isPointInsideUntransformed -----------------

    /**
     * @method  isPointInsideUntransformed
     * @description  Tests whether passed 'pos' Vector object is inside this instance.
     * @usage  <pre>inst.isPointInsideUntransformed(pos);</pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Boolean)
    **/
    override public function isPointInsideUntransformed(pos:Vector):Boolean {
    	// test inside of caps (similar to plane test)
    	if (Vector.dot($normAxis, Vector.adder(pos, $negEnd1))<0) return false;

    	if (Vector.dot($negNormAxis, Vector.adder(pos, $negEnd2))<0) return false;

    	// find nearest point to this on the axis and test what the distance to it is
    	var nearestPointOnAxis:Vector = Vector.adder(Vector.scaler($normAxis, Vector.dot(Vector.adder(pos, $negEnd1), $normAxis)), $end1);

    	return ( Vector.adder(pos, Vector.neg(nearestPointOnAxis))._lenSq < $radSquared );
    }

      // 5. getNormalAtUntransformed -------------------

    /**
     * @method  getNormalAtUntransformed
     * @description  Defines the normal to the passed 'pos' Vector object.
     * @usage  <pre>inst.getNormalAtUntransformed(pos);</pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Vector)  -- returns normal of passed Vector object.
    **/
    override public function getNormalAtUntransformed(pos:Vector):Vector {
    	return Vector.normalizer(pos);
    }

      // 5. getNormalAt -------------------

    /**
     * @method  getNormalAt
     * @description  Defines the normal to the passed 'pos' Vector object.
     * @usage  <pre>inst.getNormalAt(pos, isect);</pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @param   isect   (Intersection)  -- an Intersection object.
     * @return  (Vector)  -- returns normal of passed Vector object.
    **/
    override public function getNormalAt(pos:Vector = null, isect:Intersection = null):Vector {
    	if (isect.$data) {
    		if (isect.$data==1) return $negNormAxis;

    		return $normAxis;
    	}
    	else {
    		var nearestPointOnAxis:Vector = Vector.adder(Vector.scaler($normAxis, Vector.dot(Vector.adder(pos, $negEnd1), $normAxis)), $end1);

    		return Vector.adder(pos, Vector.neg(nearestPointOnAxis));
    	}
    }

}// class
}//package

