package com.vizsage.as3mathlib.math.geom.intersect2D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DCircle
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Intersect2DCircle  Class. This
 *              class extends Intersect2D superclass.
 * @usage       <pre>var inst:Intersect2DCircle = new Intersect2DCircle(status);</pre>
 * @param       status (String)  -- an identifier string.
 * -----------------------------------------------
 * Latest update: July 27, 2004
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
 *       Intersect2DCircle()
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
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Polynomial;
import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D;

public class Intersect2DCircle extends Intersect2D {

    public function Intersect2DCircle(status:String) {
    	super(status);
        //trace ("Intersect2DCircle Class loaded");
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

      // 2. circleCircle -------------------------------

    /**
     * @method  circleCircle
     * @description  Calculates intersection point(s), if any, between two
     *               circle shapes.
     * @usage  <pre>inst.circleCircle(c1, r1, c2, r2);</pre>
     * @param   c1   (Point)  -- circle '1' center Point object.
     * @param   r1   (Number)  -- circle '1' radius value.
     * @param   c2   (Point)  -- circle '2' center Point object.
     * @param   r2   (Number)  -- circle '2' radius value.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function circleCircle(c1:Point, r1:Number, c2:Point, r2:Number):Intersect2D {
        trace ("$$$$$$$$$$ circleCircle fired! $$$$$$$$$$");

        var c_1:Point = new Point(c1.x, c1.y);
        trace ("c_1: "+c_1.x+", "+c_1.y);
        var c_2:Point = new Point(c2.x, c2.y);
        trace ("c_2: "+c_2.x+", "+c_2.y);

        var result:Intersect2D;

        // Determine minimum and maximum radii where circles can intersect
        var r_max:Number = r1+r2;
        var r_min:Number = Math.abs(r1-r2);

        // Determine actual distance between circle circles
        var c_dist:Number = c_1.distanceFrom(c_2);

        if (c_dist>r_max) {
            result = new Intersect2D("Outside");
        }
        else if (c_dist<r_min) {
            result = new Intersect2D("Inside");
        }
        else {
            result = new Intersect2D("Intersect");

            var a:Number = (r1*r1-r2*r2+c_dist*c_dist)/(2*c_dist);
            var h:Number = Math.sqrt(r1*r1-a*a);
            var p:Point = c_1.lerp(c_2, a/c_dist);
            var b:Number = h/c_dist;

            result.$points.push(new Point(p.x-b*(c_2.y-c_1.y), p.y+b*(c_2.x-c_1.x)));
            result.$points.push(new Point(p.x+b*(c_2.y-c_1.y), p.y-b*(c_2.x-c_1.x)));
        }

        return result;
    }

      // 3. circleEllipse ------------------------------

    /**
     * @method  circleEllipse
     * @description  Calculates intersection point(s), if any, between a circle
     *               shape and an ellipse shape.
     * @usage  <pre>inst.circleEllipse(cc, r, ec, rx, ry);</pre>
     * @param   cc   (Point)  -- circle center Point object.
     * @param   r   (Number)  -- circle radius value.
     * @param   ec   (Point)  -- ellipse center Point object.
     * @param   rx   (Number)  -- ellipse x-axis radius value.
     * @param   ry   (Number)  -- ellipse y-axis radius value.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function circleEllipse(cc:Point, r:Number, ec:Point, rx:Number, ry:Number):Intersect2D {
        trace ("$$$$$$$$$$ circleEllipse fired! $$$$$$$$$$");

        return this.ellipseEllipse(cc, r, r, ec, rx, ry);
    }

      // 4. circleLine ---------------------------------

    /**
     * @method  circleLine
     * @description  Calculates intersection point(s), if any, between a circle
     *               shape and a line segment shape.
     * @usage  <pre>inst.circleLine(c, r, a1, a2);</pre>
     * @param   c   (Point)  -- circle center Point object.
     * @param   r   (Number)  -- circle radius value.
     * @param   a1   (Point)  -- start segment Point object.
     * @param   a2   (Point)  -- end segment Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function circleLine(c:Point, r:Number, a1:Point, a2:Point):Intersect2D {
        trace ("$$$$$$$$$$ circleLine fired! $$$$$$$$$$");

        var c_0:Point = new Point(c.x, c.y);
        trace ("c_0: "+c_0.x+", "+c_0.y);
        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);

        var result:Intersect2D;
        var a:Number = (a_2.x-a_1.x)*(a_2.x-a_1.x)+(a_2.y-a_1.y)*(a_2.y-a_1.y);
        var b:Number  = 2*((a_2.x-a_1.x)*(a_1.x-c.x)+(a_2.y-a_1.y)*(a_1.y-c_0.y));
        var cc:Number = c_0.x*c_0.x+c_0.y*c_0.y+a_1.x*a_1.x+a_1.y*a_1.y-2*(c_0.x*a_1.x+c_0.y*a_1.y)-r*r;
        var deter:Number = b*b-4*a*cc;

        if (deter<0) {
            result = new Intersect2D("Outside");
        }
        else if (deter==0) {
            result = new Intersect2D("Tangent");
            // NOTE: should calculate this point
        }
        else {
            var e:Number  = Math.sqrt(deter);
            var u1:Number = (-b+e)/(2*a);
            var u2:Number = (-b-e)/(2*a);

            if ((u1<0 || u1>1) && (u2<0 || u2>1)) {
                if ((u1<0 && u2<0) || (u1>1 && u2>1)) {
                    result = new Intersect2D("Outside");
                }
                else {
                    result = new Intersect2D("Inside");
                }
            }
            else {
                result = new Intersect2D("Intersect");

                if (0<=u1 && u1<=1) result.$points.push(a_1.lerp(a_2, u1));
                if (0<=u2 && u2<=1)result.$points.push(a_1.lerp(a_2, u2));
            }
        }

        return result;
    }

      // 5. circlePolygon ------------------------------

    /**
     * @method  circlePolygon
     * @description  Calculates intersection point(s), if any, between a circle
     *               shape and an polygon shape.
     * @usage  <pre>inst.circlePolygon(c, r, points);</pre>
     * @param   c   (Point)  -- circle center Point object.
     * @param   r   (Number)  -- circle radius value.
     * @param   points   (Array)  -- a holder for polygon vertex Point objects.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function circlePolygon(c:Point, r:Number, points:Array):Intersect2D {
        trace ("$$$$$$$$$$ circlePolygon fired! $$$$$$$$$$");

        var c_0:Point = new Point(c.x, c.y);
        trace ("c_0: "+c_0.x+", "+c_0.y);

        var result:Intersect2D = new Intersect2D("No Intersect");
        var len:Number = points.length;
        var inter:Intersect2D;
        var i:Number;

        for (i=0;i<len;i++) {
            var a_1:Point = points[i];
            var a_2:Point = points[(i+1)%len];

            inter = this.circleLine(c_0, r, a_1, a_2);
            result.appendPoints(inter.$points);
        }

        if (result.$points.length>0) result.$status = "Intersect";
        else result.$status = inter.$status;

        return result;
    }

      // 6. circleRectangle ----------------------------

    /**
     * @method  circleRectangle
     * @description  Calculates intersection point(s), if any, between a circle
     *               shape and a rectangle shape.
     * @usage  <pre>inst.circleRectangle(c, r, r1, r2);</pre>
     * @param   c   (Point)  -- circle center Point object.
     * @param   r   (Number)  -- circle radius value.
     * @param   r1   (Point)  -- rectangle Point object.
     * @param   r2   (Point)  -- rectangle Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function circleRectangle(c:Point, r:Number, r1:Point, r2:Point):Intersect2D {
        trace ("$$$$$$$$$$ circleRectangle2 fired! $$$$$$$$$$");

        var c_0:Point = new Point(c.x, c.y);
        trace ("c_0: "+c_0.x+", "+c_0.y);
        var r_1:Point = new Point(r1.x, r1.y);
        trace ("r_1: "+r_1.x+", "+r_1.y);
        var r_2:Point = new Point(r2.x, r2.y);
        trace ("r_2: "+r_2.x+", "+r_2.y);

        var min:Point = r_1.min(r_2);
        var max:Point = r_1.max(r_2);
        var topRight:Point = new Point(max.x, min.y);
        var bottomLeft:Point = new Point(min.x, max.y);

        var inter1:Intersect2D = this.circleLine(c_0, r, min, topRight);
        var inter2:Intersect2D = this.circleLine(c_0, r, topRight, max);
        var inter3:Intersect2D = this.circleLine(c_0, r, max, bottomLeft);
        var inter4:Intersect2D = this.circleLine(c_0, r, bottomLeft, min);

        var result:Intersect2D = new Intersect2D("No Intersect");

        result.appendPoints(inter1.$points);
        result.appendPoints(inter2.$points);
        result.appendPoints(inter3.$points);
        result.appendPoints(inter4.$points);

        if (result.$points.length>0) result.$status = "Intersect";
        else result.$status = inter1.$status;

        return result;
    }

      // 7. ellipseEllipse -----------------------------

    /**
     * @method  ellipseEllipse
     * @description  Calculates intersection point(s), if any, between two
     *               ellipse shapes.
     * @usage  <pre>inst.ellipseEllipse(c1, rx1, ry1, c2, rx2, ry2);</pre>
     * @param   c1   (Point)  -- ellipse '1' center Point object.
     * @param   rx1   (Number)  -- ellipse '1' x-axis Point object.
     * @param   ry1   (Number)  -- ellipse '1' y-axis Point object.
     * @param   c2   (Point)  -- ellipse '2' center Point object.
     * @param   rx2   (Number)  -- ellipse '2' x-axis Point object.
     * @param   ry2   (Number)  -- ellipse '2' y-axis Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function ellipseEllipse(c1:Point, rx1:Number, ry1:Number, c2:Point, rx2:Number, ry2:Number):Intersect2D {
        trace ("$$$$$$$$$$ ellipseEllipse fired! $$$$$$$$$$");

        var c_1:Point = new Point(c1.x, c1.y);
        trace ("c_1: "+c_1.x+", "+c_1.y);
        var c_2:Point = new Point(c2.x, c2.y);
        trace ("c_2: "+c_2.x+", "+c_2.y);

        var a:Array =
        [
            ry1*ry1, 0, rx1*rx1, -2*ry1*ry1*c_1.x, -2*rx1*rx1*c_1.y,
            ry1*ry1*c_1.x*c_1.x + rx1*rx1*c_1.y*c_1.y - rx1*rx1*ry1*ry1
        ];
        var b:Array =
        [
            ry2*ry2, 0, rx2*rx2, -2*ry2*ry2*c_2.x, -2*rx2*rx2*c_2.y,
            ry2*ry2*c_2.x*c_2.x + rx2*rx2*c_2.y*c_2.y - rx2*rx2*ry2*ry2
        ];

        var yPoly:Polynomial = this.bezout(a, b);
        var yRoots:Array = yPoly.getRoots();
        var epsilon:Number = 1e-3;
        var norm0:Number = (a[0]*a[0]+2*a[1]*a[1]+a[2]*a[2])*epsilon;
        var norm1:Number = (b[0]*b[0]+2*b[1]*b[1]+b[2]*b[2])*epsilon;
        var result:Intersect2D = new Intersect2D("No Intersect");
        var x:Number, y:Number;

        for (y=0;y<yRoots.length;y++) {
            var xPoly:Polynomial = new Polynomial(a[0], a[3]+yRoots[y]*a[1], a[5]+yRoots[y]*(a[4]+yRoots[y]*a[2]));
            var xRoots:Array = xPoly.getRoots();

            for (x=0;x<xRoots.length;x++) {
                var test:Number = (a[0]*xRoots[x]+a[1]*yRoots[y]+a[3])*xRoots[x]+(a[2]*yRoots[y]+a[4])*yRoots[y]+a[5];
                if (Math.abs(test)<norm0) {
                    test = (b[0]*xRoots[x]+b[1]*yRoots[y]+b[3])*xRoots[x]+(b[2]*yRoots[y]+b[4])*yRoots[y]+b[5];
                    if (Math.abs(test)<norm1) {
                        result.appendPoint(new Point(xRoots[x], yRoots[y]));
                    }
                }
            }
        }

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 8. ellipseLine --------------------------------

    /**
     * @method  ellipseLine
     * @description  Calculates intersection point(s), if any, between an ellipse
     *               shape and a line segment shape.
     * @usage  <pre>inst.ellipseLine(c, rx, ry, a1, a2);</pre>
     * @param   c   (Point)  -- ellipse center Point object.
     * @param   rx   (Number)  -- ellipse x-axis Point object.
     * @param   ry   (Number)  -- ellipse y-axis Point object.
     * @param   a1   (Point)  -- start segment Point object.
     * @param   a2   (Point)  -- end segment Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function ellipseLine(c:Point, rx:Number, ry:Number, a1:Point, a2:Point):Intersect2D {
        trace ("$$$$$$$$$$ ellipseLine fired! $$$$$$$$$$");

        var c_0:Point = new Point(c.x, c.y);
        trace ("c_0: "+c_0.x+", "+c_0.y);
        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);

        var result:Intersect2D;
        var origin:Vector = new Vector(a_1.x, a_1.y);
        var dir:Vector = origin.fromPointVals(a_1.x, a_2.x, a_1.y, a_2.y); // kludge
        var center:Vector = new Vector(c_0.x, c_0.y);
        var diff:Vector = origin.subtract(center);
        var mDir:Vector = new Vector(dir.x/(rx*rx), dir.y/(ry*ry));
        var mDiff:Vector = new Vector(diff.x/(rx*rx), diff.y/(ry*ry));

        var a:Number = dir.dotProduct(mDir);
        var b:Number = dir.dotProduct(mDiff);
        // FIXME -- this used to say 
        // var c:Number = diff.dotProduct(mDiff)-1.0; 
        // before the AS2 -> AS3 transition
        var c_diff:Number = diff.dotProduct(mDiff)-1.0; 
        var d:Number = b*b-a*c_diff;

        if (d<0) {
            result = new Intersect2D("Outside");
        }
        else if (d>0) {

            var root:Number = Math.sqrt(d);
            var t_a:Number = (-b-root)/a;
            var t_b:Number = (-b+root)/a;

            if ((t_a<0 || 1<t_a) && (t_b<0 || 1<t_b)) {
                if ((t_a<0 && t_b<0) || (t_a>1 && t_b>1)) result = new Intersect2D("Outside");
                else result = new Intersect2D("Inside");
            }
            else {
                result = new Intersect2D("Intersect");
                if (0<=t_a && t_a<=1) result.appendPoint(a_1.lerp(a_2, t_a));
                if (0<=t_b && t_b<=1) result.appendPoint(a_1.lerp(a_2, t_b));
            }
        }
        else {
            var t:Number = -b/a;

            if (0<=t && t<=1) {
                result = new Intersect2D("Intersect");
                result.appendPoint(a_1.lerp(a_2, t));
            }
            else {
                result = new Intersect2D("Outside");
            }
        }

        return result;
    }

      // 9. ellipsePolygon -----------------------------

    /**
     * @method  ellipsePolygon
     * @description  Calculates intersection point(s), if any, between an ellipse
     *               shape and a polygon shape.
     * @usage  <pre>inst.ellipsePolygon(c, rx, ry, points);</pre>
     * @param   c   (Point)  -- ellipse center Point object.
     * @param   rx   (Number)  -- ellipse x-axis Point object.
     * @param   ry   (Number)  -- ellipse y-axis Point object.
     * @param   points   (Array)  -- a holder for polygon vertex Point objects.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function ellipsePolygon(c:Point, rx:Number, ry:Number, points:Array):Intersect2D {
        trace ("$$$$$$$$$$ ellipsePolygon fired! $$$$$$$$$$");

        var c_0:Point = new Point(c.x, c.y);
        trace ("c_0: "+c_0.x+", "+c_0.y);

        var result:Intersect2D = new Intersect2D("No Intersect");
        var len:Number = points.length;
        var i:Number;

        for (i=0;i<len;i++) {
            var b_1:Point = points[i];
            var b_2:Point = points[(i+1)%len];
            var inter:Intersect2D = this.ellipseLine(c_0, rx, ry, b_1, b_2);

            result.appendPoints(inter.$points);
        }

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 10. ellipseRectangle ---------------------------

    /**
     * @method  ellipseRectangle
     * @description  Calculates intersection point(s), if any, between an ellipse
     *               shape and a rectangle shape.
     * @usage  <pre>inst.ellipseRectangle(c, rx, ry, r1, r2);</pre>
     * @param   c   (Point)  -- ellipse center Point object.
     * @param   rx   (Number)  -- ellipse x-axis Point object.
     * @param   ry   (Number)  -- ellipse y-axis Point object.
     * @param   r1   (Point)  -- rectangle Point object.
     * @param   r2   (Point)  -- rectangle Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function ellipseRectangle(c:Point, rx:Number, ry:Number, r1:Point, r2:Point):Intersect2D {
        trace ("$$$$$$$$$$ ellipseRectangle fired! $$$$$$$$$$");

        var c_0:Point = new Point(c.x, c.y);
        trace ("c_0: "+c_0.x+", "+c_0.y);
        var r_1:Point = new Point(r1.x, r1.y);
        trace ("r_1: "+r_1.x+", "+r_1.y);
        var r_2:Point = new Point(r2.x, r2.y);
        trace ("r_2: "+r_2.x+", "+r_2.y);

        var min:Point = r_1.min(r_2);
        var max:Point = r_1.max(r_2);
        var topRight:Point = new Point(max.x, min.y);
        var bottomLeft:Point = new Point(min.x, max.y);

        var inter1:Intersect2D = this.ellipseLine(c_0, rx, ry, min, topRight);
        var inter2:Intersect2D = this.ellipseLine(c_0, rx, ry, topRight, max);
        var inter3:Intersect2D = this.ellipseLine(c_0, rx, ry, max, bottomLeft);
        var inter4:Intersect2D = this.ellipseLine(c_0, rx, ry, bottomLeft, min);

        var result:Intersect2D = new Intersect2D("No Intersect");

        result.appendPoints(inter1.$points);
        result.appendPoints(inter2.$points);
        result.appendPoints(inter3.$points);
        result.appendPoints(inter4.$points);

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

}// class
}//package

