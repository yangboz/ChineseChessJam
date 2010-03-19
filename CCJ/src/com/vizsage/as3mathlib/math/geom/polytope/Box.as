package com.vizsage.as3mathlib.math.geom.polytope {
/**
 * @class       com.vizsage.as3mathlib.math.geom.polytope.Box
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Box Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty.
 * @usage       <pre>var inst:Box = new Box(v1, v2, isBound);</pre>
 * @param       v1 (Vector)  -- a position Vector object defining one corner of the box.
 * @param       v2 (Vector)  -- a position Vector object defining the opposite corner of the box.
 * @param       isBound (Boolean)  -- if 'true', leaves dimensions as is, else inverses dimensions.
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
 *       Box(v1, v2, isBound)
 *             1.  copy()
 *             2.  initialize()
 *             3.  findIntersectionsUntransformed(ray)
 *             4.  isPointInsideUntransformed(pos)
 *             5.  getNormalAtUntransformed(pos)
 *             6.  init(v1, v2, isBound)
 *             7.  findInts(ints, v1, v2, dim, odim1, odim2, s, d)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
 * NOTE: This Obj subclass is under construction ... it presently loads
 *       without error, but the testing environment is incomplete, and
 *       method inheritance has yet to be refined. There may be traces
 *       and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.types.IObj;
import com.vizsage.as3mathlib.types.Obj;

public class Box extends Obj implements IObj {
	/**
	 * @property $v1 (Vector)  -- a position Vector object defining one corner of the box.
	 * @property $v2 (Vector)  -- a position Vector object defining the opposite corner of the box.
	 * @property $dimsInv (Vector)  -- if 'isBound' is 'true', an identity Vector object, else adds $v2 to the inverse of the negative of $v1.
	 * @property $negV1 (Vector)  -- a position Vector object defining negative of $v1.
	 * @property $boundedBy (Box)  -- a bounding box object.
	**/
    public var $v1:Vector;
    public var $v2:Vector;
    public var $dimsInv:Vector;
    public var $negV1:Vector;

    // constructor
    public function Box(v1:Vector, v2:Vector, isBound:Boolean=false) {
        trace ("Box Class loaded .. super.$boundedBy: " + super.$boundedBy);
        //if (!super.$boundedBy && arguments.length>0) this.init(arguments);
        init(v1, v2, isBound);
    }

      // 1. copy ---------------------------------------

    /**
     * @method  copy
     * @description  Copies super's properties with its 'copyModifiers' method.
     * @usage  <pre>inst.copy();</pre>
     * @return  (Obj)  -- returns a new Sphere object populated with super's properties.
    **/
    override public function copy():Obj {
	    return this.copyModifiers(new Box($v1.copy(), $v2.copy()));
    }

      // 2. initialize ---------------------------------

    /**
     * @method  initialize
     * @description  Initializes this instance's bounding box and its super's low-level properties,
     *               and defines $negV1 property.
     * @usage  <pre>inst.initialize();</pre>
     * @return  (void)
    **/
    override public function initialize():void {
	    $boundedBy = new Box($v1.copy(), $v2.copy(), true);
	    $negV1 = Vector.neg($v1);
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
	    var ints:Array = [];
	    var a:Number;

	    Box.findInts(ints, $v1, $v2, "x", "y", "z", ray.$start, ray.$dir);
	    Box.findInts(ints, $v1, $v2, "x", "y", "z", ray.$start, ray.$dir);
	    Box.findInts(ints, $v1, $v2, "x", "y", "z", ray.$start, ray.$dir);

	    ints.sort(Obj.numericalOrder);
	    if (ints.length>1 && ints[1]<ints[0]) {
		    var temp:Intersection = ints[1];
		    ints[1] = ints[0];
		    ints[0] = temp;
	    }
	    for (a=0;a<ints.length;a++) ints[a] = new Intersection(ints[a], ray, this);

	    return ints;
    }

      // 4. isPointInsideUntransformed ----------------

    /**
     * @method  isPointInsideUntransformed
     * @description  Tests whether passed 'pos' Vector object is inside this instance.
     * @usage  <pre>inst.isPointInsideUntransformed(pos);</pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Boolean)
    **/
    override public function isPointInsideUntransformed(pos:Vector):Boolean {
	    return (pos.x>=$v1.x && pos.x<=$v2.x && pos.y>=$v1.y && pos.y<=$v2.y && pos.z>=$v1.z && pos.z<=$v2.z);
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
	    var simpleBoxPos:Vector = Vector.adder(Vector.mult(Vector.adder(pos, $negV1), $dimsInv), new Vector(-.5, -.5, -.5));
	    var absSimpleBoxPos:Vector = new Vector(Math.abs(simpleBoxPos.x), Math.abs(simpleBoxPos.y), Math.abs(simpleBoxPos.z));

	    if (absSimpleBoxPos.x>absSimpleBoxPos.y && absSimpleBoxPos.x>absSimpleBoxPos.z) {
	    	return new Vector(simpleBoxPos.x, 0, 0);
	    }
	    else if (absSimpleBoxPos.y>absSimpleBoxPos.x && absSimpleBoxPos.y>absSimpleBoxPos.z) {
	    	return new Vector(0, simpleBoxPos.y, 0);
	    }
	    else {
	    	return new Vector(0, 0, simpleBoxPos.z);
	    }

	    // commented-out in JS original
	    //if (Math.abs($v1.x-pos.x)<Ray.$ACCURACY) return Vector.neg(Vector.XX);
	    //if (Math.abs($v2.x-pos.x)<Ray.$ACCURACY) return Vector.XX;
	    //if (Math.abs($v1.y-pos.y)<Ray.$ACCURACY) return Vector.neg(Vector.YY);
	    //if (Math.abs($v2.y-pos.y)<Ray.$ACCURACY) return Vector.YY;
	    //if (Math.abs($v1.z-pos.z)<Ray.$ACCURACY) return Vector.neg(Vector.ZZ);

	    return Vector.ZZ;
    }

      // 6. init ---------------------------------------

    /**
     * @method  init
     * @description  Initializes class instance properties beyond its super's properties.
     * @usage  <pre>inst.init(v1, v2, isBound);</pre>
     * @param   v1   (Vector)  -- a direction Vector object.
     * @param   v2   (Vector)  -- a direction Vector object.
     * @param   isBound   (Boolean)  -- if 'true', leaves dimensions as is, else inverses dimensions.
     * @return  (void)
    **/
    private function init(v1:Vector, v2:Vector, isBound:Boolean):void {
        var temp:Number;

	    $v1 = v1;
	    $v2 = v2;
	    if ($v1.x>$v2.x) {
	    	temp = $v1.x;
	    	$v1.x = $v2.x;
	    	$v2.x = temp;
	    }
	    if ($v1.y>$v2.y) {
		    temp = $v1.y;
		    $v1.y = $v2.y;
		    $v2.y = temp;
	    }
	    if ($v1.z>$v2.z) {
		    temp = $v1.z;
		    $v1.z = $v2.z;
		    $v2.z = temp;
	    }
	    if (! isBound) {
		    $dimsInv = Vector.adder($v2, Vector.neg($v1)).inv();
		    this.setupDefaultModifiers();
	    }
    }

      // 7. findInts -----------------------------------

    /**
     * @method  findInts
     * @description  Defines all six intersections of the box.
     * @usage  <pre>inst.findInts(ints, v1, v2, dim, odim1, odim2, s, d);</pre>
     * @param   ints   (Array)  -- a holder for Intersection objects.
     * @param   v1   (Vector)  -- a direction Vector object.
     * @param   v2   (Vector)  -- a direction Vector object.
     * @param   dim   (String)  -- ths string 'x'.
     * @param   odim1   (String)  -- ths string 'y'.
     * @param   odim2   (String)  -- ths string 'z'.
     * @param   s   (Vector)  -- ray start Vector object.
     * @param   d   (Vector)  -- ray direction Vector object.
     * @return  (void)
    **/
    public static function findInts(ints:Array, v1:Vector, v2:Vector, dim:String, odim1:String, odim2:String, s:Vector, d:Vector):void {
	    if (d[dim]==0) return;
	    var int1:Number = (v1[dim]-s[dim])/d[dim];
	    var int2:Number = (v2[dim]-s[dim])/d[dim];
	    var intPoint1:Vector = Vector.adder(s, Vector.scaler(d, int1));
	    var intPoint2:Vector = Vector.adder(s, Vector.scaler(d, int2));
	    if (intPoint1[odim1]>=v1[odim1] && intPoint1[odim1]<v2[odim1] && intPoint1[odim2]>=v1[odim2] && intPoint1[odim2]<v2[odim2]) {
	    	ints[ints.length] = int1;
	    }
	    if (intPoint2[odim1]>=v1[odim1] && intPoint2[odim1]<v2[odim1] && intPoint2[odim2]>=v1[odim2] && intPoint2[odim2]<v2[odim2]) {
	    	ints[ints.length] = int2;
	    }
    }

}// class
}//package

