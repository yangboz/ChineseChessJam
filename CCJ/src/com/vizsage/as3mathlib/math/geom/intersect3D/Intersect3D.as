package com.vizsage.as3mathlib.math.geom.intersect3D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect3D.Intersect3D
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Intersect3D Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty.
 * @usage       <pre>var inst:Intersect3D = new Intersect3D(objects);</pre>
 * @param       objects (Array)   -- a list of shape objects.
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
 * AS2 revision copyright: � 2003, Richard Wright [wisolutions2002@shaw.ca]
 * JS  original copyright: � 2003, John Haggerty  [http://www.slimeland.com/]
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
 *       Intersect3D(objects)
 *             1.  copy()
 *             2.  initialize()
 *             3.  findIntersectionsUntransformed(ray)
 *             4.  isPointInsideUntransformed(pos)
 *             5.  getNormalAtUntransformed(pos)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This Obj subclass is under construction .. it presently loads
 *       without error, but the testing environment is incomplete, and
 *       method inheritance has yet to be refined. There remains in place
 *       traces and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.polytope.Box;
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.math.geom.util.Transformation;
import com.vizsage.as3mathlib.types.IObj;
import com.vizsage.as3mathlib.types.Obj;

public class Intersect3D extends Obj implements IObj {
	/**
	 * @property $objects (Array)    -- a list of shape objects.
	 * @property $transform (Transformation)  -- a Transformation object.
	 * @property $boundedBy (Box)  -- a bounding box object.
	 * @property $infiniteBounds (Boolean)  -- default is 'false', inherited from super.
	 * @property $volumeOutsideOfBounds (Boolean)  -- default is 'false', inherited from super.
	**/
    public var $objects:Array;
    /* bad
    public var $transform:Transformation;
    public var $boundedBy:Box;
    public var $infiniteBounds:Boolean;
    public var $volumeOutsideOfBounds:Boolean; */

    // constructor
    public function Intersect3D(objects:Array) {
        //trace ("Intersect3D Class loaded");
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

    	return this.copyModifiers(new Intersect3D(objectsCopy));
    }

      // 2. initialize ---------------------------------

    /**
     * @method  initialize
     * @description  Initializes this instance's bounding box and its super's low-level properties,
     *               and defines $transform, $boundedBy, $infiniteBounds, and
     *               $volumeOutsideOfBounds properties.
     * @usage  <pre>inst.initialize();</pre>
     * @return  (void)
    **/
    override public function initialize():void {
        var a:Number;

    	for (a=0;a<$objects.length;a++) {
    		$objects[a].$transform = Transformation.multipleTrans([$objects[a].$transform, $transform]);
    		$objects[a].$texture.$transform = Transformation.multipleTrans([$objects[a].$texture.$transform, $transform]);
    		$objects[a].initialize();
    	}
    	$transform = Transformation.$IdentityTrans.copy();

    	// find the intersection of the bounding boxes of all sub-objects with their volume contained by their bounding boxes
    	var v1:Vector, v2:Vector, nv1:Vector, nv2:Vector;
    	//var bounds;
    	var foundContainedObject:Boolean = false;
    	var anyBoundsInfinite:Boolean = false;

    	for (a=0;a<$objects.length;a++) {
    		if (!$objects[a].$infiniteBounds && !$objects[a].$volumeOutsideOfBounds) {
    			if (!foundContainedObject) {
    				v1 = $objects[a].$boundedBy.$v1.copy();
    				v2 = $objects[a].$boundedBy.$v2.copy();
    			}
    			else {
    				nv1 = $objects[a].$boundedBy.$v1;
    				nv2 = $objects[a].$boundedBy.$v2;
    				if (nv1.x>v1.x) v1.x = nv1.x;
    				if (nv1.y>v1.y) v1.y = nv1.y;
    				if (nv1.z>v1.z) v1.z = nv1.z;
    				if (nv2.x<v2.x) v2.x = nv2.x;
    				if (nv2.y<v2.y) v2.y = nv2.y;
    				if (nv2.z<v2.z) v2.z = nv2.z;
    			}
    			foundContainedObject = true;
    		}
    		else if ($objects[a].$infiniteBounds) anyBoundsInfinite = true;
    	}
    	$volumeOutsideOfBounds = false;
    	if (foundContainedObject) {
    	    // at least one object had its volume contained by its bounding box.
    		$boundedBy = new Box(v1, v2);
    	}
    	else if (anyBoundsInfinite) {
    	    // no objects had volume contained by their bounding boxes, and at least one had infinite bounds.
    		$infiniteBounds = true;
    	}
    	else {
    		// all of the objects have volume outside of their bounding boxes.
    		// so we take the smallest box enclosing all of them.
    		v1 = $objects[0].$boundedBy.$v1.copy();
    		v2 = $objects[0].$boundedBy.$v2.copy();
    		for (a=1;a<$objects.length;a++) {
    			nv1 = $objects[a].$boundedBy.$v1;
    			nv2 = $objects[a].$boundedBy.$v2;
    			if (nv1.x<v1.x) v1.x = nv1.x;
    			if (nv1.y<v1.y) v1.y = nv1.y;
    			if (nv1.z<v1.z) v1.z = nv1.z;
    			if (nv2.x>v2.x) v2.x = nv2.x;
    			if (nv2.y>v2.y) v2.y = nv2.y;
    			if (nv2.z>v2.z) v2.z = nv2.z;
    		}
    		$volumeOutsideOfBounds = true;
    	}
    	if (this.$inversed && !$infiniteBounds) {
    		$volumeOutsideOfBounds = true;
    		// it might be false (for instance, if this is the intersection of two inversed spheres, inversed),
    		// but we don't know for sure and it's safer to assume that it's true.
    		// I think the case where it's false is rare enough that it won't really matter.
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
    	var a:Number, b:Number, c:Number;

    	// take all the intersections of every object that occured within every other object.
    	for (a=0;a<$objects.length;a++) {
    		var thisObjectsIntersections:Array = $objects[a].findIntersections(ray);

    		for (b=0;b<thisObjectsIntersections.length;b++) {
    			for (c=0;c<$objects.length;c++) {
    				if (c!=a && !$objects[c].isPointInside(thisObjectsIntersections[b].getPos())) break;
    			}
    			if (c==$objects.length) {
    				thisObjectsIntersections[b].addObject(this);
    				toReturn[toReturn.length] = thisObjectsIntersections[b];
    			}
    		}
    	}
    	toReturn.sort(Intersection.closerIntersection);   // *** TODO

    	return toReturn;
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

    	for (a=0;a<$objects.length;a++) if (!$objects[a].isPointInside(pos)) return false;

    	return true;
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

