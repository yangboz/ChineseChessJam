package com.vizsage.as3mathlib.math.geom.intersect2D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez3
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Intersect2DBez3 Class. This
 *              class extends Intersect2D superclass.
 * @usage       <pre>var inst:Intersect2DBez3 = new Intersect2DBez3(status);</pre>
 * @param       status (String)  -- an identifier string.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Point
 *                com.vizsage.as3mathlib.math.alg.Polynomial
 *                com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D -- superclass
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
 * Functions:
 *       Intersect2DBez3()
 *             1.  init(status)
 *             2.  bez3Circle(p1, p2, p3, p4, c, r)
 *             3.  bez3Ellipse(p1, p2, p3, p4, ec, rx, ry)
 *             4.  bez3Line(p1, p2, p3, p4, a1, a2)
 *             5.  bez3Polygon(p1, p2, p3, p4, points)
 *             6.  bez3Rectangle(p1, p2, p3, p4, r1, r2)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Polynomial;
import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D;

public class Intersect2DBez3 extends Intersect2D {
	/**
	 * @property $status (String)  -- an identifier string.
	 * @property $points (Array)  -- a holder for vertex Point objects.
	**/
	/* bad
    public var $status:String;
    public var $points:Array; */

    public function Intersect2DBez3(status:String) {
    	super(status);
        //trace ("Intersect2DBez3 Class loaded");
        if (arguments.length>0) this.init(status);
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Initializes a new class instance.
     * @usage  <pre>inst.init(status);</pre>
     * @param   status   (String)  -- an identifier string.
     * @return  (void)
    **/
    private function init(status:String):void {
        $status = status;
        $points = [];
    }

      // 2. bez3Circle ---------------------------------

    /**
     * @method  bez3Circle
     * @description  Calculates intersection point(s), if any, between a cubic
     *               Bezier shape and a circle shape.
     * @usage  <pre>inst.bez3Circle(p1, p2, p3, p4, c, r);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control1 Point object.
     * @param   p3   (Point)  -- control2 Point object.
     * @param   p4   (Point)  -- end Point object.
     * @param   c   (Point)  -- circle center Point object.
     * @param   r   (Number)  -- circle radius value.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez3Circle(p1:Point, p2:Point, p3:Point, p4:Point, c:Point, r:Number):Intersect2D {
        trace ("$$$$$$$$$$ bez3Circle fired! $$$$$$$$$$");

        return this.bez3Ellipse(p1, p2, p3, p4, c, r, r);
    }

      // 3. bez3Ellipse --------------------------------

    /**
     * @method  bez3Ellipse
     * @description  Calculates intersection point(s), if any, between a cubic
     *               Bezier shape and an ellipse shape.
     * @usage  <pre>inst.bez3Ellipse(p1, p2, p3, p4, ec, rx, ry);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control1 Point object.
     * @param   p3   (Point)  -- control2 Point object.
     * @param   p4   (Point)  -- end Point object.
     * @param   ec   (Point)  -- ellipse center Point object.
     * @param   rx   (Number)  -- ellipse x-axis Point object.
     * @param   ry   (Number)  -- ellipse y-axis Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez3Ellipse(p1:Point, p2:Point, p3:Point, p4:Point, ec:Point, rx:Number, ry:Number):Intersect2D {
        trace ("$$$$$$$$$$ bez3Ellipse fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var p_4:Point = new Point(p4.x, p4.y);
        trace ("p_4: "+p_4.x+", "+p_4.y);
        var e_c:Point = new Point(ec.x, ec.y);
        trace ("e_c: "+e_c.x+", "+e_c.y);

        var a:Point;                 // temporary variables
        var b:Point;
        var c:Point;
        var d:Point;
        var c3:Vector;                // coefficients of cubic
        var c2:Vector;
        var c1:Vector;
        var c0:Vector;
        var result:Intersect2D = new Intersect2D("No Intersect");

        // Calculate the coefficients of cubic polynomial
        a = p_1.multiply(-1);
        b = p_2.multiply(3);
        c = p_3.multiply(-3);
        d = a.adds(b.adds(c.adds(p_4)));
        c3 = new Vector(d.x, d.y);

        a = p_1.multiply(3);
        b = p_2.multiply(-6);
        c = p_3.multiply(3);
        d = a.adds(b.adds(c));
        c2 = new Vector(d.x, d.y);

        a = p_1.multiply(-3);
        b = p_2.multiply(3);
        c = a.adds(b);
        c1 = new Vector(c.x, c.y);

        c0 = new Vector(p_1.x, p_1.y);

        var rxrx:Number = rx*rx;
        var ryry:Number = ry*ry;
        var poly:Polynomial = new Polynomial
        (
            c3.x*c3.x*ryry + c3.y*c3.y*rxrx,
            2*(c3.x*c2.x*ryry + c3.y*c2.y*rxrx),
            2*(c3.x*c1.x*ryry + c3.y*c1.y*rxrx) + c2.x*c2.x*ryry + c2.y*c2.y*rxrx,
            2*c3.x*ryry*(c0.x - e_c.x) + 2*c3.y*rxrx*(c0.y - e_c.y) +
                2*(c2.x*c1.x*ryry + c2.y*c1.y*rxrx),
            2*c2.x*ryry*(c0.x - e_c.x) + 2*c2.y*rxrx*(c0.y - e_c.y) +
                c1.x*c1.x*ryry + c1.y*c1.y*rxrx,
            2*c1.x*ryry*(c0.x - e_c.x) + 2*c1.y*rxrx*(c0.y - e_c.y),
            c0.x*c0.x*ryry - 2*c0.y*e_c.y*rxrx - 2*c0.x*e_c.x*ryry +
            c0.y*c0.y*rxrx + e_c.x*ec.x*ryry + e_c.y*e_c.y*rxrx - rxrx*ryry
        );
        var roots:Array = poly.getRootsInInterval(0, 1);
        var i:Number;

        for (i=0;i<roots.length;i++) {
            var t:Number = roots[i];

            // the use of Vector.scalar returns undefined, so I replaced it with returnScalar
            //result.$points.push(c3.scalar(t*t*t).adds(c2.scalar(t*t).adds(c1.scalar(t).adds(c0))));
            result.$points.push(c3.returnScalar(t*t*t).adds(c2.returnScalar(t*t).adds(c1.returnScalar(t).adds(c0))));
        }

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 4. bez3Line -----------------------------------

    /**
     * @method  bez3Line
     * @description  Calculates intersection point(s), if any, between a cubic
     *               Bezier shape and a line segment shape.
     * @usage  <pre>inst.bez3Line(p1, p2, p3, p4, a1, a2);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control1 Point object.
     * @param   p3   (Point)  -- control2 Point object.
     * @param   p4   (Point)  -- end Point object.
     * @param   a1   (Point)  -- start segment Point object.
     * @param   a2   (Point)  -- end segment Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez3Line(p1:Point, p2:Point, p3:Point, p4:Point, a1:Point, a2:Point):Intersect2D {
        trace ("$$$$$$$$$$ bez3Line fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var p_4:Point = new Point(p4.x, p4.y);
        trace ("p_4: "+p_4.x+", "+p_4.y);
        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);

        var a:Point;                  // temporary variables
        var b:Point;
        var c:Point;
        var d:Point;
        var c3:Vector;                // coefficients of cubic
        var c2:Vector;
        var c1:Vector;
        var c0:Vector;
        var cl:Number;                // c coefficient for normal form of line
        var n:Vector;                 // normal for normal form of line
        var min:Point = a_1.min(a_2); // used to determine if point is on line segment
        var max:Point = a_1.max(a_2); // used to determine if point is on line segment
        var result:Intersect2D = new Intersect2D("No Intersect");

        // Start with Bez using Bernstein polynomials for weighting functions:
        //     (1-t^3)P1 + 3t(1-t)^2P2 + 3t^2(1-t)P3 + t^3P4
        //
        // Expand and collect terms to form linear combinations of original Bez
        // controls.  This ends up with a vector cubic in t:
        //     (-P1+3P2-3P3+P4)t^3 + (3P1-6P2+3P3)t^2 + (-3P1+3P2)t + P1
        //             /\                  /\                /\       /\
        //             ||                  ||                ||       ||
        //             c3                  c2                c1       c0

        // Calculate the coefficients
        a = p_1.multiply(-1);
        b = p_2.multiply(3);
        c = p_3.multiply(-3);
        d = a.adds(b.adds(c.adds(p_4)));
        c3 = new Vector(d.x, d.y);

        a = p_1.multiply(3);
        b = p_2.multiply(-6);
        c = p_3.multiply(3);
        d = a.adds(b.adds(c));
        c2 = new Vector(d.x, d.y);

        a = p_1.multiply(-3);
        b = p_2.multiply(3);
        c = a.adds(b);
        c1 = new Vector(c.x, c.y);

        c0 = new Vector(p_1.x, p_1.y);

        // Convert line to normal form: ax + by + c = 0
        // Find normal to line: negative inverse of original line's slope
        n = new Vector(a_1.y-a_2.y, a_2.x-a_1.x);

        // Determine new c coefficient
        cl = a_1.x*a_2.y-a_2.x*a_1.y;

        // ?Rotate each cubic coefficient using line for new coordinate system?
        // Find roots of rotated cubic
        var roots:Array = new Polynomial(n.dotProduct(c3), n.dotProduct(c2), n.dotProduct(c1), n.dotProduct(c0)+cl).getRoots();
        var i:Number;

        // Any roots in closed interval [0, 1] are intersections on Bez, but
        // might not be on the line segment.
        // Find intersections and calculate point coordinates
        for (i=0;i<roots.length;i++) {
            var t:Number = roots[i];

            if (0<=t && t<=1) {
                // We're within the Bez curve
                // Find point on Bez
                var p_5:Point = p_1.lerp(p_2, t);
                var p_6:Point = p_2.lerp(p_3, t);
                var p_7:Point = p_3.lerp(p_4, t);
                var p_8:Point = p_5.lerp(p_6, t);
                var p_9:Point = p_6.lerp(p_7, t);
                var p_10:Point = p_8.lerp(p_9, t);

                // See if point is on line segment
                // Had to make special cases for vertical and horizontal lines due
                // to slight errors in calculation of p_10
                if (a_1.x==a_2.x) {
                    if (min.y<=p_10.y && p_10.y<=max.y) {
                        result.$status = "Intersect";
                        result.appendPoint(p_10);
                    }
                }
                else if (a_1.y==a_2.y) {
                    if (min.x<=p_10.x && p_10.x<=max.x) {
                        result.$status = "Intersect";
                        result.appendPoint(p_10);
                    }
                }
                else if (p_10.greaterThanEq(min) && p_10.lessThanEq(max)) {
                    result.$status = "Intersect";
                    result.appendPoint(p_10);
                }
            }
        }

        return result;
    }

      // 5. bez3Polygon --------------------------------

    /**
     * @method  bez3Polygon
     * @description  Calculates intersection point(s), if any, between a cubic
     *               Bezier shape and a polygon shape.
     * @usage  <pre>inst.bez3Polygon(p1, p2, p3, p4, points);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control1 Point object.
     * @param   p3   (Point)  -- control2 Point object.
     * @param   p4   (Point)  -- end Point object.
     * @param   points   (Array)  -- holder for polygon vertex Point objects.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez3Polygon(p1:Point, p2:Point, p3:Point, p4:Point, points:Array):Intersect2D {
        trace ("$$$$$$$$$$ bez3Polygon fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var p_4:Point = new Point(p4.x, p4.y);
        trace ("p_4: "+p_4.x+", "+p_4.y);

        var result:Intersect2D = new Intersect2D("No Intersect");
        var len:Number = points.length;

        var i:Number;

        for (i=0;i<len;i++) {
            var a_1:Point = points[i];
            var a_2:Point = points[(i+1)%len];
            var inter:Intersect2D = this.bez3Line(p_1, p_2, p_3, p_4, a_1, a_2);

            result.appendPoints(inter.$points);
        }

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 6. bez3Rectangle ------------------------------

    /**
     * @method  bez3Rectangle
     * @description  Calculates intersection point(s), if any, between a cubic
     *               Bezier shape and a rectangle shape.
     * @usage  <pre>inst.bez3Rectangle(p1, p2, p3, p4, r1, r2);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control1 Point object.
     * @param   p3   (Point)  -- control2 Point object.
     * @param   p4   (Point)  -- end Point object.
     * @param   r1   (Point)  -- rectangle Point object.
     * @param   r2   (Point)  -- rectangle Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez3Rectangle(p1:Point, p2:Point, p3:Point, p4:Point, r1:Point, r2:Point):Intersect2D {
        trace ("$$$$$$$$$$ bez3Rectangle fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var p_4:Point = new Point(p4.x, p4.y);
        trace ("p_4: "+p_4.x+", "+p_4.y);
        var r_1:Point = new Point(r1.x, r1.y);
        trace ("r_1: "+r_1.x+", "+r_1.y);
        var r_2:Point = new Point(r2.x, r2.y);
        trace ("r_2: "+r_2.x+", "+r_2.y);

        var min:Point = r_1.min(r_2);
        var max:Point = r_1.max(r_2);
        var topRight:Point = new Point(max.x, min.y);
        var bottomLeft:Point = new Point(min.x, max.y);

        var inter1:Intersect2D = this.bez3Line(p_1, p_2, p_3, p_4, min, topRight);
        var inter2:Intersect2D = this.bez3Line(p_1, p_2, p_3, p_4, topRight, max);
        var inter3:Intersect2D = this.bez3Line(p_1, p_2, p_3, p_4, max, bottomLeft);
        var inter4:Intersect2D = this.bez3Line(p_1, p_2, p_3, p_4, bottomLeft, min);

        var result:Intersect2D = new Intersect2D("No Intersect");

        result.appendPoints(inter1.$points);
        result.appendPoints(inter2.$points);
        result.appendPoints(inter3.$points);
        result.appendPoints(inter4.$points);

        if (result.$points.length>0 ) result.$status = "Intersect";

        return result;
    }

}// class
}//package

