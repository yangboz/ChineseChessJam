package com.vizsage.as3mathlib.math.geom.polytope {
/**
 * @class       com.vizsage.as3mathlib.math.geom.polytope.Plane
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Plane Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty. Since the interface doesn't permit overloading
 *              methods, I've added the 'getNormalAt' method that doesn't pass
 *              parameters, which retrieves the normal ($norm) to this instance, and
 *              I've changed 'getNormalAtUntransformed' into an abstract method that
 *              supports the interface structure but doesn't get called. This is a
 *              workaround and may change with testing.
 * @usage       <pre>var inst:Plane = new Plane(normal, dist);</pre>
 * @param       normal (Vector)  -- a Vector object normal to this plane.
 * @param       dist (Number)  -- a scalar value.
 * -----------------------------------------------
 * Latest update: August 2, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
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
 *       Plane(normal, dist)
 *             1.  copy()
 *             2.  initialize()
 *             3.  findIntersectionsUntransformed(ray)
 *             4.  isPointInsideUntransformed(pos)
 *             5.  getNormalAtUntransformed(pos)
 *             6.  getNormalAt()
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
 * NOTE: This Obj subclass is under construction .. it presently loads
 *       without error, but the testing environment is incomplete, and
 *       method inheritance has yet to be refined. There are traces
 *       and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.types.IObj;
import com.vizsage.as3mathlib.types.Obj;

public class Plane extends Obj implements IObj {
	/**
	 * @property $norm (Vector) a Vector object defining normalized normal to the plane.
	 * @property $negCenterPoint (Vector)  -- a Vector object defining negative of scaled normal to the plane.
	 * @property $dist (Number)  -- a scalar value.
	 * @property $infiniteBounds (Boolean)  -- default is 'true'.
	**/
    public var $norm:Vector;
    public var $negCenterPoint:Vector;
    public var $dist:Number;

    // constructor
    public function Plane(normal:Vector, dist:Number) {
    	$norm = Vector.normalizer(normal);
    	$dist = dist;
    	this.setupDefaultModifiers();
    }

      // 1. copy ---------------------------------------

    /**
     * @method  copy
     * @description  Copies super's properties with its 'copyModifiers' method.
     * @usage  <pre>inst.copy();</pre>
     * @return  (Obj)  -- returns a new Sphere object populated with super's properties.
    **/
    override public function copy():Obj {
    	return this.copyModifiers(new Plane($norm.copy(), $dist));
    }

      // 2. initialize ---------------------------------

    /**
     * @method  initialize
     * @description  Initializes this instance's bounding box and its super's low-level properties,
     *               and defines $infiniteBounds and $negCenterPoint properties.
     * @usage  <pre>inst.initialize();</pre>
     * @return  (void)
    **/
    override public function initialize():void {
    	$infiniteBounds = true;
    	$negCenterPoint = Vector.neg(Vector.scaler($norm, $dist));
    	this.generalLowLevelObjectInitialization();
    }

      // 3. findIntersectionsUntransformed -------------

    /**
     * @method  findIntersectionsUntransformed
     * @description  Calculates enter and exit intersections, if any, defined by 'ray' tracer.
     * @usage  <pre>inst.findIntersectionsUntransformed(ray);</pre>
     * @param   ray   (Ray)  -- tracer object that defines its point and direction in 3-space.
     * @return  (Array)  -- returns a list of Intersection objects, or an empty list.
    **/
    override public function findIntersectionsUntransformed(ray:Ray):Array {
    	var a:Number = Vector.dot(ray.$dir, $norm);

    	if (a==0) return [];

    	var b:Number = Vector.dot($norm, Vector.adder(ray.$start, $negCenterPoint));

    	return [new Intersection(-b/a, ray, this)];
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
    	return (Vector.dot($norm, Vector.adder(pos, $negCenterPoint))<=0);
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

      // 6. getNormalAt -------------------

    /**
     * @method  getNormalAt
     * @description  Retrieves this instance's $norm property.
     * @usage  <pre>inst.getNormalAt();</pre>
     * @return  (Vector)  -- returns a normalized 'normal' Vector object passed at initialization.
    **/
    override public function getNormalAt(pos:Vector = null, isect:Intersection = null):Vector {
        return $norm;
    }

}// class
}//package

