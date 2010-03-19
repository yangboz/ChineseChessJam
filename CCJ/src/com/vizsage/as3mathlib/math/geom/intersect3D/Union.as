package com.vizsage.as3mathlib.math.geom.intersect3D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect3D.Union
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Union Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty.
 * @usage       <pre>var inst:Union = new Union(objects)</pre>
 * @param       objects (Array)  -- a list of shape objects.
 * -----------------------------------------------
 * Latest update: August 2, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.polytope.Box
 *                com.vizsage.as3mathlib.math.geom.util.Intersection
 *                com.vizsage.as3mathlib.math.geom.util.Ray
 *                com.vizsage.as3mathlib.math.geom.util.Transformation
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
 * Functions:
 *       Union(objects)
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
 *       method inheritance has yet to be refined. There might be traces
 *       and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.polytope.Box;
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.math.geom.util.Transformation;
import com.vizsage.as3mathlib.types.IObj;
import com.vizsage.as3mathlib.types.Obj;

public class Union extends Obj implements IObj {
	/**
	 * @property $objects (Array)  -- a list of shape objects.
	 * @property $testBoundingBox (Boolean)  -- defined in UI 'main.as'
	**/
    public var $objects:Array;
    public var $testBoundingBox:Boolean;

    // constructor
    public function Union(objects:Array) {
    	$objects = objects;
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
    	var objectsCopy:Array = [];
    	var a:Number;

    	for (a=0;a<$objects.length;a++) objectsCopy[a] = $objects[a].copy();

    	var toReturn:Union = new Union(objectsCopy);
    	toReturn.$testBoundingBox = $testBoundingBox;

    	return this.copyModifiers(new Union(objectsCopy));
    }

      // 2. initialize ---------------------------------

    /**
     * @method  initialize
     * @description  Initializes this instance's bounding box and its super's low-level properties.
     * @usage  <pre>inst.initialize();</pre>
     * @return  (void)
    **/
    override public function initialize():void {
        var a:Number;

    	for (a=0;a<$objects.length;a++) {
    		$objects[a].$transform = Transformation.multipleTrans([$objects[a].$transform, this.$transform]);
    		$objects[a].$texture.$transform = Transformation.multipleTrans([$objects[a].$texture.$transform, this.$transform])
    		$objects[a].initialize();
    	}
    	this.$transform = Transformation.$IdentityTrans.copy();

    	if (typeof($testBoundingBox)=="undefined") $testBoundingBox = false;
    	this.$volumeOutsideOfBounds = $objects[0].$volumeOutsideOfBounds;
    	this.$infiniteBounds = $objects[0].$infiniteBounds;
    	for (a=1;a<$objects.length;a++) {
    		if ($objects[a].$volumeOutsideOfBounds) this.$volumeOutsideOfBounds = true;
    		if ($objects[a].$infiniteBounds) this.$infiniteBounds = true;
    	}
    	if ($testBoundingBox && !this.$infiniteBounds) {
    		var v1:Vector = $objects[0].$boundedBy.$v1.copy();
    		var v2:Vector = $objects[0].$boundedBy.$v2.copy();

    		for (a=1;a<$objects.length;a++) {
    			var nv1:Vector = $objects[a].$boundedBy.$v1;
    			var nv2:Vector = $objects[a].$boundedBy.$v2;

    			if (nv1.x<v1.x) v1.x = nv1.x;
    			if (nv1.y<v1.y) v1.y = nv1.y;
    			if (nv1.z<v1.z) v1.z = nv1.z;
    			if (nv2.x>v2.x) v2.x = nv2.x;
    			if (nv2.y>v2.y) v2.y = nv2.y;
    			if (nv2.z>v2.z) v2.z = nv2.z;
    		}
    		this.$boundedBy = new Box(v1, v2);
    	}
    	else if (!$testBoundingBox) {
    		this.$infiniteBounds = true; // avoids any bounds testing on this
    	}
    	if (this.$inversed && !this.$infiniteBounds) {
    		this.$volumeOutsideOfBounds = true;
    		// it might be false (for instance, if this is a union containing an inversed sphere, inversed),
    		// but we don't know for sure and it's safer to assume that it's true.
    		// i think the case where it changes anything is rare enough that it won't really matter.
    	}
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
    	var toReturn:Array = [];
    	var a:Number, b:Number;

    	// find every intersection of every object
    	for (a=0;a<$objects.length;a++) {
    		var thisObjectsIntersections:Array = $objects[a].findIntersections(ray);
    		for (b=0;b<thisObjectsIntersections.length;b++) {
    			thisObjectsIntersections[b].addobject(this);
    			toReturn[toReturn.length] = thisObjectsIntersections[b];
    		}
    	}

	    return toReturn.sort(Intersection.closerIntersection);
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
        var a:Number;

    	for (a=0;a<$objects.length;a++) if ($objects[a].isPointInside(pos)) return true;

    	return false;
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
    	return Vector.normalizer(pos);
    }

}// class
}//package

