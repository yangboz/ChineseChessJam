package com.vizsage.as3mathlib.math.geom.intersect2D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Intersect2D Class.
 *              <p>
 *		        This class has been spread across the entire contents of the
 *              intersect2D package, due to the large byte size of the original JS
 *              document. Flash MX restricts class files to 32 k, so I have
 *              presented this class as the superclass to connect all of the 2D
 *              intersection routines.
 * @usage       <pre>var inst:Intersect2D = new Intersect2D(status);</pre>
 * @param       status (String)  -- an identifier string.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Point
 *                com.vizsage.as3mathlib.math.alg.Polynomial
 *                com.vizsage.as3mathlib.math.alg.Vector
 *                -- subclass list:
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez2
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez3
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez3Bez3
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DCircle
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DLine
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DParams
 * -----------------------------------------------
 * AS2 revision copyright: � 2003, Richard Wright     [wisolutions2002@shaw.ca]
 * JS  original copyright: � 2000-2002, Kevin Lindsey [http://www.kevlindev.com/]
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
 * Full Package Functions - generalized groupings to keep each file size < 32k
 *
 *       Intersect2D(status)
 *             1.  init(status)
 *             2.  appendPoint(point)
 *             3.  appendPoints(points)
 *             4.  pointsToString()
 *             5.  toString()
 *             6.  shapes(shape1, shape2)
 *             7.  pathShape(path, shape)
 *             8.  bezout(e1, e2)
 8
 8       Extensions:
 *
 *       Intersect2DBez2(status)
 *             1.  init(status)
 *             2.  bez2Bez2(a1, a2, a3, b1, b2, b3)
 *             3.  bez2Bez3(a1, a2, a3, b1, b2, b3, b4)
 *             4.  bez2Circle(p1, p2, p3, c, r)
 *             5.  bez2Ellipse(p1, p2, p3, ec, rx, ry)
 *             6.  bez2Line(p1, p2, p3, a1, a2)
 *             7.  bez2Polygon(p1, p2, p3, points)
 *             8.  bez2Rectangle(p1, p2, p3, r1, r2)
 *
 *       Intersect2DBez3(status)
 *             1.  init(status)
 *             2.  bez3Circle(p1, p2, p3, p4, c, r)
 *             3.  bez3Ellipse(p1, p2, p3, p4, ec, rx, ry)
 *             4.  bez3Line(p1, p2, p3, p4, a1, a2)
 *             5.  bez3Polygon(p1, p2, p3, p4, points)
 *             6.  bez3Rectangle(p1, p2, p3, p4, r1, r2)
 *
 *       Intersect2DBez3Bez3(status)
 *             1.  init(status)
 *             2.  bez3Bez3(a1, a2, a3, a4, b1, b2, b3, b4)
 *
 *       Intersect2DCircle(status)
 *             1.  init(status)
 *             2.  circleCircle(c1, r1, c2, r2)
 *             3.  circleEllipse(cc, r, ec, rx, ry)
 *             4.  circleLine(c, r, a1, a2)
 *             5.  circlePolygon(c, r, points)
 *             6.  circleRectangle(c, r, r1, r2)
 *             7.  ellipseEllipse(c1, rx1, ry1, c2, rx2, ry2)
 *             8.  ellipseLine(c, rx, ry, a1, a2)
 *             9.  ellipsePolygon(c, rx, ry, points)
 *             10. ellipseRectangle(c, rx, ry, r1, r2)
 *
 *       Intersect2DLine(status)
 *             1.  init(status)
 *             2.  lineLine(a1, a2, b1, b2)
 *             3.  linePolygon(a1, a2, points)
 *             4.  lineRectangle(a1, a2, r1, r2)
 *             5.  polygonPolygon(points1, points2)
 *             6.  polygonRectangle(points, r1, r2)
 *             7.  rayRay(a1, a2, b1, b2)
 *             8.  lineRay(a1, a2, b1, b2)
 *             9.  rectangleRectangle(a1, a2, b1, b2)
 *
 *       Intersect2DParams(name, params) - supports 'Path' shape functions
 *             1.  init(name, params)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: - presently not fully functional - testing in progress            *** TODO
 *       - any attempt to drag a polygon shape will stall the cpu.
 *       - 212, 225, 229 need work
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Polynomial;
import com.vizsage.as3mathlib.math.alg.Vector;

public class Intersect2D  {
	/**
	 * @property $status (String)  -- an identifier string.
	 * @property $points (Array)  -- a holder for vertex Point objects.
	**/
    public var $status:String;
    public var $points:Array;

    // constructor
    public function Intersect2D (status:String) {
        //trace ("Intersect2D Class loaded");
        if (arguments.length>0) {
            this.init(status);
        }
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Initializes anew Intersect2D instance.
     * @usage  <pre>inst.init(status);</pre>
     * @param   status   (String)  -- an identifier string.
     * @return  (void)
    **/
    private function init(status:String):void {
        $status = status;
        $points = [];
    }

      // 2. appendPoint --------------------------------

    /**
     * @method  appendPoint
     * @description  Adds a new vertex Point object to the stack.
     * @usage  <pre>inst.appendPoint(point);</pre>
     * @param   point   (Object)  -- a vertex Point object.
     * @return  (void)
    **/
    public function appendPoint(point:Object):void {
        $points.push(point);
    }

      // 3. appendPoints -------------------------------

    /**
     * @method  appendPoints
     * @description  Adds a list of new vertex Point objects to the stack.
     * @usage  <pre>inst.appendPoints(points);</pre>
     * @param   points   (Array)  -- a holder for vertex Point objects.
     * @return  (void)
    **/
    public function appendPoints(points:Array):void {
        $points = $points.concat(points);
    }

      // 4. pointsToString -----------------------------

    /**
     * @method  pointsToString
     * @description  Creates a string representation of the stack data.
     * @usage  <pre>inst.pointsToString();</pre>
     * @return  (String)  -- returns a string representation of the stack data for display.
    **/
    public function pointsToString():String {
        var point_str:String = "[";
        var j:Number;

        for (j=0;j<$points.length;j++) {
            point_str += "[x:"+$points[j].x+", y:"+$points[j].y+"], ";
        }
        return point_str = point_str.substr(0, -1)+"]";
    }

      // 5. toString -----------------------------------

    /**
     * @method  toString
     * @description  Creates a string representation of the stack data that
     *               includes this instance's $status string as an identifier.
     * @usage  <pre>inst.toString();</pre>
     * @return  (String)  -- returns a string representation of the stack data that includes this instance's $status string as an identifier.
    **/
    public function toString():String {
	    var point_str:String = pointsToString();

	    return $status+":\n"+point_str+"\n";
    }

      // 6. shapes -------------------------------------

    /**
     * @method  shapes
     * @description  Called from subclasses, it concatenates shape object returns
     *               from 'getIntersect2DParams' to define type of Intersect2D
     *               intersection test.
     * @usage  <pre>inst.shapes(shape1, shape2);</pre>
     * @param   shape1   (Object)  -- a generic shape object.
     * @param   shape2   (Object)  -- a generic shape object.
     * @return  (Intersect2D)  -- returns anew Intersect2D object.
    **/
    public function shapes(shape1:Object, shape2:Object):Intersect2D {
        var ip1:Object = shape1.getIntersect2DParams();
        var ip2:Object = shape2.getIntersect2DParams();
        var result:Intersect2D;

        if (ip1!=null && ip2!=null) {
            if (ip1.name=="Path") {
                //result = Intersect2D.pathShape(shape1, shape2); // *** TODO
                //result = pathShape(shape1, shape2);
            }
            else if (ip2.name=="Path") {
                //result = Intersect2D.pathShape(shape2, shape1); // *** TODO
                //result = pathShape(shape2, shape1);
            }
            else {
                var method:String;
                var params:Array;

                if (ip1.name<ip2.name) {
                    method = ip1.name+ip2.name;
                    params = ip1.params.concat(ip2.params);
                }
                else {
                    method = ip2.name+ip1.name;
                    params = ip2.params.concat(ip1.params);
                }
                // *** may not work ***                                   // *** TODO
                //if (!method in Intersect2D) trace("Intersect2D not available: "+method);
                if (!method) trace("Intersect2D not available: "+method);

                result = this[method].apply(null, params);
            }
        }
        else {
            result = new Intersect2D("No Intersect");
        }

        return result;
    }

      // 7. pathShape ----------------------------------

    /**
     * @method  pathShape
     * @description  Static -- subclass method overrides this method.
     * @usage  <pre>inst.pathShape(path, shape);</pre>
     * @param   path    (Function)  -- a shape object function.
     * @param   shape   (Object)    -- a generic shape object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public static function pathShape(path:Function, shape:Object):Intersect2D {
    	throw new Error ("AS2-AS3 Transition Error: what did 'path.intersectShape(shape)' (path is a Function) mean?");
	    //    return path.intersectShape(shape);
    }

      // 8. bezout -------------------------------------

    /**
     * @method  bezout
     * @description ** function description here
     * @usage  <pre>inst.bezout(e1, e2);</pre>
     * @param   e1   (Array)  -- a holder for polynomial '1' coefficients.
     * @param   e2   (Array)  -- a holder for polynomial '2' coefficients.
     * @return  (Polynomial)  -- returns a new Polynomial object.
    **/
    public function bezout(e1:Array, e2:Array):Polynomial {
        trace ("$$$$$$$$$$ bezout fired! $$$$$$$$$$");

        var AB:Number = e1[0]*e2[1]-e2[0]*e1[1];
        var AC:Number = e1[0]*e2[2]-e2[0]*e1[2];
        var AD:Number = e1[0]*e2[3]-e2[0]*e1[3];
        var AE:Number = e1[0]*e2[4]-e2[0]*e1[4];
        var AF:Number = e1[0]*e2[5]-e2[0]*e1[5];
        var BC:Number = e1[1]*e2[2]-e2[1]*e1[2];
        var BE:Number = e1[1]*e2[4]-e2[1]*e1[4];
        var BF:Number = e1[1]*e2[5]-e2[1]*e1[5];
        var CD:Number = e1[2]*e2[3]-e2[2]*e1[3];
        var DE:Number = e1[3]*e2[4]-e2[3]*e1[4];
        var DF:Number = e1[3]*e2[5]-e2[3]*e1[5];
        var BFpDE:Number = BF+DE;
        var BEmCD:Number = BE-CD;

        return new Polynomial (
            AB*BC-AC*AC,
            AB*BEmCD+AD*BC-2*AC*AE,
            AB*BFpDE+AD*BEmCD-AE*AE-2*AC*AF,
            AB*DF+AD*BFpDE-2*AE*AF,
            AD*DF-AF*AF
        );
    }

}// class
}//package

