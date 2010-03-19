package com.vizsage.as3mathlib.math.geom.intersect2D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez2
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Intersect2DBez2 Class. This
 *              class extends Intersect2D superclass.
 * @usage       <pre>var inst:Intersect2DBez2 = new Intersect2DBez2(status);</pre>
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
 *       Intersect2DBez2()
 *             1.  init(status)
 *             2.  bez2Bez2(a1, a2, a3, b1, b2, b3)
 *             3.  bez2Bez3(a1, a2, a3, b1, b2, b3, b4)
 *             4.  bez2Circle(p1, p2, p3, c, r)
 *             5.  bez2Ellipse(p1, p2, p3, ec, rx, ry)
 *             6.  bez2Line(p1, p2, p3, a1, a2)
 *             7.  bez2Polygon(p1, p2, p3, points)
 *             8.  bez2Rectangle(p1, p2, p3, r1, r2)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: - presently not functional - testing in progress  //  *** TODO
*         - 491, 547 need work
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Polynomial;
import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D;

public class Intersect2DBez2 extends Intersect2D {
	/**
	 * @property $status (String)  -- an identifier string.
	 * @property $points (Array)  -- a holder for vertex Point objects.
	**/
    /* bad
    public var $status:String;
    public var $points:Array; */

    public function Intersect2DBez2(status:String) {
    	super(status);
        //trace ("Intersect2DBez2 Class loaded");
        if (arguments.length>0) this.init(status);
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Initializes new class instance.
     * @usage  <pre>inst.init(status);</pre>
     * @param   status   (String)  -- an identifier string.
     * @return  (void)
    **/
    private function init(status:String):void {
        $status = status;
        $points = [];
    }

      // 2. bez2Bez2 -----------------------------------

    /**
     * @method  bez2Bez2
     * @description  Calculates intersection point(s), if any, between two quadratic
     *               Bezier shapes.
     * @usage  <pre>inst.bez2Bez2(a1, a2, a3, b1, b2, b3);</pre>
     * @param   a1   (Point)  -- start 'a' Point object.
     * @param   a2   (Point)  -- control 'a' Point object.
     * @param   a3   (Point)  -- end 'a' Point object.
     * @param   b1   (Point)  -- start 'b' Point object.
     * @param   b2   (Point)  -- control 'b' Point object.
     * @param   b3   (Point)  -- end 'b' Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez2Bez2(a1:Point, a2:Point, a3:Point, b1:Point, b2:Point, b3:Point):Intersect2D {
        trace ("$$$$$$$$$$ bez2Bez2 fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("1. a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("2. a_2: "+a_2.x+", "+a_2.y);
        var a_3:Point = new Point(a3.x, a3.y);
        trace ("3. a_3: "+a_3.x+", "+a_3.y);
        var b_1:Point = new Point(b1.x, b1.y);
        trace ("4. b_1: "+b_1.x+", "+b_1.y);
        var b_2:Point = new Point(b2.x, b2.y);
        trace ("5. b_2: "+b_2.x+", "+b_2.y);
        var b_3:Point = new Point(b3.x, b3.y);
        trace ("6. b_3: "+a_3.x+", "+b_3.y)

        var a:Point, b:Point;
        var c12:Point, c11:Point, c10:Point;
        var c22:Point, c21:Point, c20:Point;
        var result:Intersect2D = new Intersect2D("No Intersect");
        var poly:Polynomial;

        a = a_2.multiply(-2);
        trace ("7. a:"+a);
        c12 = a_1.adds(a.adds(a_3));
        trace ("8. c12: "+c12);

        a = a_1.multiply(-2);
        b = a_2.multiply(2);
        trace ("9. a:"+a+", b:"+b);
        c11 = a.adds(b);
        trace ("10. c11: "+c11);

        c10 = new Point(a1.x, a1.y);
        trace ("11. c10: "+c10.x+", "+c10.y);

        a = b_2.multiply(-2);
        trace ("12. a:"+a);
        c22 = b_1.adds(a.adds(b_3));
        trace ("13. c22: "+c22);

        a = b_1.multiply(-2);
        b = b_2.multiply(2);
        trace ("14. a:"+a+", b:"+b);
        c21 = a.adds(b);
        trace ("15. c21: "+c21);

        c20 = new Point(b1.x, b1.y);
        trace ("16. c20: "+c20.x+", "+c20.y);

		var v0:Number = NaN, v1:Number = NaN, v2:Number = NaN, v3:Number = NaN, v4:Number = NaN, v5:Number = NaN, v6:Number = NaN;
        if (c12.y==0) {
            v0 = c12.x*(c10.y-c20.y);
            v1 = v0-c11.x*c11.y;
            v2 = v0+v1;
            v3 = c11.y*c11.y;
            trace ("17. v0:"+v0+", v1:"+v1+", v2:"+v2+", v3:"+v3);

            poly = new Polynomial
            (
                c12.x*c22.y*c22.y,
                2*c12.x*c21.y*c22.y,
                c12.x*c21.y*c21.y-c22.x*v3-c22.y*v0-c22.y*v1,
                -c21.x*v3-c21.y*v0-c21.y*v1,
                (c10.x-c20.x)*v3+(c10.y-c20.y)*v1
            );
            trace ("18. poly: "+poly);
        }
        else {
            v0 = c12.x*c22.y-c12.y*c22.x;
            v1 = c12.x*c21.y-c21.x*c12.y;
            v2 = c11.x*c12.y-c11.y*c12.x;
            v3 = c10.y-c20.y;
            v4 = c12.y*(c10.x-c20.x)-c12.x*v3;
            v5 = -c11.y*v2+c12.y*v4;
            v6 = v2*v2;
            trace ("19. v0:"+v0+", v1:"+v1+", v2:"+v2+", v3:"+v3+", v4:"+v4+", v5:"+v5+", v6:"+v6);

            poly = new Polynomial
            (
                v0*v0,
                2*v0*v1,
                (-c22.y*v6+c12.y*v1*v1+c12.y*v0*v4+v0*v5)/c12.y,
                (-c21.y*v6+c12.y*v1*v4+v1*v5)/c12.y,
                (v3*v6+v4*v5)/c12.y
            );
            trace ("20. poly: "+poly);
        }

        var roots:Array = poly.getRoots();
        trace ("21. roots: "+roots.length+", "+roots);
        var i:Number, j:Number, k:Number;

        for (i=0;i<roots.length;i++) {
            var s:Number = roots[i];

            if (0<=s && s<=1) {
                var xRoots:Array = new Polynomial(c12.x, c11.x, c10.x-c20.x-s*c21.x-s*s*c22.x).getRoots();
                var yRoots:Array = new Polynomial(c12.y, c11.y, c10.y-c20.y-s*c21.y-s*s*c22.y).getRoots();

                if (xRoots.length>0 && yRoots.length>0) {
                    var TOLERANCE:Number = 1e-4;

                    for (j=0;j<xRoots.length;j++) {
                        var xRoot:Number = xRoots[j];

                        if (0<=xRoot && xRoot<=1) {
                            for (k=0;k<yRoots.length;k++) {
                                if (Math.abs(xRoot-yRoots[k])<TOLERANCE) {
                                    result.$points.push(c22.multiply(s*s).adds(c21.multiply(s).adds(c20)));
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 3. bez2Bez3 -----------------------------------

    /**
     * @method  bez2Bez3
     * @description  Calculates intersection point(s), if any, between a quadratic
     *               Bezier shape and a cubic Bezier shape.
     * @usage  <pre>inst.bez2Bez3(a1, a2, a3, b1, b2, b3, b4);</pre>
     * @param   a1   (Point)  -- start 'a' Point object.
     * @param   a2   (Point)  -- control 'a' Point object.
     * @param   a3   (Point)  -- end 'a' Point object.
     * @param   b1   (Point)  -- start 'b' Point object.
     * @param   b2   (Point)  -- control1 'b' Point object.
     * @param   b3   (Point)  -- control2 'b' Point object.
     * @param   b4   (Point)  -- end 'b' Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez2Bez3(a1:Point, a2:Point, a3:Point, b1:Point, b2:Point, b3:Point, b4:Point):Intersect2D {
        trace ("$$$$$$$$$$ bez2Bez3 fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);
        var a_3:Point = new Point(a3.x, a3.y);
        trace ("a_3: "+a_3.x+", "+a_3.y);
        var b_1:Point = new Point(b1.x, b1.y);
        trace ("b_1: "+b_1.x+", "+b_1.y);
        var b_2:Point = new Point(b2.x, b2.y);
        trace ("b_2: "+b_2.x+", "+b_2.y);
        var b_3:Point = new Point(b3.x, b3.y);
        trace ("b_3: "+b_3.x+", "+b_3.y);
        var b_4:Point = new Point(b4.x, b4.y);
        trace ("b_4: "+b_4.x+", "+b_4.y);

        var a:Point, b:Point, c:Point, d:Point;
        var c12:Point, c11:Point, c10:Point;
        var c23:Vector, c22:Vector, c21:Vector, c20:Vector;
        var result:Intersect2D = new Intersect2D("No Intersect");

        a = a_2.multiply(-2);
        trace ("a:"+a);
        c12 = a_1.adds(a.adds(a_3));
        trace ("c12:"+c12);

        a = a_1.multiply(-2);
        b = a_2.multiply(2);
        trace ("a:"+a+", b:"+b);
        c11 = a.adds(b);
        trace ("c11:"+c11);

        c10 = new Point(a_1.x, a_1.y);
        trace ("c10:"+c10.toString());

        a = b_1.multiply(-1);
        b = b_2.multiply(3);
        c = b_3.multiply(-3);
        d = a.adds(b.adds(c.adds(b_4)));
        trace ("a:"+a+", b:"+b+", c:"+c+", d:"+d);
        c23 = new Vector(d.x, d.y);
        trace ("c23:"+c23.x+", "+c23.y);

        a = b_1.multiply(3);
        b = b_2.multiply(-6);
        c = b_3.multiply(3);
        d = a.adds(b.adds(c));
        trace ("a:"+a+", b:"+b+", c:"+c+", d:"+d);
        c22 = new Vector(d.x, d.y);
        trace ("c22:"+c22.x+", "+c22.y);

        a = b_1.multiply(-3);
        b = b_2.multiply(3);
        c = a.adds(b);
        trace ("a:"+a+", b:"+b+", c:"+c);
        c21 = new Vector(c.x, c.y);
        trace ("c21:"+c21.x+", "+c21.y);

        c20 = new Vector(b_1.x, b_1.y);
        trace ("c20:"+c20.x+", "+c20.y);

        var c10x2:Number = c10.x*c10.x;
        var c10y2:Number = c10.y*c10.y;
        var c11x2:Number = c11.x*c11.x;
        var c11y2:Number = c11.y*c11.y;
        var c12x2:Number = c12.x*c12.x;
        var c12y2:Number = c12.y*c12.y;
        var c20x2:Number = c20.x*c20.x;
        var c20y2:Number = c20.y*c20.y;
        var c21x2:Number = c21.x*c21.x;
        var c21y2:Number = c21.y*c21.y;
        var c22x2:Number = c22.x*c22.x;
        var c22y2:Number = c22.y*c22.y;
        var c23x2:Number = c23.x*c23.x;
        var c23y2:Number = c23.y*c23.y;

        var poly:Polynomial = new Polynomial
        (
             -2*c12.x*c12.y*c23.x*c23.y + c12x2*c23y2 + c12y2*c23x2,
             -2*c12.x*c12.y*c22.x*c23.y - 2*c12.x*c12.y*c22.y*c23.x + 2*c12y2*c22.x*c23.x +
                 2*c12x2*c22.y*c23.y,
             -2*c12.x*c21.x*c12.y*c23.y - 2*c12.x*c12.y*c21.y*c23.x - 2*c12.x*c12.y*c22.x*c22.y +
                 2*c21.x*c12y2*c23.x + c12y2*c22x2 + c12x2*(2*c21.y*c23.y + c22y2),
             2*c10.x*c12.x*c12.y*c23.y + 2*c10.y*c12.x*c12.y*c23.x + c11.x*c11.y*c12.x*c23.y +
                 c11.x*c11.y*c12.y*c23.x - 2*c20.x*c12.x*c12.y*c23.y - 2*c12.x*c20.y*c12.y*c23.x -
                 2*c12.x*c21.x*c12.y*c22.y - 2*c12.x*c12.y*c21.y*c22.x - 2*c10.x*c12y2*c23.x -
                 2*c10.y*c12x2*c23.y + 2*c20.x*c12y2*c23.x + 2*c21.x*c12y2*c22.x -
                 c11y2*c12.x*c23.x - c11x2*c12.y*c23.y + c12x2*(2*c20.y*c23.y + 2*c21.y*c22.y),
             2*c10.x*c12.x*c12.y*c22.y + 2*c10.y*c12.x*c12.y*c22.x + c11.x*c11.y*c12.x*c22.y +
                 c11.x*c11.y*c12.y*c22.x - 2*c20.x*c12.x*c12.y*c22.y - 2*c12.x*c20.y*c12.y*c22.x -
                 2*c12.x*c21.x*c12.y*c21.y - 2*c10.x*c12y2*c22.x - 2*c10.y*c12x2*c22.y +
                 2*c20.x*c12y2*c22.x - c11y2*c12.x*c22.x - c11x2*c12.y*c22.y + c21x2*c12y2 +
                 c12x2*(2*c20.y*c22.y + c21y2),
             2*c10.x*c12.x*c12.y*c21.y + 2*c10.y*c12.x*c21.x*c12.y + c11.x*c11.y*c12.x*c21.y +
                 c11.x*c11.y*c21.x*c12.y - 2*c20.x*c12.x*c12.y*c21.y - 2*c12.x*c20.y*c21.x*c12.y -
                 2*c10.x*c21.x*c12y2 - 2*c10.y*c12x2*c21.y + 2*c20.x*c21.x*c12y2 -
                 c11y2*c12.x*c21.x - c11x2*c12.y*c21.y + 2*c12x2*c20.y*c21.y,
             -2*c10.x*c10.y*c12.x*c12.y - c10.x*c11.x*c11.y*c12.y - c10.y*c11.x*c11.y*c12.x +
                 2*c10.x*c12.x*c20.y*c12.y + 2*c10.y*c20.x*c12.x*c12.y + c11.x*c20.x*c11.y*c12.y +
                 c11.x*c11.y*c12.x*c20.y - 2*c20.x*c12.x*c20.y*c12.y - 2*c10.x*c20.x*c12y2 +
                 c10.x*c11y2*c12.x + c10.y*c11x2*c12.y - 2*c10.y*c12x2*c20.y -
                 c20.x*c11y2*c12.x - c11x2*c20.y*c12.y + c10x2*c12y2 + c10y2*c12x2 +
                 c20x2*c12y2 + c12x2*c20y2
        );

        trace ("poly:"+poly);
        var roots:Array = poly.getRootsInInterval(0, 1);
        trace ("roots: "+roots.length+", "+roots);
        var i:Number, j:Number, k:Number;

        for (i=0;i<roots.length;i++) {
            var s:Number = roots[i];
            trace ("s: "+s);
            var xRoots:Array = new Polynomial(c12.x, c11.x, c10.x-c20.x-s*c21.x-s*s*c22.x-s*s*s*c23.x).getRoots();
            var yRoots:Array = new Polynomial(c12.y, c11.y, c10.y-c20.y-s*c21.y-s*s*c22.y-s*s*s*c23.y).getRoots();
            trace ("xRoots: "+xRoots.length+", "+xRoots);
            trace ("yRoots: "+yRoots.length+", "+yRoots);

            if (xRoots.length>0 && yRoots.length>0) {
                var TOLERANCE:Number = 1e-4;

                for (j=0;j<xRoots.length;j++) {
                    var xRoot:Number = xRoots[j];

                    if (0<=xRoot && xRoot<=1) {
                        for (k=0;k<yRoots.length;k++) {
                            if (Math.abs(xRoot-yRoots[k])<TOLERANCE) {
                                // the use of Vector.scalar returns undefined, so I replaced it with returnScalar
                                //result.$points.push(c23.scalar(s*s*s).adds(c22.scalar(s*s).adds(c21.scalar(s).adds(c20))));
                                result.$points.push(c23.returnScalar(s*s*s).adds(c22.returnScalar(s*s).adds(c21.returnScalar(s).adds(c20))));
                                break;
                            }
                        }
                    }
                }
            }
        }
        if (result.$points.length>0) result.$status = "Intersect";
        trace ("bez2Bez3$$ result.$points: "+result.$points.length+", "+result.$points[0].x+", "+result.$points[0].y+", "+result.$points[1].x+", "+result.$points[1].y);

        return result;
    }

      // 4. bez2Circle ---------------------------------

    /**
     * @method  bez2Circle
     * @description  Calculates intersection point(s), if any, between a quadratic
     *               Bezier shape and a circle shape.
     * @usage  <pre>inst.bez2Circle(p1, p2, p3, c, r);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control Point object.
     * @param   p3   (Point)  -- end Point object.
     * @param   c   (Point)  -- circle center Point object.
     * @param   r   (Number)  -- a radius value.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez2Circle(p1:Point, p2:Point, p3:Point, c:Point, r:Number):Intersect2D {
        trace ("$$$$$$$$$$ bez2Circle fired! $$$$$$$$$$");

        return this.bez2Ellipse(p1, p2, p3, c, r, r);
    }

      // 5. bez2Ellipse --------------------------------

    /**
     * @method  bez2Ellipse
     * @description  Calculates intersection point(s), if any, between a quadratic
     *               Bezier shape and an ellipse shape.
     * @usage  <pre>inst.bez2Ellipse(p1, p2, p3, ec, rx, ry);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control Point object.
     * @param   p3   (Point  -- end Point object.
     * @param   ec   (Point)  -- ellipse center Point object.
     * @param   rx   (Number)  -- x-axis radius value.
     * @param   ry   (Number)  -- y-axis radius value.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez2Ellipse(p1:Point, p2:Point, p3:Point, ec:Point, rx:Number, ry:Number):Intersect2D {
        trace ("$$$$$$$$$$ bez2Ellipse fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var e_c:Point = new Point(ec.x, ec.y);
        trace ("e_c: "+e_c.x+", "+e_c.y);

        var a:Point, b:Point;
        var c2:Point, c1:Point, c0:Point;
        var result:Intersect2D = new Intersect2D("No Intersect");

        a = p_2.multiply(-2);
        c2 = p_1.adds(a.adds(p_3));

        a = p_1.multiply(-2);
        b = p_2.multiply(2);
        c1 = a.adds(b);

        c0 = new Point(p_1.x, p_1.y);

        var rxrx:Number = rx*rx;
        var ryry:Number = ry*ry;
        var roots:Array = new Polynomial
        (
            ryry*c2.x*c2.x+rxrx*c2.y*c2.y,
            2*(ryry*c2.x*c1.x+rxrx*c2.y*c1.y),
            ryry*(2*c2.x*c0.x+c1.x*c1.x)+rxrx*(2*c2.y*c0.y+c1.y*c1.y)-2*(ryry*e_c.x*c2.x+rxrx*e_c.y*c2.y),
            2*(ryry*c1.x*(c0.x-e_c.x)+rxrx*c1.y*(c0.y-e_c.y)),
            ryry*(c0.x*c0.x+e_c.x*e_c.x)+rxrx*(c0.y*c0.y+e_c.y*e_c.y)-2*(ryry*e_c.x*c0.x+rxrx*e_c.y*c0.y)-rxrx*ryry
        ).getRoots();

        var i:Number;

        for (i=0;i<roots.length;i++) {
            var t:Number = roots[i];

            // there's no scalar in Point class, so I replaced it with multiplyEquals
            if (0<=t && t<=1) result.$points.push(c2.multiplyEquals(t*t).adds(c1.multiplyEquals(t).adds(c0)));
            //if (0<=t && t<=1) result.$points.push(c2.scalar(t*t).adds(c1.scalar(t).adds(c0)));
        }

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 6. bez2Line -----------------------------------

    /**
     * @method  bez2Line
     * @description  Calculates intersection point(s), if any, between a quadratic
     *               Bezier shape and a line segment shape.
     * @usage  <pre>inst.bez2Line(p1, p2, p3, a1, a2);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control Point object.
     * @param   p3   (Point)  -- end Point object.
     * @param   a1   (Point)  -- start segment Point object.
     * @param   a2   (Point)  -- end segment Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez2Line(p1:Point, p2:Point, p3:Point, a1:Point, a2:Point):Intersect2D {
        trace ("$$$$$$$$$$ bez2Line fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);


        var a:Point, b:Point;
        var c2:Point, c1:Point, c0:Point;
        var cl:Number;                  // c coefficient for normal form of line
        var n:Vector;                   // normal for normal form of line
        var min:Point = a_1.min(a_2);   // used to determine if point is on line segment
        var max:Point = a_1.max(a_2);   // used to determine if point is on line segment
        var result:Intersect2D = new Intersect2D("No Intersect");

        a = p_2.multiply(-2);
        c2 = p_1.adds(a.adds(p_3));

        a = p_1.multiply(-2);
        b = p_2.multiply(2);
        c1 = a.adds(b);

        c0 = new Point(p_1.x, p_1.y);

        // Convert line to normal form: ax + by + c = 0
        // Find normal to line: negative inverse of original line's slope
        n = new Vector(a_1.y-a_2.y, a_2.x-a_1.x);

        // Determine new c coefficient
        cl = a_1.x*a_2.y-a_2.x*a_1.y;

        // Transform cubic coefficients to line's coordinate system
        // and find roots of cubic
        //var rootsPoly = new Polynomial(n.dotProduct(c2), n.dotProduct(c1), n.dotProduct(c0))+cl); // *** TODO
        var roots:Array; // = rootsPoly.getRoots();
        var i:Number;

        // Any roots in closed interval [0, 1] are intersections on Bez, but
        // might not be on the line segment.
        // Find intersections and calculate point coordinates
        for (i=0;i<roots.length;i++) {
            var t:Number = roots[i];

            if (0<=t && t<=1) {
                // We're within the Bez curve
                // Find point on Bez
                var p_4:Point = p_1.lerp(p_2, t);
                var p_5:Point = p_2.lerp(p_3, t);
                var p_6:Point = p_4.lerp(p_5, t);

                // See if point is on line segment
                // Had to make special cases for vertical and horizontal lines due
                // to slight errors in calculation of p6
                if (a_1.x==a_2.x) {
                    if (min.y<=p_6.y && p_6.y<=max.y) {
                        result.$status = "Intersect";
                        result.appendPoint(p_6);
                    }
                }
                else if (a_1.y==a_2.y) {
                    if (min.x<=p_6.x && p_6.x<=max.x) {
                        result.$status = "Intersect";
                        result.appendPoint(p_6);
                    }
                }
                else if (p_6.greaterThanEq(min) && p_6.lessThanEq(max)) {
                    result.$status = "Intersect";
                    result.appendPoint(p_6);
                }
            }
        }

        return result;
    }

      // 7. bez2Polygon --------------------------------

    /**
     * @method  bez2Polygon
     * @description  Calculates intersection point(s), if any, between a quadratic
     *               Bezier shape and a polygon shape.
     * @usage  <pre>inst.bez2Polygon(p1, p2, p3, points);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control Point object.
     * @param   p3   (Point)  -- end Point object.
     * @param   points   (Array)  -- holder for polygon vertex Point objects.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez2Polygon(p1:Point, p2:Point, p3:Point, points:Array):Intersect2D {
        trace ("$$$$$$$$$$ bez2Polygon fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var i:Number, j:Number;

        for (j=0;j<points.length;j++) {
            this["p_"+(j+4)] = new Point(points[j].x, points[j].y);     // *** TODO
            trace (this["p_"+(j+4)].toString());
        }

        var result:Intersect2D = new Intersect2D("No Intersect");
        var len:Number = points.length;

        for (i=0;i<len;i++) {
            var a_1:Point = points[i];
            var a_2:Point = points[(i+1)%len];
            var inter:Intersect2D = this.bez2Line(p_1, p_2, p_3, a_1, a_2);

            result.appendPoints(inter.$points);
        }
        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 8. bez2Rectangle ------------------------------

    /**
     * @method  bez2Rectangle
     * @description  Calculates intersection point(s), if any, between a quadratic
     *               Bezier shape and a rectangle shape.
     * @usage  <pre>inst.bez2Rectangle(p1, p2, p3, r1, r2);</pre>
     * @param   p1   (Point)  -- start Point object.
     * @param   p2   (Point)  -- control Point object.
     * @param   p3   (Point)  -- end Point object.
     * @param   r1   (Point)  -- rectangle Point object.
     * @param   r2   (Point)  -- rectangle Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function bez2Rectangle(p1:Point, p2:Point, p3:Point, r1:Point, r2:Point):Intersect2D {
        trace ("$$$$$$$$$$ bez2Rectangle fired! $$$$$$$$$$");

        var p_1:Point = new Point(p1.x, p1.y);
        trace ("p_1: "+p_1.x+", "+p_1.y);
        var p_2:Point = new Point(p2.x, p2.y);
        trace ("p_2: "+p_2.x+", "+p_2.y);
        var p_3:Point = new Point(p3.x, p3.y);
        trace ("p_3: "+p_3.x+", "+p_3.y);
        var r_1:Point = new Point(r1.x, r1.y);
        trace ("r_1: "+r_1.x+", "+r_1.y);
        var r_2:Point = new Point(r2.x, r2.y);
        trace ("r_2: "+r_2.x+", "+r_2.y);

        var min:Point = r_1.min(r_2);
        var max:Point = r_1.max(r_2);
        var topRight:Point = new Point(max.x, min.y);
        var bottomLeft:Point = new Point(min.x, max.y);

        var inter1:Intersect2D = this.bez2Line(p_1, p_2, p_3, min, topRight);
        var inter2:Intersect2D = this.bez2Line(p_1, p_2, p_3, topRight, max);
        var inter3:Intersect2D = this.bez2Line(p_1, p_2, p_3, max, bottomLeft);
        var inter4:Intersect2D = this.bez2Line(p_1, p_2, p_3, bottomLeft, min);

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

