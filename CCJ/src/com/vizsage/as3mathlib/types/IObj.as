package com.vizsage.as3mathlib.types {
/**
 * @interface   com.vizsage.as3mathlib.types.IObj
 * @author      Richard Wright
 * @version     1.6
 * @description Defines the IObj interface for the Obj superclass and its
 *              subclasses, based on JS RayTracer2 by John Haggerty.
 *              <p>
 *              This is a list of the interface-dependent classes:
 *              <blockquote><pre>
 *              <a href="Obj_doc.html" target="_blank">com.vizsage.as3mathlib.types.Obj</a> - superclass
 *              <a href="Intersect3D_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.intersect3D.Intersect3D</a> - extends Obj
 *              <a href="Union_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.intersect3D.Union</a> - extends Obj
 *              <a href="Box_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.polytope.Box</a> - extends Obj
 *              <a href="Plane_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.polytope.Plane</a> - extends Obj
 *              <a href="Cone_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.quadric.Cone</a> - extends Obj
 *              <a href="Cylinder_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.quadric.Cylinder</a> - extends Obj
 *              <a href="Sphere_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.quadric.Sphere</a> - extends Obj
 *              <a href="Camera_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.util.Camera</a>
 *              <a href="Finish_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.util.Finish</a>
 *              <a href="Intersection_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.util.Intersection</a>
 *              <a href="LightSource_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.util.LightSource</a>
 *              <a href="Ray_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.util.Ray</a>
 *              <a href="Texture_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.util.Texture</a>
 *              <a href="Transformation_doc.html" target="_blank">com.vizsage.as3mathlib.math.geom.util.Transformation</a>
 *              </pre></blockquote>
 * @usage       Interface resides within the com.vizsage.as3mathlib.types package.
 * @param       No parameters for interface constructs.
 * -----------------------------------------------
 * Latest update: July 27, 2004
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
 * Interface Methods:
 *             1.  copy()
 *             2.  initialize()
 *             3.  findIntersectionsUntransformed(ray)
 *             4.  isPointInsideUntransformed(pos)
 *             5.  getNormalAtUntransformed(pos)
 * Dependent Class Methods:
 *       Obj(arguments)
 *             1.  getColorAt(isect, objs, lights, traceLevel, effect)
 *             2.  numericalOrder(a, b)
 *             3.  correctBounds()
 *             4.  generalLowLevelObjectInitialization()
 *             5.  findBoundInts(v1, v2, dim, odim1, odim2, s, d)
 *             6.  boundTest(ray)
 *             7.  boundTestPoint(pos)
 *             8.  findIntersections(ray)
 *             9.  getNormalAt(pos, isect)
 *             10. isPointInside(pos)
 *             11. setupDefaultModifiers()
 *             12. copyModifiers(newObj)
 *             13-17. interface methods
 *       Box(v1, v2, isBound)
 *             1-5. interface methods
 *             6.  isPointInsideUntransformed(pos)
 *             7.  getNormalAtUntransformed(pos)
 * All the dependent classes below only employ the 5 interface methods:
 *       Plane(normal, dist)
 *       Cone(end1, rad1, end2, rad2, open)
 *       Cylinder(end1, end2, rad, open)
 *       Sphere(pos, rad)
 *       Union(objects)
 *       Intersect3D(objects)
 *             1-5. interface methods
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: The IObj interface is under construction ... it presently loads
 *       without error, but the testing environment is incomplete, and
 *       method inheritance has yet to be refined. There might be traces
 *       and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.types.Obj;

public interface IObj  {

	// 1. copy() ------------------------------------------

    /**
     * @method  copy
     * @description  Copies super's properties with its 'copyModifiers' method.
     * @usage  <pre>
     *         var instObj:instObjClass = new instObjClass(arguments);
     *         instObj.copy();
     *         // which overides the super's copy() method and calls its super
     *         // with a unique set of arguments for the method:
     *         this.copyModifiers(newObj);
     *         </pre>
     * @param   none   (void) -- no method parameters.
     * @return  (Obj)  -- returns a copy of the superclass properties.
    **/
    function copy():Obj;

	// 2. initialize --------------------------------------

     /**
      * @method  initialize
      * @description  Initializes a bounding box construct and all low-level
      *               instantiation for the instObj.
      * @usage  <pre>
      *         var instObj:instObjClass = new instObjClass();
      *         // which in turn fires the 'instObj.initialize' method
      *         </pre>
      * @param   none   (void)  -- no method parameters.
      * @return  (void)
     **/
     function initialize():void;

      // 3. findIntersectionsUntransformed ------------------

    /**
     * @method  findIntersectionsUntransformed
     * @description  Defines bounding box vertices in 3-space.
     * @usage  <pre>
     *         var instObj:instObjClass = new instObjClass();
     *         instObj.findIntersectionsUntransformed();
     *         </pre>
     * @param   ray   (Ray)  -- tracer object that defines point and direction in 3-space.
     * @return  (Array)  -- returns a list of Intersection objects, or an empty list.
    **/
    function findIntersectionsUntransformed(ray:Ray):Array;

      // 4. isPointInsideUntransformed ----------------------

    /**
     * @method  isPointInsideUntransformed
     * @description Tests bounding box and vector for union.
     * @usage  <pre>
     *         var instObj:instObjClass = new instObjClass();
     *         instObj.isPointInsideUntransformed(pos)
     *         </pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Boolean)
    **/
    function isPointInsideUntransformed(pos:Vector):Boolean;

      // 5. getNormalAtUntransformed ------------------------

    /**
     * @method  getNormalAtUntransformed
     * @description Defines bounding box to vector normal in 3-space before transformation.
     * @usage  <pre>
     *         var instObj:instObjClass = new instObjClass();
     *         instObj.getNormalAtUntransformed(pos);
     *         </pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Vector)  -- returns normal of untransformed vector.
    **/
    function getNormalAtUntransformed(pos:Vector):Vector;

}// class
}//package