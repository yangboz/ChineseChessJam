package com.vizsage.as3mathlib.math.geom.quadric {
/**
 * @class       com.vizsage.as3mathlib.math.geom.quadric.Sphere
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Sphere Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty.
 * @usage       <pre>var inst:Sphere= new Sphere(pos, rad);</pre>
 * @param       pos (Vector)  -- a position Vector object.
 * @param       rad (Number)  -- a real number for radius value.
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
 *       Sphere(pos, rad)
 *             1.  copy()
 *             2.  initialize()
 *             3.  findIntersectionsUntransformed(ray)
 *             4.  isPointInsideUntransformed(pos)
 *             5.  getNormalAtUntransformed(pos)
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

public class Sphere extends Obj implements IObj {
	/**
	 * @property $pos (Vector)  -- a position Vector object.
	 * @property $negPos (Vector)  -- a position Vector object.
	 * @property $rad (Number)  -- a real number for radius value.
	 * @property $radSquared (Number)  -- a real number for square of radius value.
	**/
    public var $pos:Vector;
    public var $negPos:Vector;
    public var $rad:Number;
    public var $radSquared:Number;

    // constructor
    public function Sphere(pos:Vector, rad:Number) {
    	$pos = pos;
    	$rad = rad;
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
    	return this.copyModifiers(new Sphere($pos.copy(), $rad));
    }

      // 2. initialize ---------------------------------

    /**
     * @method  initialize
     * @description  Initializes this instance's bounding box and its super's low-level properties,
     *               and defines $radSquared and $negPos properties.
     * @usage  <pre>inst.initialize();</pre>
     * @return  (void)
    **/
    override public function initialize():void {
    	this.$boundedBy = new Box(Vector.adder(new Vector(-$rad, -$rad, -$rad), $pos), Vector.adder(new Vector($rad, $rad, $rad), $pos), true);
    	$radSquared = $rad*$rad;
    	$negPos = Vector.neg($pos);
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
    	var startMinusThisPos:Vector = Vector.adder(ray.$start, $negPos);
    	var a:Number = Vector.dot(ray.$dir, ray.$dir);
    	var b:Number = 2*Vector.dot(startMinusThisPos, ray.$dir);
    	var c:Number = Vector.dot(startMinusThisPos, startMinusThisPos)-$radSquared;
    	var discriminant:Number = b*b-4*a*c;

    	if (discriminant<0) return [];
    	if (discriminant==0) return [new Intersection(-b/(2*a), ray, this)];

    	var sqrtDiscriminant:Number = Math.sqrt(discriminant);
    	var oneOverTwoA:Number = 1/(2*a);

    	return [new Intersection((-b-sqrtDiscriminant)*oneOverTwoA, ray, this), new Intersection((sqrtDiscriminant-b)*oneOverTwoA, ray, this)];
    };

      // 4. isPointInsideUntransformed -----------------

    /**
     * @method  isPointInsideUntransformed
     * @description  Tests whether passed 'pos' Vector object is inside this instance.
     * @usage  <pre>inst.isPointInsideUntransformed(pos);</pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Boolean)
    **/
    override public function isPointInsideUntransformed(pos:Vector):Boolean {
    	var a:Vector = Vector.adder(pos, $negPos);

    	return (a._lenSq<=$radSquared);
    }

      // 5. getNormalAtUntransformed -------------------

    /**
     * @method  getNormalAtUntransformed
     * @description  Defines the normal to the passed 'pos' Vector object.
     * @usage  <pre>inst.getNormalAtUntransformed(pos);</pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Vector)  -- returns normal of untransformed vector.
    **/
    override public function getNormalAtUntransformed(pos:Vector):Vector {
    	return Vector.adder(pos, $negPos);
    }

}// class
}//package

