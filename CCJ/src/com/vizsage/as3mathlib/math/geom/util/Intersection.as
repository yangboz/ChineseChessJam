package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.Intersection
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Intersection Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty.
 * @usage       <pre>var inst:Intersection = new Intersection(depth, ray, obj);</pre>
 * @param       depth (Number)  -- a scalar value.
 * @param       ray (Ray)  -- a Ray object.
 * @param       obj (Object)  -- first object passed to stack.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.util.Ray
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
 *       Intersection(depth, ray, obj)
 *             1.  getPos()
 *             2.  addsObject(obj)
 *             3.  closerIntersection(i1, i2) - static
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
import com.vizsage.as3mathlib.math.geom.util.Ray;

public class Intersection  {
    /**
     * @property $depth (Number)  -- a scalar value.
     * @property $data (Number)  -- initialized to 'null'.
     * @property $ray (Ray)  -- passed Ray object.
     * @property $objectStack (Array)  -- a list of shape objects.
    **/
    public var $depth:Number;
    public var $data:Number;
    public var $ray:Ray;
    public var $objectStack:Array;

    // constructor
    public function Intersection(depth:Number, ray:Ray, obj:Object) {
        trace ("Intersection Class fired");
    	$depth = depth;
    	$data = NaN;
    	$ray = ray;
    	$objectStack = [obj]; // first element is the lowest level object; rest of elements are unions/intersections/etc
    }

      // 1. getPos -------------------------------------

    /**
     * @method  getPos
     * @description  Creates a new position Vector object by adding a scaled
     *               instance $dir Vector object to instance $start Vector object.
     * @usage  <pre>inst.addsObject(obj);</pre>
     * @return  (Vector)  -- returns a new Vector object.
    **/
    public function getPos():Vector {
    	return Vector.adder($ray.$start, Vector.scaler($ray.$dir, $depth));
    }

      // 2. addsObject ---------------------------------

    /**
     * @method  addsObject
     * @description  Appends passed 'obj' to end of stack.
     * @usage  <pre>inst.addsObject(obj);</pre>
     * @param   obj   (Object)  -- an Object object.
     * @return  (void)
    **/
    public function addsObject(obj:Object):void {
    	$objectStack[$objectStack.length] = obj;
    }

      // 3. closerIntersection -------------------------

    /**
     * @method  closerIntersection
     * @description  Static - intersection sorting used in shape class instance 'Array.sort' method.
     * @usage  <pre>classInstanceArray.sort(Intersection.closerIntersection);</pre>
     * @param   i1   (Intersection)  -- an Intersection object.
     * @param   i2   (Intersection)  -- an Intersection object.
     * @return  (Number)  -- returns the difference between Intersection object $depths.
    **/
    public static function closerIntersection(i1:Intersection, i2:Intersection):Number {
    	return i1.$depth - i2.$depth;
    }

}// class
}//package

