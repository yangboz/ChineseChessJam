package com.vizsage.as3mathlib.math.geom.intersect3D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect3D.Intersect3DRay
 * @author      Richard Wright [wisolutions2002@shaw.ca]
 * @version     1.8
 * @description Implements the behaviours of the Intersect3DRay Class.
 *              <p>
 *		This is a collection of 3-space intersection algorithms that will
 *              provide intersection checks for the IObj interface shape objects.
 *              Presently, there is no method interaction coded.
 * @usage       <pre>var inst:Intersect3DRay = new Intersect3DRay(objects);</pre>
 * @param       objects (Array)  -- a list of shape objects.
 * -----------------------------------------------
 * Latest update: July 8, 2005
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Point
 *                com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.num.Format
 *                com.vizsage.as3mathlib.math.geom.polytope.Plane
 * -----------------------------------------------
 * AS2 revision copyright: � 2003, Richard Wright [wisolutions2002@shaw.ca]
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
 *       Intersect3DRay()
 *           1.  findRoots(a, b, c, t0, t1)
 *           2.  raySphere(O, D, B, L, r, t0, t1)
 *           3.  rayInfiniteCylinder(O, D, C, r, t0, t1)
 *           4.  rayCylinderCaps(O, D, B, L, ll, t0, t1)
 *           5.  rayCappedCylinder(O, D, B, L, ll, t0, t1)
 *           6.  rayCapsule(O, D, B, L, ll, t0, t1, tMax)
 *           7.  rayTriangle(p1, p2, pa, pb, pc, p, p1, p2, pa, pb, pc, p)
 *           8.  rayCvxPolyhedron(org, dir, tmax, phdrn, phNum, tresult, norm)
 *           9.  rayBox(minB, maxB, origin, dir, coord)
 *           10. rayRay(p1, p2, p3, p4, pa, pb, mua, mub, bSeg)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * oliii
 * referral: http://www.gamedev.net/community/forums/topic.asp?topic_id=176993
 * -----------------------------------------------
 * NOTE: This class is under construction .. it presently loads without
 *       error, but the testing environment is incomplete. There are
 *       traces and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.num.Format;
import com.vizsage.as3mathlib.math.geom.polytope.Plane;

public class Intersect3DRay  {
	/**
	 * @property none  -- no class properties.
	**/
    public function Intersect3DRay() {
        //trace ("Intersect3DRay Class loaded");
    }

      // 1. findRoots ----------------------------------

    /**
     * @method  findRoots
     * @description  Solves a second order equation, find the two roots. If there
     *               is no solution, return false. Sort the solutions as well.
     * @usage  <pre>inst.findRoots(a, b, c, t0, t1);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @param   c   (Number)  -- a real number.
     * @param   t0   (Number)  -- a real number pointer for return assignment.
     * @param   t1   (Number)  -- a real number pointer for return assignment.
     * @return  (Boolean)
    **/
    public function findRoots(a:Number, b:Number, c:Number, t0:Number, t1:Number):Boolean {
        trace ("^^^Intersect3DRay findRoots fired^^^");

        var d:Number = b*b-4*a*c;

        if (d<0.0) return false;
        d = Math.sqrt(d);
        t0 = (-b-d)/(2*a);
        t1 = (-b+d)/(2*a);
        trace ("$$ Intersect3DRay findRoots $$ 1. a: "+a+", b: "+b+", c: "+c+", d: "+d);
        trace ("$$ Intersect3DRay findRoots $$ 2. t0: "+t0+"::"+((-b-d)/(2*a))+", t1: "+t1+"::"+((-b+d)/(2*a)));
        if (t0>t1) {
            var t:Number = t0;
            t0 = t1;
            t1 = t;
        }
        trace ("**************");
        trace ("$$ Intersect3DRay findRoots $$ 3. t0: "+t0+", t1: "+t1);
        trace ("**************");

        //return [t0, t1];
        return true;
    }

      // 2. raySphere ----------------------------------

    /**
     * @method  raySphere
     * @description  Solving the equation will give two solutions, t0 and t1,
     *               the times where the ray intersects the sphere
     *               <blockquote><pre>
     *               Sphere (centre=C, radius=r)
     *               Ray (start=O, direction=D)
     *               Point P is on sphere if [eq1] (P - C)^2 = r^2
     *               Point on ray verifies [eq2] P = O + D.t
     *               Substitute [eq2] to (P) in [eq1]
     *               => (O + D.t - C)^2 = r^2
     *               => ((O - C) + D.t)^2 - r^2 = 0
     *               => [(O-C)^2 - r^2] + [2 * (O-C).D].t + [D.D].t^2 = 0
     *               => second order equation in the form a.t^2 + b.t + c = 0
     *               where a = (D.D)
     *                     b = 2.0 * (O-C).D
     *                     c = (O-C)^2 - r^2
     *               </pre></blockquote>
     * @usage  <pre>inst.raySphere(O, D, C, r, t0, t1);</pre>
     * @param   O   (Vector)  -- a position Vector object.
     * @param   D   (Vector)  -- a direction Vector object.
     * @param   C   (Vector)  -- a position Vector object.
     * @param   r   (Number)  -- a real nmuber for radius of Sphere object.
     * @param   t0   (Number)  -- a real number pointer for return assignment.
     * @param   t1   (Number)  -- a real number pointer for return assignment.
     * @return  (Boolean)
    **/
    public function raySphere(O:Vector, D:Vector, C:Vector, r:Number, t0:Number, t1:Number):Boolean {
        trace ("^^^Intersect3DRay raySphere fired^^^");

        var OmC:Vector = O.returnSubtraction(C);
        var a:Number = Vector.dot(D,   D);
        var b:Number = Vector.dot(OmC, D)   * 2.0;
        var c:Number = Vector.dot(OmC, OmC) - r*r;

        trace ("$$ Intersect3DRay raySphere $$ 1. OmC: "+OmC+", a: "+a+", b: "+b+", c: "+c+", t0: "+t0+", t1: "+t1);

        return findRoots(a, b, c, t0, t1);
    }

      // 3. rayInfiniteCylinder ------------------------

    /**
     * @method  rayInfiniteCylinder
     * @description  Solving the equation will give two solutions, t0 and t1,
     *               the times where the ray intersects the sphere
     *               <blockquote><pre>
     *               Cylinder (base=B, direction=L, radius=r)
     *               Ray (start=O, direction=D)
     *               Point P is on cylinder if [eq1] [(P - B) x L]^2 = r^2
     *               Point on ray verifies [eq2] P = O + D.t
     *               Substitute [eq2] to (P) in [eq1]
     *               => ((O + D.t - B) x L)^2 = r^2
     *               => ((O - B)xL + (DxL).t)^2 - r^2 = 0
     *               => [((O-B)xL)^2 - r^2] + [2 * ((O-B)xL).(DxL)].t + [(DxL)^2].t^2 = 0
     *               => second order equation in the form a.t^2 + b.t + c = 0
     *               where a = (DxL)^2
     *                     b = 2.0 * ((O-B)xL).(DxL)
     *                     c = ((O-B)xL)^2 - r^2
     *               </pre></blockquote>
     * @usage  <pre>inst.rayInfiniteCylinder(O, D, B, L, r, t0, t1);</pre>
     * @param   O   (Vector)  -- a position Vector object.
     * @param   D   (Vector)  -- a direction Vector object.
     * @param   B   (Vector)  -- a position Vector object.
     * @param   L   (Vector)  -- a direction Vector object.
     * @param   r   (Number)  -- a real number for radius of Cylinder object.
     * @param   t0   (Number)  -- a real number pointer for return assignment.
     * @param   t1   (Number)  -- a real number pointer for return assignment.
     * @return  (Boolean)
    **/
    public function rayInfiniteCylinder(O:Vector, D:Vector, B:Vector, L:Vector, r:Number, t0:Number, t1:Number):Boolean {
        trace ("^^^Intersect3DRay rayInfiniteCylinder fired^^^");

        var OmB:Vector = O.returnSubtraction(B);
        var OmBcL:Vector = Vector.cross(OmB, L);
        var DcL:Vector = Vector.cross(D, L);
        var a:Number = Vector.dot(DcL, DcL);
        var b:Number = 2.0*Vector.dot(OmBcL, DcL);
        var c:Number = Vector.dot(OmBcL, OmBcL)-r*r;

        trace ("$$ Intersect3DRay rayInfiniteCylinder $$ 1. OmB: "+OmB+", OmBcL: "+OmBcL+", DcL: "+DcL+", a: "+a+", b: "+b+", c: "+c+", t0: "+t0+", t1: "+t1);

        return findRoots(a, b, c, t0, t1);
    }

      // 4. rayCylinderCaps ----------------------------

    /**
     * @method  rayCylinderCaps
     * @description  Find intersections between a ray and the caps of a cylinder
     * @usage  <pre>inst.rayCylinderCaps(O, D, B, L, ll, t0, t1);</pre>
     * @param   O   (Vector)  -- a position Vector object.
     * @param   D   (Vector)  -- a direction Vector object.
     * @param   B   (Vector)  -- a position Vector object.
     * @param   L   (Vector)  -- a direction Vector object.
     * @param   ll   (Number)  -- a real number for cylinder axis length.
     * @param   t0   (Number)  -- a real number pointer for return assignment.
     * @param   t1   (Number)  -- a real number pointer for return assignment.
     * @return  (Boolean)
    **/
    public function rayCylinderCaps(O:Vector, D:Vector, B:Vector, L:Vector, ll:Number, t0:Number, t1:Number):Boolean {
        trace ("^^^Intersect3DRay rayCylinderCaps fired^^^");

        var DdL:Number = Vector.dot(D, L);
        var tLow:Number = 0; // kludge .. not included in original file

        trace ("$$ Intersect3DRay rayCylinderCaps $$ DdL: "+DdL);
        if (Math.abs(DdL)<0.0000001) {
            t0 = Number.MIN_VALUE;
            t1 = Number.MAX_VALUE;

            return true;
        }

        var BmOdL:Number = Vector.dot(B.returnSubtraction(O), L);

        trace ("$$ Intersect3DRay rayCylinderCaps $$ BmOdL: "+BmOdL);
        t0 = BmOdL/DdL;
        t1 = tLow+(ll/DdL);                                    // *** TODO
        trace ("$$ Intersect3DRay rayCylinderCaps $$ t0: "+t0+", t1: "+t1);
        if (t0>t1) {
            var t:Number = t0;

            t0 = t1;
            t1 = t;
        }

        return true;
    }

      // 5. rayCappedCylinder --------------------------

    /**
     * @method  rayCappedCylinder
     * @description  Calculate the intersection points of a ray and a capped cylinder
     * @usage  <pre>inst.rayCappedCylinder(O, D, B, L, ll, r, t0, t1);</pre>
     * @param   O   (Vector)  -- a position Vector object.
     * @param   D   (Vector)  -- a direction Vector object.
     * @param   B   (Vector)  -- a position Vector object.
     * @param   L   (Vector)  -- a direction Vector object.
     * @param   ll   (Number)  -- a real number for cylinder axis length between caps.
     * @param   r   (Number)  -- a real number for radius of Cylinder object.
     * @param   t0   (Number)  -- a real number pointer for return assignment.
     * @param   t1   (Number)  -- a real number pointer for return assignment.
     * @return  (Boolean)
    **/
    public function rayCappedCylinder(O:Vector, D:Vector, B:Vector, L:Vector, ll:Number, r:Number, t0:Number, t1:Number):Boolean {
        trace ("^^^Intersect3DRay rayCappedCylinder fired^^^");

        var tCap0:Number;
        var tCap1:Number;
        var tCyl0:Number;
        var tCyl1:Number;

        if (!rayInfiniteCylinder(O, D, B, L, r, tCyl0, tCyl1)) return false;
        if (!rayCylinderCaps(O, D, B, L, ll, tCap0, tCap1)) return false;
        // the ray missed the cylinder
        if (tCap0>tCyl1 || tCap1<tCyl0)	return false;
        t0 = Math.max(tCap0, tCyl0);
        t1 = Math.min(tCap1, tCyl1);
        trace ("$$ Intersect3DRay rayCappedCylinder $$ 1. tCap0: "+tCap0+", tCap1: "+tCap1+", tCyl0: "+tCyl0+", tCyl1: "+tCyl1+", t0: "+t0+", t1: "+t1);

        return true;
    }

      // 6. rayCapsule ---------------------------------

    /**
     * @method  rayCapsule
     * @description  A capsule is basically a cylinder with rounded caps of radius
     *               equal to the radius of the cylinder. Doing a ray-capsule test
     *               can be broken down to doing two ray-sphere tests and one
     *               ray-capped_cylinder test.
     * @usage  <pre>inst.rayCapsule(O, D, B, L, ll, r, t0, t1, tMax);</pre>
     * @param   O   (Vector)  -- a position Vector object.
     * @param   D   (Vector)  -- a direction Vector object.
     * @param   B   (Vector)  -- a position Vector object.
     * @param   L   (Vector)  -- a direction Vector object.
     * @param   ll   (Number)  -- a real number for cylinder axis length between rounded caps.
     * @param   r   (Number)  -- a real number for radius of cylinder and caps.
     * @param   t0   (Number)  -- a real number pointer for return assignment.
     * @param   t1   (Number)  -- a real number pointer for return assignment.
     * @param   tMax   (Number)   --
     * @return  (Boolean)
    **/
    public function rayCapsule(O:Vector, D:Vector, B:Vector, L:Vector,
                        ll:Number, r:Number, t0:Number, t1:Number, tMax:Number):Boolean {
        trace ("^^^Intersect3DRay rayCapsule fired^^^");

        var tMinS0:Number, tMaxS0:Number, tMinS1:Number, tMaxS1:Number, tMinC:Number, tMaxC:Number;
        var intersectS0:Boolean  = raySphere(O, D, B, r, tMinS0, tMaxS0);
        var intersectS1:Boolean  = raySphere(O, D, B, r, tMinS1, tMaxS1);
        var intersectCyl:Boolean = rayCappedCylinder(O, D, B, L, ll, r, tMinC, tMaxC);

        if (!(intersectS0 || intersectS1 || intersectCyl)) return false;
        t0 = Number.MIN_VALUE;
        t1 = Number.MAX_VALUE;
        if (intersectCyl) {
            t0 = Math.min(t0, tMinC);
            t1 = Math.max(t1, tMaxC);
        }
        if (intersectS0) {
            t0 = Math.min(t0, tMinS0);
            t1 = Math.max(t1, tMaxS0);
        }
        if (intersectS1) {
            t0 = Math.min(t0, tMinS1);
            t1 = Math.max(t1, tMaxS1);
        }

        trace ("$$ Intersect3DRay rayCapsule $$ 1. tMinS0: "+tMinS0+", tMaxS0: "+tMaxS0+", tMinS1: "+tMinS1+", tMaxS1: "+tMaxS1+", tMinC: "+tMinC+", tMaxC: "+tMaxC+", t0: "+t0+", t1: "+t1);
        if (t1<0.0 || t0>tMax)	return false;

        return true;
    }

      // 7. rayTriangle --------------------------------

    /**
     * @method  rayTriangle
     * @description  Determine whether or not the line segment p1, p2
     *               Intersects the 3 vertex facet bounded by pa, pb, pc
     *               Return true/false and the intersection point p
     *               <p>
     *               The equation of the line is:
     *               <blockquote><pre>
     *               p = p1 + mu (p2 - p1)
     *               </pre></blockquote>
     *               The equation of the plane is:
     *               <blockquote><pre>
     *               a x + b y + c z + d = 0
     *               n.x x + n.y y + n.z z + d = 0
     *               </pre></blockquote>
     * @usage  <pre>inst.rayTriangle(p1, p2, pa, pb, pc, p);</pre>
     * @param   p1   (Vector)  -- a position Vector object for start of Ray object.
     * @param   p2   (Vector)  -- a position Vector object for end of Ray object.
     * @param   pa   (Vector)  -- a position Vector object for vertex 'a' of Triangle object.
     * @param   pb   (Vector)  -- a position Vector object for vertex 'b' of Triangle object.
     * @param   pc   (Vector)  -- a position Vector object for vertex 'c' of Triangle object.
     * @param   p   (Point)  -- a pointer for Point object return.
     * @return  (Boolean)
    **/
    public function rayTriangle(p1:Vector, p2:Vector, pa:Vector, pb:Vector, pc:Vector, p:Point):Boolean {
        trace ("^^^Intersect3DRay rayTriangle fired^^^");

        var d:Number, a1:Number, a2:Number, a3:Number;
        var total:Number, denom:Number, mu:Number;
        var n:Vector, pa1:Vector, pa2:Vector, pa3:Vector;

        // Calculate the parameters for the plane
        n.x = (pb.y-pa.y)*(pc.z-pa.z)-(pb.z-pa.z)*(pc.y-pa.y);
        n.y = (pb.z-pa.z)*(pc.x-pa.x)-(pb.x-pa.x)*(pc.z-pa.z);
        n.z = (pb.x-pa.x)*(pc.y-pa.y)-(pb.y-pa.y)*(pc.x-pa.x);
        n.normalize();
        d = -n.x*pa.x-n.y*pa.y-n.z*pa.z;

        // Calculate the position on the line that intersects the plane
        denom = n.x*(p2.x-p1.x)+n.y*(p2.y-p1.y)+n.z*(p2.z-p1.z);

        // Line and plane don't intersect
        if (Math.abs(denom)<Format.dbleEpsilon()) return false;
        mu = -(d+n.x*p1.x+n.y*p1.y+n.z*p1.z)/denom;

        // Capture point p to global for further use outside function
        p.x = p1.x+ mu*(p2.x-p1.x);
        p.y = p1.y+ mu*(p2.y-p1.y);
        p.z = p1.z+ mu*(p2.z-p1.z);

        // Intersection not along line segment
        if (mu<0 || mu>1) return false;

        // Determine whether or not the intersection point is bounded by pa, pb, pc
        pa1.x = pa.x-p.x;
        pa1.y = pa.y-p.y;
        pa1.z = pa.z-p.z;
        pa1.normalize();
        pa2.x = pb.x-p.x;
        pa2.y = pb.y-p.y;
        pa2.z = pb.z-p.z;
        pa2.normalize();
        pa3.x = pc.x-p.x;
        pa3.y = pc.y-p.y;
        pa3.z = pc.z-p.z;
        pa3.normalize();
        a1 = pa1.x*pa2.x+pa1.y*pa2.y+pa1.z*pa2.z;
        a2 = pa2.x*pa3.x+pa2.y*pa3.y+pa2.z*pa3.z;
        a3 = pa3.x*pa1.x+pa3.y*pa1.y+pa3.z*pa1.z;
        total = (Math.acos(a1)+Math.acos(a2)+Math.acos(a3))*(180/Math.PI);
        if (Math.abs(total-360)>Format.dbleEpsilon()) return false;

        return true;
        // Capture point p to global for further use outside function
    }

      // 8. rayCvxPolyhedron ---------------------------

    /**
     * @method  rayCvxPolyhedron
     * @description  Ray-Convex Polyhedron Intersection Test by Eric Haines, erich AT eye DOT com<br>
     *               ref: http://www.acm.org/tog/GraphicsGems/gemsii/RayCPhdron.c
     *               <p>
     *               This test checks the ray against each face of a polyhedron,
     *               checking whether the set of intersection points found for each
     *               ray-plane intersection overlaps the previous intersection
     *               results.  If there is no overlap (i.e. no line segment along
     *               the ray that is inside the polyhedron), then the ray misses and
     *               returns 0; else 1 is returned if the ray is entering the
     *               polyhedron, -1 if the ray originates inside the polyhedron.
     *               If there is an intersection, the distance and the normal of the
     *               face hit is returned.
     * @usage  <pre>inst.rayCvxPolyhedron(org, dir, tmax, phdrn_arr, phNum, tresult, norm);</pre>
     * @param   org   (Vector)  -- a position Vector object.
     * @param   dir   (Vector)  -- a direction Vector object.
     * @param   tmax   (Number)  -- a real number for maximum distance.
     * @param   phdrn_arr   (Array)  -- a list of polyhedron planes.
     * @param   phNum   (Number)  -- a positive integer for array size.
     * @param   tresult   (Number)  --  a real number for distance to the plane result.
     * @param   norm   (Vector)  -- normal Vector object of the focus plane.
     * @return  (Number)  -- returns -1, 0, or 1.
    **/
    public function rayCvxPolyhedron(org:Vector, dir:Vector, tmax:Number, phdrn_arr:Array, phNum:Number, tresult:Number, norm:Vector):Number {
        var pln:Plane = new Plane(norm, tmax);
        // large number constant
        var HUGE_VAL:Number = 1.7976931348623157e+308;
        // return codes
        var MISSED:Number = 0;
        var FRONTFACE:Number = 1;
        var BACKFACE:Number = -1;

        var tnear:Number, tfar:Number, t:Number, vn:Number, vd:Number;
		var fnormNum:Number;    // front face # hit
		var bnormNum:Number;	// back face # hit

	tnear = -HUGE_VAL;
	tfar = tmax;

	// Test each plane in polyhedron
	for (;pln=phdrn_arr[phNum-1];phNum--) {
            // Compute intersection point T and sidedness
	    vd = DOT3(dir, pln.$norm);
	    vn = DOT3(org, pln.$norm)+pln.$dist;
	    if (vd==0.0) {
		// ray is parallel to plane - check if ray origin is inside plane's half-space
		if (vn>0.0) {
		    // ray origin is outside half-space
		    return MISSED;
		}
	    }
	    else {
	        // ray not parallel - get distance to plane
	        t = -vn/vd;
	        if (vd<0.0) {
		    // front face - T is a near point
		    if (t>tfar) return MISSED;
		    if (t>tnear) {
			// hit near face, update normal
			fnormNum = phNum;
			tnear = t;
		    }
		}
		else {
		    // back face - t is a far point
		    if (t<tnear) return MISSED;
		    if (t<tfar) {
	            // hit far face, update normal
		    bnormNum = phNum;
		    tfar = t;
	            }
	        }
	    }
        }

	// survived all tests
	// Note: if ray originates on polyhedron, may want to change 0.0 to some
	// epsilon to avoid intersecting the originating face.
	if (tnear>=0.0) {
	    // outside, hitting front face
	    norm = phdrn_arr[fnormNum].$norm;
	    tresult = tnear;

	    return FRONTFACE;
	}
	else {
            if (tfar<tmax) {
	        // inside, hitting back face
		norm = phdrn_arr[bnormNum].$norm;
		tresult = tfar;

		return BACKFACE;
	    }
	    else {
		// inside, but back face beyond tmax
		return MISSED;
	    }
	}
    }

      // 9. rayBox -------------------------------------

    /**
     * @method  rayBox
     * @description  Fast Ray-Box Intersection by Andrew Woo from 'Graphics Gems',
     *               Academic Press, 1990.
     *               Reference: <a href='http://www.acm.org/tog/GraphicsGems/gems/RayBox.c'>GraphicsGems: RayBox.c</a>
     * @usage  <pre>inst.rayBox(minB, maxB, origin, dir, coord);</pre>
     * @param   minB_arr   (Array)  -- a list of minimum box values.
     * @param   maxB_arr   (Array)  -- a list of maximum box values.
     * @param   origin_arr   (Array)  -- a list of origin ray values.
     * @param   dir_arr   (Array)  -- a list of direction ray values.
     * @param   coord_arr   (Array)  -- a list to hold hit values.
     * @return  (Boolean)
    **/
    public function rayBox(minB_arr:Array, maxB_arr:Array, origin_arr:Array, dir_arr:Array, coord_arr:Array):Boolean {
        var NUMDIM:Number = 3;
        var RIGHT:Number = 0;
        var LEFT:Number = 1;
        var MIDDLE:Number = 2;
        var inside:Boolean = true;
        var quadrant:Array = new Array(NUMDIM);
        var i:Number;
        var whichPlane:Number;
        var maxT:Array = new Array(NUMDIM);
        var candidatePlane:Array = new Array(NUMDIM);

        // Find candidate planes; this loop can be avoided if
        // rays cast all from the eye(assume perspective view)
        for (i=0;i<NUMDIM;i++) {
	    if(origin_arr[i]<minB_arr[i]) {
		quadrant[i] = LEFT;
		candidatePlane[i] = minB_arr[i];
		inside = false;
	    }
	    else if (origin_arr[i]>maxB_arr[i]) {
		quadrant[i] = RIGHT;
		candidatePlane[i] = maxB_arr[i];
		inside = false;
	    }
	    else {
		quadrant[i] = MIDDLE;
	    }
	}

	// Ray origin inside bounding box
	if (inside) {
	    coord_arr = origin_arr;

	    return true;
	}


	// Calculate T distances to candidate planes
	for (i=0;i<NUMDIM;i++) {
	    if (quadrant[i]!=MIDDLE && dir_arr[i]!=0.0) {
		maxT[i] = (candidatePlane[i]-origin_arr[i])/dir_arr[i];
	    }
	    else {
		maxT[i] = -1.0;
	    }
	}

	// Get largest of the maxT's for final choice of intersection
	whichPlane = 0;
	for (i=1;i<NUMDIM;i++) {
	    if (maxT[whichPlane]<maxT[i]) whichPlane = i;
	}

	// Check final candidate actually inside box
	if (maxT[whichPlane]<0.0) return false;
	for (i=0;i<NUMDIM;i++) {
	    if (whichPlane!=i) {
		coord_arr[i] = origin_arr[i]+maxT[whichPlane]*dir_arr[i];
		if (coord_arr[i]<minB_arr[i] || coord_arr[i]>maxB_arr[i]) return false;
	    }
	    else {
		coord_arr[i] = candidatePlane[i];
	    }
        }

	return true;				// ray hits box
    }

      // 10. rayRay ------------------------------------

    /**
     * @method  rayRay
     * @description Calculates the line segment PaPb that is the shortest route
     *              between two lines P1P2 and P3P4. Calculate also the values
     *              of mua and mub where:
     *              <pre>
     *              Pa = P1 + mua (P2 - P1)
     *              Pb = P3 + mub (P4 - P3)
     *              </pre>
     *              ref: <a href="http://astronomy.swin.edu.au/~pbourke/geometry/lineline3d/">Paul Bourke - lineLine3d</a>
     * @usage  <pre>inst.rayRay(p1, p2, p3, p4, pa, pb[, true]);</pre>
     * @param   p1   (Point)   -- start of line1 segment.
     * @param   p2   (Point)   -- end of line1 segment.
     * @param   p3   (Point)   -- start of line2 segment.
     * @param   p4   (Point)   -- end of line2 segment.
     * @param   pa   (Point)   -- point on line1 segment for shortest connecting line.
     * @param   pb   (Point)   -- point on line2 segment for shortest connecting line.
     * @param   bSeg  (Boolean)  -- clamps calculation to segment if passed true.
     * @param   mua   (Number)   -- (not passed) scalar of line1 segment for point of shortest connecting line.
     * @param   mub   (Number)   -- (not passed) scalar of line2 segment for point of shortest connecting line.
     * @return  (Boolean)  -- returns false if no solution exists.
)
    **/
    public function rayRay(p1:Point, p2:Point, p3:Point, p4:Point, pa:Point, pb:Point, bSeg:Boolean):Object {
        var x:Number = 0;
        var y:Number = 0;
        var z:Number = 0;
        var numer:Number, denom:Number, mua:Number, mub:Number;
        var d1343:Number, d4321:Number, d1321:Number, d4343:Number, d2121:Number;
        var p13:Point = new Point(x, y, z);
        var p43:Point = new Point(x, y, z);
        var p21:Point = new Point(x, y, z);

        p13.x = p1.x-p3.x;
        p13.y = p1.y-p3.y;
        p13.z = p1.z-p3.z;
        p43.x = p4.x-p3.x;
        p43.y = p4.y-p3.y;
        p43.z = p4.z-p3.z;
        if (Math.abs(p43.x)<Format.dbleEpsilon() &&
            Math.abs(p43.y)<Format.dbleEpsilon() &&
            Math.abs(p43.z)<Format.dbleEpsilon()) return null; // false;
        p21.x = p2.x-p1.x;
        p21.y = p2.y-p1.y;
        p21.z = p2.z-p1.z;
        if (Math.abs(p21.x)<Format.dbleEpsilon() &&
            Math.abs(p21.y)<Format.dbleEpsilon() &&
            Math.abs(p21.z)<Format.dbleEpsilon()) return null; // false;

        d1343 = p13.x*p43.x+p13.y*p43.y+p13.z*p43.z;
        d4321 = p43.x*p21.x+p43.y*p21.y+p43.z*p21.z;
        d1321 = p13.x*p21.x+p13.y*p21.y+p13.z*p21.z;
        d4343 = p43.x*p43.x+p43.y*p43.y+p43.z*p43.z;
        d2121 = p21.x*p21.x+p21.y*p21.y+p21.z*p21.z;

        denom = d2121*d4343-d4321*d4321;
        if (Math.abs(denom)<Format.dbleEpsilon()) return null; // false;
        numer = d1343*d4321-d1321*d4343;

        mua = numer/denom;
        mub = (d1343+d4321*(mua))/d4343;
        
        // clamp to segments
        if (bSeg) {
            if (mua<0) mua = 0; 
	    else if (mua>1) mua = 1; 
	    if (mub<0) mub = 0; 
            else if (mub>1) mub = 1;
        }

        pa.x = p1.x+mua*p21.x;
        pa.y = p1.y+mua*p21.y;
        pa.z = p1.z+mua*p21.z;
        pb.x = p3.x+mub*p43.x;
        pb.y = p3.y+mub*p43.y;
        pb.z = p3.z+mub*p43.z;

        /*
        trace ("\n## Intersect3DRay.rayRay ##\nint_obj: "+
               "\npa.x: "+pa.x+" pa.y: "+pa.y+" pa.z: "+pa.z+
               "\npb.x: "+pb.x+" pb.y: "+pb.y+" pb.z: "+pb.z+
               "\nmua: "+mua+"\nmub: "+mub+
               "\np1.x: "+p1.x+" p1.y: "+p1.y+" p1.z: "+p1.z+
               "\np2.x: "+p2.x+" p2.y: "+p2.y+" p2.z: "+p2.z+
               "\np3.x: "+p3.x+" p3.y: "+p3.y+" p3.z: "+p3.z+
               "\np4.x: "+p4.x+" p4.y: "+p4.y+" p4.z: "+p4.z+
               "\np13.x: "+p13.x+" p13.y: "+p13.y+" p13.z: "+p13.z+
               "\np21.x: "+p21.x+" p21.y: "+p21.y+" p21.z: "+p21.z+
               "\np43.x: "+p43.x+" p43.y: "+p43.y+" p43.z: "+p43.z);
        trace ("boolean1: "+((p1.x+mua*p21.x)==(p3.x+mub*p43.x)));
        trace ("boolean2: "+(pa.x==pb.x));
        */
               
        //return true;
        return {pa:pa, pb:pb, mua:mua, mub:mub};
    }

      // POINT4 macro ----------------------------------

	/**
	 * @method  POINT4
	 * @description  4d point macro.
	 * @usage  <pre>inst.POINT4();</pre>
	 * @return  (Object)  -- returns an object containing class properties.
	**/
	public function POINT4():Object {
	    var x:Number;
	    var y:Number;
	    var z:Number;
	    var w:Number;

	    return {x:x, y:y, z:z, w:w};
	}

      // DOT3 macro ------------------------------------

	/**
	 * @method  DOT3
	 * @description  Fast macro version of V3Dot, usable with POINT4.
	 * @usage  <pre>inst.DOT3(a, b);</pre>
	 * @param   a   (Vector)  -- a position Vector object.
	 * @param   b   (Vector)  -- a position Vector object.
	 * @return  (Number)  -- returns a 3-space dot product.
	**/
	public function DOT3(a:Vector, b:Vector):Number {
	    return (a.x*b.x+a.y*b.y+a.z*b.z);
	}

}// class
}//package

