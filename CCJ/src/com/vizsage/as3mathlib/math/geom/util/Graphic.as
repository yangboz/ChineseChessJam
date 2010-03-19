package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.Graphic
 * @author      Richard Wright
 * @version     1.8
 * @description Implements the static behaviours of the Graphic Class. 
 *		Provides methods for the geometric manipulation of the screen graphics.
 * @usage       <pre>Graphic.classMethod(args);</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 8, 2005
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Point
 *                com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.intersect2D.*
 *                com.vizsage.as3mathlib.math.geom.intersect3D.*
 *                com.vizsage.as3mathlib.math.geom.trig.Degree
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright    [wisolutions2002@shaw.ca]
 * JS  original copyright © 2003, Oscar van Vlijmen [ovv@hetnet.nl]
 *              Website: http://home.hetnet.nl/~vanadovv/Gonio.html
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
 *       Graphic()
 *           1.  distance(p1, p2)
 *           2.  angle(p1, p2)
 *           3.  radAngle(p1, p2)
 *           4.  toStandardAngle(ang)
 *           5.  lineToStandardAngle(p1, p2)
 *           6.  angleSpan(ang1, ang2, cw)
 *           7.  averageAngle(arr)
 *           8.  numSort(a, b)
 *           9.  toPoint(vec)
 *           10. toPolar(vec)
 *           11. intersectLines(l1, l2)
 *           12. intersectLinesImplicit(l1, l2)
 *           13. intersectLinesParametric(l1, l2, bSeg)
 *           14. distPtSegment(P, S)
 *           15. getMiddle(p1, p2)
 *           16. pointOnSegment(p1, p2, ratio)
 *           17. isPointOnSegment(p1, p2, p3)
 *           18. projectDistance(p1, p2)
 *           19. triangleArea(p1, p2, p3)
 *           20. polygonArea(arr)
 *           21. parabolaArcLength(a, b)
 *       Angle Conversion:
 *           22. dms2Deg(sDms)
 *           23. deg2Dms(deg)
 *           24. convertDeg(deg, sOut)
 *           25. convertRad(rad, sOut)
 *           26. convertMultPI(multPI, sOut)
 *           27. convertDms(sDms, sOut)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.trig.Degree;
import com.vizsage.as3mathlib.math.geom.intersect2D.*;
import com.vizsage.as3mathlib.math.geom.intersect3D.*;

public class Graphic  {
    /**
     * @property none  -- no class properties.
    **/
    public function Graphic() {
        //trace ("Graphic Class loaded");
    }

    /////////////////////////////////
    // Graphic Functions
    /////////////////////////////////

      // 1. distance -----------------------------------

    /**
     * @method  distance
     * @description  Defines the distance between two Point objects.
     * @usage  <pre>Graphic.distance(p1, p2);</pre>
     * @param   p1   (Point)  -- a point object in 2 or 3-space.
     * @param   p2   (Point)  -- a point object in 2 or 3-space.
     * @return  (Number)  -- returns total distance between 2 points.
    **/
    public static function distance(p1:Point, p2:Point):Number {
        var dX:Number = p2.x-p1.x;
        var dY:Number = p2.y-p1.y;

        if (p1.z && p2.z) {
            var dZ:Number = p2.z-p1.z;
            
            return Math.sqrt(dX*dX+dY*dY+dZ*dZ);
        }
        else return Math.sqrt(dX*dX+dY*dY);
    }

      // 2. angle --------------------------------------

    /**
     * @method  angle
     * @description  Defines the angle in degrees of the line between two Point
     *               objects wrt the positive x-axis.
     * @usage  <pre>Graphic.angle(p1, p2);</pre>
     * @param   p1   (Point)  -- a point object in 2-space.
     * @param   p2   (Point)  -- a point object in 2-space.
     * @return  (Number)  -- returns angle of line in degrees (-180° to 180°).
    **/
    public static function angle(p1:Point, p2:Point):Number {
        return Math.atan2(p2.y-p1.y, p2.x-p1.x)*180/Math.PI;
    }

      // 3. radAngle -----------------------------------

    /**
     * @method  radAngle
     * @description  Defines the angle in radians of the line between two Point
     *               objects wrt the positive x-axis.
     * @usage  <pre>Graphic.radAngle(p1, p2);</pre>
     * @param   p1   (Point)  -- a point object in 2-space.
     * @param   p2   (Point)  -- a point object in 2-space.
     * @return  (Number)  -- returns angle of line in radians (-PI to PI).
    **/
    public static function radAngle(p1:Point, p2:Point):Number {
        return Math.atan2(p2.y-p1.y, p2.x-p1.x);
    }

      // 4. toStandardAngle ----------------------------

    /**
     * @method  toStandardAngle
     * @description  Changes a Flash angle (-180° to 180°) into standard
     *               angle (0° to 360° CCW) wrt the positive x-axis using
     *               angle input.
     * @usage  <pre>Graphic.toStandardAngle(ang);</pre>
     * @param   ang   (Number)  -- an angle in degrees (-180° to 180°).
     * @return  (Number)  -- returns an angle in degrees (0° to 360° CCW).
    **/
    public static function toStandardAngle(ang:Number):Number {
        var a:Number = 360-(((ang%=360)<0) ? ang+360 : ang);

        return (a==360) ? 0 : a;
    }

      // 5. lineToStandardAngle ------------------------

    /**
     * @method  lineToStandardAngle
     * @description  Changes a Flash angle (-180° to 180°) into standard
     *               angle (0° to 360° CCW) wrt the positive x-axis using
     *               point object input.
     * @usage  <pre>Graphic.lineToStandardAngle(p1, p2);</pre>
     * @param   p1   (Point)  -- a point object in 2-space.
     * @param   p2   (Point)  -- a point object in 2-space.
     * @return  (Number)  -- returns an angle in degrees (0° to 360° CCW).
    **/
    public static function lineToStandardAngle(p1:Point, p2:Point):Number {
        var a:Number = Graphic.angle(p1, p2);
        var ang:Number = 360-(((a%=360)<0) ? a+360 : a);

        return (ang==360) ? 0 : ang;
    }

      // 6. angleSpan ----------------------------------

    /**
     * @method  angleSpan
     * @description  Defines the difference in degrees of two angles with span
     *               based on Boolean input.
     * @usage  <pre>Graphic.angleSpan(ang1, ang2, cw);</pre>
     * @param   ang1   (Number)  -- a start angle in degrees.
     * @param   ang2   (Number)  -- an end angle in degrees.
     * @param   cw   (Boolean)  -- optional, measures clockwise if true, counter-clockwise if false.
     * @return  (Number)  -- returns the difference between 2 angles in degrees.
    **/
    public static function angleSpan(ang1:Number, ang2:Number, cw:Boolean):Number {
        var ang:Number = Graphic.toStandardAngle(Graphic.toStandardAngle(ang1)-Graphic.toStandardAngle(ang2));

        if (cw) return 360-ang;
        else return ang;
    }

      // 7. averageAngle -------------------------------

    /**
     * @method  averageAngle
     * @description  Defines the average angle for input of an array of angles.
     * @usage  <pre>Graphic.averageAngle(arr);</pre>
     * @param   arr   (Array)  -- an array of angle in degrees.
     * @return  (Number)  -- returns the average of all angles.
    **/
    public static function averageAngle(arr:Array):Number {
        // sort array to prepare for hemisphere check
        arr.sort(Graphic.numSort);

        var len:Number = arr.length;
        var temp:Number = arr[0];
        var j:Number;

        // hemisphere check and summation
        for (j=1;j<len;j++) {
            if (arr[j]>arr[0]+180) {
                arr[j] = -(360-arr[j]);
            }
            temp += arr[j];
        }
        // average of summation
        temp /= len;
        // change final average angle to a positive reading
        if (temp<0) temp += 360;
        return temp;
    }

      // 8. numSort ------------------------------------

    /**
     * @method  numSort
     * @description  Dependent sort by number method for 'averageAngle' sort above.
     * @usage  <pre>Graphic.numSort(a, b);</pre>
     * @param   a   (Number)  -- any real number.
     * @param   b   (Number)  -- any real number.
     * @return  (Number)  -- returns two input numbers sorted min to max.
    **/
    public static function numSort(a:Number, b:Number):Number {
        return (a-b);
    }

      // 9. toPoint ------------------------------------

    /**
     * @method  toPoint
     * @description  Defines Vector cartesian coordinates in 2-space -- expects to be
     *               passed: {a:n, r:n} (angle & radius).
     * @usage  <pre>Graphic.toPoint(vecObj );</pre>
     * @param   vecObj   (Object)  -- a vector object -- {a:n, r:n} (angle & radius).
     * @return  (Point)  -- returns an object containing Vector Cartesian coordinates.
    **/
    public static function toPoint(vecObj:Object):Point {
        var x:Number = vecObj.r*Degree.cosD(vecObj.a);
        var y:Number = vecObj.r*Degree.sinD(vecObj.a);
        var p:Point = new Point(x, y);

        return p;
    }

      // 10. toPolar -----------------------------------

    /**
     * @method  toPolar
     * @description  Defines Vector polar coordinates in 2-space -- expects to be
     *               passed: {x:n, y:n}.
     * @usage  <pre>Graphic.toPolar(vec);</pre>
     * @param   vec   (Vector)  -- a Vector object -- {x:n, y:n}.
     * @return  (Object)  -- returns an object containing Vector polar coordinates.
    **/
    public static function toPolar(vec:Vector):Object {
        var a:Number = Degree.atan2D(vec.y, vec.x);
        var r:Number = Math.sqrt(vec.x*vec.x+vec.y*vec.y);

        return {a:a, r:r};
    }

      // 11. intersectLines ----------------------------

    /**
     * @method  intersectLines
     * @description  Defines an intersection point of two lines in 2-space
     *               using the explicit line equation:
     *               <blockquote><pre>
     *               y = f(x) = mx + b
     *               </pre></blockquote>
     *               Contains a 2D vertical work-around to clip slopes
     *               measured to infinity.<br>
     *               Expects to be passed two: line object = {p1:Point, p2:Point}
     * @usage <pre>Graphic.intersectLines(l1, l2);</pre>
     * @param   l1   (Object)  -- line object containing 2 Point objects.
     * @param   l2   (Object)  -- line object containing 2 Point objects.
     * @return  (Point)  -- returns a Point object for the line intersection point.
    **/
    public static function intersectLines(l1:Object, l2:Object):Point {
        var m1:Number = (l1.p1.y-l1.p2.y)/(l1.p1.x-l1.p2.x);
        var m2:Number = (l2.p1.y-l2.p2.y)/(l2.p1.x-l2.p2.x);

        if (m1==Infinity) m1 = 1e304;
        else if (m1==-Infinity) m1 = -1e304;
        if (m2==Infinity) m2 = 1e304;
        else if (m2==-Infinity) m2 = -1e304;

        var x1:Number = l1.p1.x;
        var y1:Number = l1.p1.y;
        var x2:Number = l2.p1.x;
        var y2:Number = l2.p1.y;
        var x:Number = ((-m2*x2)+y2+(m1*x1)-y1)/(m1-m2);
        var y:Number = (m1*(x-x1))+y1;
        var pt:Point = new Point(x, y);

        return pt;
    }

      // 12. intersectLinesImplicit --------------------

    /**
     * @method  intersectLinesImplicit
     * @description  Defines an intersection point of two lines in 2-space
     *               using the implicit line equation:
     *               <blockquote><pre>
     *               f(x, y) = ax + by + c = 0
     *               </pre></blockquote>
     *               Expects to be passed two: line object = {p1:Point, p2:Point}
     * @usage <pre>
     *        Graphic.intersectLinesImplicit(l1, l2);
     *        // which in turn calls:
     *        var t1:Intersect2DLine = new Intersect2DLine();
     *        var t2:Intersect2D = t1.lineLine(l1.p1, l1.p2, l2.p1, l2.p2);
     *        var pt:Point = new Point(t2.$points[0].x, t2.$points[0].y);
     *        </pre>
     * @param   l1   (Object)  -- line object containing 2 Point objects.
     * @param   l2   (Object)  -- line object containing 2 Point objects.
     * @return  (Point)  -- returns a Point object for the line intersection point.
    **/
    public static function intersectLinesImplicit(l1:Object, l2:Object):Point {
        var t1:Intersect2DLine = new Intersect2DLine("New Intersection");
        var t2:Intersect2D = t1.lineLine(l1.p1, l1.p2, l2.p1, l2.p2);
        var pt:Point = new Point(t2.$points[0].x, t2.$points[0].y);

        return pt;
    }

      // 13. intersectLinesParametric ------------------

    /**
     * @method  intersectLinesParametric
     * @description  Defines in 3-space either an intersection point of two lines, or else the 
     *               more common case, the shortest path to the nearest point of each line,
     *               using the parametric line equation:
     *               <blockquote><pre>
     *               P(t) = P0 + t*vL
     *               </pre></blockquote>
     *               Expects to be passed two: line object = {p1:Point, p2:Point}
     * @usage <pre>Graphic.intersectLinesParametric(l1, l2[, true]);</pre>
     * @param   l1   (Object)  -- line object containing 2 Point objects.
     * @param   l2   (Object)  -- line object containing 2 Point objects.
     * @param   bSeg  (Boolean)  -- clamps calculation to line segments if passed true.
     * @return  (Point)  -- returns a Point object for the line intersection point.
    **/
    public static function intersectLinesParametric(l1:Object, l2:Object, bSeg:Boolean):Object {
        trace ("Graphic.intersectLinesParametric fired");
        var x:Number = 0;
        var y:Number = 0;
        var z:Number = 0;
        var mua:Number = 0;
        var mub:Number = 0;
        var pa:Point = new Point(x, y, z);
        var pb:Point = new Point(x, y, z);
        var t1:Intersect3DRay = new Intersect3DRay();
        var state_obj:Object = {};

        state_obj = t1.rayRay(l1.p1, l1.p2, l2.p1, l2.p2, pa, pb, bSeg);
        trace ("##### pa.x:"+pa.x+", y:"+pa.y+", z:"+pa.z+", pb.x:"+pb.x+", y:"+pb.y+", z:"+pb.z+"\n##### mua:"+state_obj.mua+", mub:"+state_obj.mub);

        return state_obj;
    }

      // 14. distPtSegment -----------------------------

    /**
     * @method  distPtSegment
     * @description Defines shortest distance between a point and a
     *              line segment in 3-space.
     * @usage  <pre>Graphic.distPtSegment(P, S);</pre>
     * @param   P   (Point)  -- an object defining a point in 3-space.
     * @param   S   (Object)  -- an object defining end Point objects for
     *                           a segment of a ray in 3-space.
     * @return  (Number)  -- returns shortest distance value.
    **/
    public static function distPtSegment(P:Point, S:Object):Number {
        var v:Vector = new Vector(S.p2.x-S.p1.x, S.p2.y-S.p1.y, S.p2.z-S.p1.z);
		var w:Vector = new Vector(P.x-S.p1.x, P.y-S.p1.y, P.z-S.p1.z);

		var c1:Number = Vector.dot(w, v);
		if (c1<=0) return Graphic.distance(P, S.p1);

		var c2:Number = Vector.dot(v, v);
		if (c2<=c1) return Graphic.distance(P, S.p2);

		var b:Number = c1/c2;
		var tV:Vector = Vector.scaler(v, b);
		var Pb:Point = new Point(S.p1.x+tV.x, S.p1.y+tV.y, S.p1.z+tV.z); //S.p1+b*v;

        return Graphic.distance(P, Pb);
    }

      // 15. getMiddle ---------------------------------

    /**
     * @method  getMiddle
     * @description  Defines the midpoint between two Point objects.
     * @usage  <pre>Graphic.getMiddle(p1, p2);</pre>
     * @param   p1   (Point)  -- a start Point object.
     * @param   p2   (Point)  -- an end Point object.
     * @return  (Point)  -- returns a new Point object.
    **/
    public static function getMiddle(p1:Point, p2:Point):Point {
        return new Point((p1.x+p2.x)/2, (p1.y+p2.y)/2);
    }

      // 16. pointOnSegment ----------------------------

	/**
	 * @method  pointOnSegment
	 * @description  Defines a point on a line segment based on a scalar.
	 * @usage  <pre>Graphic.pointOnSegment(p1, p2, ratio);</pre>
	 * @param   p1   (Point)  -- a start Point object.
	 * @param   p2   (Point)  -- an end Point object.
	 * @param   ratio   (Number)  -- a scalar (0 - 1).
	 * @return  (Point)  -- returns a new Point object.
	**/
	public static function pointOnSegment(p1:Point, p2:Point, ratio:Number):Point {
		return new Point((p1.x+((p2.x-p1.x)*ratio)), (p1.y+((p2.y-p1.y)*ratio)));
    }

      // 17. isPointOnSegment --------------------------

    // 14.  - test returns boolean condition if on line: p1 <- p3 -> p2

    /**
     * @method  isPointOnSegment
     * @description  Tests whether all three passed Point objects lie on the same
     *               line sgment, and whether p3 lies between p1 and p2.
     * @usage  <pre>Graphic.isPointOnSegment(p1, p2, p3);</pre>
     * @param   p1   (Point)  -- a start Point object.
     * @param   p2   (Point)  -- an end Point object.
     * @param   p3   (Point)  -- a Point object to test for line intercept.
     * @return  (Boolean)
    **/
    public static function isPointOnSegment(p1:Point, p2:Point, p3:Point):Boolean {
		var ratioX:Number = Math.round((p1.x-p3.x)/-(p2.x-p1.x)*100)/100;
		var ratioY:Number = Math.round((p1.y-p3.y)/-(p2.y-p1.y)*100)/100;

		if (ratioX==ratioY && ratioX>=0 && ratioX<=1) return true;
		else return false;
    }

      // 18. projectDistance ---------------------------

    /**
     * @method  projectDistance
     * @description  Defines projected distance between two Point objects.
     * @usage  <pre>Graphic.projectDistance(p1, p2);</pre>
     * @param   p1   (Point)  -- a start Point object.
     * @param   p2   (Point)  -- an end Point object.
     * @return  (Number)  -- returns total projected distance.
    **/
    public static function projectDistance(p1:Point, p2:Point):Number {
    	return Math.sqrt(p2.x*p2.x+p1.x*p1.x-2*p1.x*p2.x+p2.y*p2.y+p1.y*p1.y-2*p1.y*p2.y);
    }

      // 19. triangleArea ------------------------------

    /**
     * @method  triangleArea
     * @description  Calculates triangle area.
     * @usage  <pre>Graphic.triangleArea(p1, p2, p3);</pre>
     * @param   p1   (Point)  -- a vertex Point object.
     * @param   p2   (Point)  -- a vertex Point object.
     * @param   p3   (Point)  -- a vertex Point object.
     * @return  (Number)  -- returns area for the triangle.
    **/
    public static function triangleArea(p1:Point, p2:Point, p3:Point):Number {
        return .5*Math.abs(p1.x*p2.y+p1.y*p3.x+p3.y*p2.x-p2.y*p3.x-p1.y*p2.x-p1.x*p3.y);
    }

      // 20. polygonArea -------------------------------

    /**
     * @method  polygonArea
     * @description  Calculates the area of a convex or concave,
     *               non-self-intersecting polygon.
     * @usage  <pre>Graphic.polygonArea(arr);</pre>
     * @param   arr   (Array)  -- an array of vertex Point objects.
     * @return  (Number)  -- returns area for the polygon.
    **/
    public static function polygonArea(arr:Array):Number {
        var op1:Number = 0;
        var op2:Number = 0;
        var len:Number = arr.length;
        var j:Number;

        for (j=0;j<len-1;j++) {
            op1 += arr[j].x*arr[j+1].y;
            op2 += arr[j+1].x*arr[j].y;
        }

        return Math.abs(((op1+(arr[len-1].x*arr[0].y))-(op2+(arr[0].x*arr[len-1].y)))/2);
    }

      // 21. parabolaArcLength -------------------------

    /**
     * @method  parabolaArcLength
     * @description  Calculates the length of a parabola.
     * @usage  <pre>Graphic.parabolaArcLength(a, b);</pre>
     * @param   a   (Number)  -- length measure of the parabola's point projection (N <-> S).
     * @param   b   (Number)  -- length measure of the parabola's point projection (E <-> W).
     * @return  (Number)  -- returns the total length of the parabola.
    **/
    public static function parabolaArcLength(a:Number, b:Number):Number {
        return .5*Math.sqrt(b*b+16*a*a)+((b*b)/(8*a))*Math.log((4*a+Math.sqrt(b*b+16*a*a))/b);
    }

    /////////////////////////////////
    // Angle Conversion Functions
    /////////////////////////////////

      // 22. dms2Deg -----------------------------------

    /**
     * @method  dms2Deg
     * @description  Converts a string with degrees[:minutes[:seconds]] to decimal degrees.
     * @usage  <pre>Graphic.dms2Deg(sDms);</pre>
     * @param   sDms   (String)  -- a string with degrees[:minutes[:seconds]].
     * @return  (Number)  -- returns a decimal number for degrees.
    **/
    public static function dms2Deg(sDms:String):Number {
        var degPos:Number = sDms.indexOf(":");
        var secPos:Number = sDms.lastIndexOf(":");
        var deg:Number;
        var mn:Number;
        var sc:Number;

        if (secPos==degPos) secPos = -1;
        // there is a deg and min
        if (degPos>0) {
            deg = parseInt(sDms.substring(0, degPos));
            // there is a sec
            if (secPos>0) {
                mn = parseInt(sDms.substring(degPos+1, secPos));
                sc = parseFloat(sDms.substring(secPos+1, sDms.length));
            // no sec
            }
            else {
                mn = parseInt(sDms.substring(degPos+1, sDms.length));
                sc = 0;
            }
        // only deg
        }
        else {
            deg = parseInt(sDms);
            mn = 0;
            sc = 0;
        }

        //decimal degrees
        return (deg+(mn+(sc/60))/60);
    }

      // 23. deg2Dms -----------------------------------

    /**
     * @method  deg2Dms
     * @description  Converts decimal degrees to a deg:min:sec string.
     * @usage  <pre>Graphic.deg2Dms(deg);</pre>
     * @param   deg   (Number)  -- a real number for degrees.
     * @return  (String)  -- returns a string representation for degrees[:minutes[:seconds]].
    **/
    public static function deg2Dms(deg:Number):String {
        var adg:Number = Math.abs(deg);
        var fdg:Number = Math.floor(adg);
        var fsc:Number = adg*3600%60;
        var fmn:Number = Math.floor(adg*60%60);

        if (deg<0) fdg = -fdg;

        return fdg.toString()+":"+fmn.toString()+":"+fsc.toString();
    }

      // 24. convertDeg --------------------------------

    /**
     * @method  convertDeg
     * @description  Converts an angle in degrees to a string output.
     * @usage  <pre>Graphic.convertDeg(deg, sOut);</pre>
     * @param   deg   (Number)  -- a real number for degrees.
     * @param   sOut   (String)  -- a string passed to target output string type.
     * @return  (String)  -- returns a string representation of  'dms', 'rad', or 'multPI'.
    **/
    public static function convertDeg(deg:Number, sOut:String):String {
        if 		(sOut=="dms") 		return Graphic.deg2Dms(deg);
        else if (sOut=="rad") 		return (deg*Math.PI/180).toString();
        else if (sOut=="multPI") 	return (deg/180).toString();
        else 						return null;
    }

      // 25. convertRad --------------------------------

    /**
     * @method  convertRad
     * @description  Converts radian input to a string output.
     * @usage  <pre>Graphic.convertRad(rad, sOut);</pre>
     * @param   rad   (Number)  -- a real number for radians.
     * @param   sOut   (String)  -- a string: 'dms', 'deg', or 'multPI'.
     * @return  (String)  -- returns a string representation of  'dms', 'deg', or 'multPI' output.
    **/
    public static function convertRad(rad:Number, sOut:String):String {
        if 		(sOut=="dms") 		return Graphic.deg2Dms(rad*180/Math.PI);
        else if (sOut=="deg") 		return (rad*180/Math.PI).toString();
        else if (sOut=="multPI") 	return (rad/Math.PI).toString();
        else 						return null;
    }

      // 26. convertMultPI -----------------------------

    /**
     * @method  convertMultPI
     * @description  Converts multPI input to a string output.
     * @usage  <pre>Graphic.convertMultPI(multPI, sOut);</pre>
     * @param   multPI   (Number)  -- a real number for multPI
     * @param   sOut   (String)  -- a string: 'dms', 'deg', or 'rad'.
     * @return  (String)  -- returns a string representation of 'dms', 'deg', or 'rad' output.
    **/
    public static function convertMultPI(multPI:Number, sOut:String):String {
        if 		(sOut=="dms") 		return Graphic.deg2Dms(multPI*180);
        else if (sOut=="deg") 		return (multPI*180).toString();
        else if (sOut=="rad")		return (multPI*Math.PI).toString();
        else 						return null;
    }

      // 27. convertDms --------------------------------

    /**
     * @method  convertDms
     * @description  Converts dms input to a string output.
     * @usage  <pre>Graphic.convertDms(sDms, sOut);</pre>
     * @param   sDms   (String)  -- a string representation  for dms.
     * @param   sOut   (String)  -- a string: 'multPI', 'deg', or 'rad'.
     * @return  (Number)  -- returns a real number for 'multPI', 'deg', or 'rad' output..
    **/
    public static function convertDms(sDms:String, sOut:String):Number {
        var x:Number = Graphic.dms2Deg(sDms);

        if 		(sOut=="multPI") 	return x/180;
        else if (sOut=="deg") 		return x;
        else if (sOut=="rad") 		return x*Math.PI/180;
        else 						return NaN;
    }

}// class
}//package

