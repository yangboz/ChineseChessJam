package com.vizsage.as3mathlib.math.geom.intersect2D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DLine
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Intersect2DLine Class. This
 *              class extends Intersect2D superclass.
 * @usage       <pre>var inst:Intersect2DLine = new Intersect2DLine(status);</pre>
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
 *       Intersect2DLine()
 *             1.  init(status)
 *             2.  lineLine(a1, a2, b1, b2)
 *             3.  linePolygon(a1, a2, points)
 *             4.  lineRectangle(a1, a2, r1, r2)
 *             5.  polygonPolygon(points1, points2)
 *             6.  polygonRectangle(points, r1, r2)
 *             7.  rayRay(a1, a2, b1, b2)
 *             8.  lineRay(a1, a2, b1, b2)
 *             9.  rectangleRectangle(a1, a2, b1, b2)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Point;
import com.vizsage.as3mathlib.math.alg.Polynomial;
import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D;

public class Intersect2DLine extends Intersect2D {

    public function Intersect2DLine(status:String) {
    	super(status);
        trace ("Intersect2DLine Class loaded");
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

      // 2. lineLine -----------------------------------

    /**
     * @method  lineLine
     * @description  Calculates intersection point, if any, between two line
     *               segment shapes.
     * @usage  <pre>inst.lineLine(a1, a2, b1, b2);</pre>
     * @param   a1   (Point)  -- start segment 'a' Point object.
     * @param   a2   (Point)  -- end segment 'a' Point object.
     * @param   b1   (Point)  -- start segment 'b' Point object.
     * @param   b2   (Point)  -- end segment 'b' Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function lineLine(a1:Point, a2:Point, b1:Point, b2:Point):Intersect2D {
        trace ("$$$$$$$$$$ lineLine fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);
        var b_1:Point = new Point(b1.x, b1.y);
        trace ("b_1: "+b_1.x+", "+b_1.y);
        var b_2:Point = new Point(b2.x, b2.y);
        trace ("b_2: "+b_2.x+", "+b_2.y);

        var result:Intersect2D;

        var ua_t:Number = (b_2.x-b_1.x)*(a_1.y-b_1.y)-(b_2.y-b_1.y)*(a_1.x-b_1.x);
        var ub_t:Number = (a_2.x-a_1.x)*(a_1.y-b_1.y)-(a_2.y-a_1.y)*(a_1.x-b_1.x);
        var u_b:Number = (b_2.y-b_1.y)*(a_2.x-a_1.x)-(b_2.x-b_1.x)*(a_2.y-a_1.y);

        trace ("ua_t: "+ua_t);
        trace ("ub_t: "+ub_t);
        trace ("u_b: "+u_b);

        if (u_b!=0) {
            trace ("1. u_b!=0");
            var ua:Number = ua_t/u_b;
            var ub:Number = ub_t/u_b;

            if (ua>=0 && ua<=1 && ub>=0 && ub<=1) {
                trace ("1a. 0>-ua, ub<=1");
                result = new Intersect2D("Intersect");
                result.$points.push(new Point(a1.x+ua*(a_2.x-a_1.x), a_1.y+ua*(a_2.y-a_1.y)));
            }
            else {
                trace ("1b. 0<ua, ub>1");
                result = new Intersect2D("No Intersect");
            }
        }
        else {
            trace ("2. u_b==0");
            if (ua_t==0 || ub_t==0) {
                trace ("2a. ua_t==0 || ub_t==0");
                result = new Intersect2D("Coincident");
            }
            else {
                trace ("2b. else");
                result = new Intersect2D("Parallel");
            }
        }
        trace ("result.$points: "+result.$points+", x: "+result.$points[0].x+", y: "+result.$points[0].y);

        return result;
    }

      // 3. linePolygon --------------------------------

    /**
     * @method  linePolygon
     * @description  Calculates intersection point(s), if any, between a line
     *               segment shape and a polygon shape.
     * @usage  <pre>inst.linePolygon(a1, a2, points);</pre>
     * @param   a1   (Point)  -- start segment Point object.
     * @param   a2   (Point)  -- end segment Point object.
     * @param   points   (Array)  -- a holder for polygon Point objects.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function linePolygon(a1:Point, a2:Point, points:Array):Intersect2D {
        trace ("$$$$$$$$$$ linePolygon fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);

        var result:Intersect2D = new Intersect2D("No Intersect");
        var len:Number = points.length;
        var i:Number;

        for (i=0;i<len;i++) {
            var b_1:Point = points[i];
            var b_2:Point = points[(i+1)%len];
            var inter:Intersect2D = this.lineLine(a_1, a_2, b_1, b_2);

            result.appendPoints(inter.$points);
        }

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 4. lineRectangle ------------------------------

    /**
     * @method  lineRectangle
     * @description  Calculates intersection point(s), if any, between a line
     *               segment shape and a rectangle shape.
     * @usage  <pre>inst.lineRectangle(a1, a2, r1, r2);</pre>
     * @param   a1   (Point)  -- start segment Point object.
     * @param   a2   (Point)  -- start segment Point object.
     * @param   r1   (Point)  -- start rectangle Point object.
     * @param   r2   (Point)  -- start rectangle Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function lineRectangle(a1:Point, a2:Point, r1:Point, r2:Point):Intersect2D {
        trace ("$$$$$$$$$$ lineRectangle fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);
        var r_1:Point = new Point(r1.x, r1.y);
        trace ("r_1: "+r_1.x+", "+r_1.y);
        var r_2:Point = new Point(r2.x, r2.y);
        trace ("r_2: "+r_2.x+", "+r_2.y);

        var min:Point = r_1.min(r_2);
        var max:Point = r_1.max(r_2);
        var topRight:Point = new Point(max.x, min.y);
        var bottomLeft:Point = new Point(min.x, max.y);

        var inter1:Intersect2D = this.lineLine(min, topRight, a_1, a_2);
        var inter2:Intersect2D = this.lineLine(topRight, max, a_1, a_2);
        var inter3:Intersect2D = this.lineLine(max, bottomLeft, a_1, a_2);
        var inter4:Intersect2D = this.lineLine(bottomLeft, min, a_1, a_2);

        var result:Intersect2D = new Intersect2D("No Intersect");

        result.appendPoints(inter1.$points);
        result.appendPoints(inter2.$points);
        result.appendPoints(inter3.$points);
        result.appendPoints(inter4.$points);

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 5. polygonPolygon -----------------------------

    /**
     * @method  polygonPolygon
     * @description  Calculates intersection point(s), if any, between two
     *               polygon shapes.
     * @usage  <pre>inst.polygonPolygon(points1, points2);</pre>
     * @param   points1   (Array)  -- a holder for polygon 'a' Point objects.
     * @param   points2   (Array)  -- a holder for polygon 'b' Point objects.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function polygonPolygon(points1:Array, points2:Array):Intersect2D {
        trace ("$$$$$$$$$$ polygonPolygon fired! $$$$$$$$$$");

        var result:Intersect2D = new Intersect2D("No Intersect");
        var len:Number = points1.length;
        var i:uint;

        for (i=0;i<len;i++) {
            var a_1:Point = points1[i];
            var a_2:Point = points1[(i+1)%len];
            var inter:Intersect2D = this.linePolygon(a_1, a_2, points2);

            result.appendPoints(inter.$points);
        }
        if (result.$points.length>0) result.$status = "Intersect";

        return result;

    }

      // 6. polygonRectangle ---------------------------

    /**
     * @method  polygonRectangle
     * @description  Calculates intersection point(s), if any, between a polygon
     *               shape and a rectangle shape.
     * @usage  <pre>inst.polygonRectangle(points, r1, r2);</pre>
     * @param   points   (Array)  -- a holder for polygon 'a' Point objects.
     * @param   r1   (Point)  -- a rectangle Point object.
     * @param   r2   (Point)  -- a rectangle Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function polygonRectangle(points:Array, r1:Point, r2:Point):Intersect2D {
        trace ("$$$$$$$$$$ polygonRectangle fired! $$$$$$$$$$");

        var r_1:Point = new Point(r1.x, r1.y);
        trace ("r_1: "+r_1.x+", "+r_1.y);
        var r_2:Point = new Point(r2.x, r2.y);
        trace ("r_2: "+r_2.x+", "+r_2.y);

        var min:Point = r_1.min(r_2);
        var max:Point = r_1.max(r_2);
        var topRight:Point = new Point(max.x, min.y);
        var bottomLeft:Point = new Point(min.x, max.y);
        var inter1:Intersect2D = this.linePolygon(min, topRight, points);
        var inter2:Intersect2D = this.linePolygon(topRight, max, points);
        var inter3:Intersect2D = this.linePolygon(max, bottomLeft, points);
        var inter4:Intersect2D = this.linePolygon(bottomLeft, min, points);
        var result:Intersect2D = new Intersect2D("No Intersect");

        result.appendPoints(inter1.$points);
        result.appendPoints(inter2.$points);
        result.appendPoints(inter3.$points);
        result.appendPoints(inter4.$points);

        if (result.$points.length>0) result.$status = "Intersect";

        return result;
    }

      // 7. rayRay -------------------------------------

    /**
     * @method  rayRay
     * @description  Calculates intersection point, if any, between two infinite
     *               ray shapes.
     * @usage  <pre>inst.rayRay(a1, a2, b1, b2);</pre>
     * @param   a1   (Point)  -- a ray 'a' Point object.
     * @param   a2   (Point)  -- a ray 'a' Point object.
     * @param   b1   (Point)  -- a ray 'b' Point object.
     * @param   b2   (Point)  -- a ray 'b' Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function rayRay(a1:Point, a2:Point, b1:Point, b2:Point):Intersect2D {
        trace ("$$$$$$$$$$ rayRay fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);
        var b_1:Point = new Point(b1.x, b1.y);
        trace ("b_1: "+b_1.x+", "+b_1.y);
        var b_2:Point = new Point(b2.x, b2.y);
        trace ("b_2: "+b_2.x+", "+b_2.y);

        var result:Intersect2D;
        var ua_t:Number = (b_2.x-b_1.x)*(a_1.y-b_1.y)-(b_2.y-b_1.y)*(a_1.x-b_1.x);
        var ub_t:Number = (a_2.x-a_1.x)*(a_1.y-b_1.y)-(a_2.y-a_1.y)*(a_1.x-b_1.x);
        var u_b:Number  = (b_2.y-b_1.y)*(a_2.x-a_1.x)-(b_2.x-b_1.x)*(a_2.y-a_1.y);

        if (u_b!=0) {
            var ua:Number = ua_t/u_b;

            result = new Intersect2D("Intersect");
            result.$points.push(new Point(a_1.x+ua*(a_2.x-a_1.x), a_1.y+ua*(a_2.y-a_1.y)));
        }
        else {
            if (ua_t==0 || ub_t==0) {
                result = new Intersect2D("Coincident");
            }
            else {
                result = new Intersect2D("Parallel");
            }
        }

        return result;
    }

      // 8. lineRay ------------------------------------

    /**
     * @method  lineRay
     * @description  Calculates intersection point, if any, between a line
     *               segment shape and an infinite ray shape.
     * @usage  <pre>inst.lineRay(a1, a2, b1, b2);</pre>
     * @param   a1   (Point)  -- a segment Point object.
     * @param   a2   (Point)  -- a segment Point object.
     * @param   b1   (Point)  -- a ray Point object.
     * @param   b2   (Point)  -- a ray Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function lineRay(a1:Point, a2:Point, b1:Point, b2:Point):Intersect2D {
        trace ("$$$$$$$$$$ lineRay fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);
        var b_1:Point = new Point(b1.x, b1.y);
        trace ("b_1: "+b_1.x+", "+b_1.y);
        var b_2:Point = new Point(b2.x, b2.y);
        trace ("b_2: "+b_2.x+", "+b_2.y);

        var result:Intersect2D;
        var ua_t:Number = (b_2.x-b_1.x)*(a_1.y-b_1.y)-(b_2.y-b_1.y)*(a_1.x-b_1.x);
        var ub_t:Number = (a_2.x-a_1.x)*(a_1.y-b_1.y)-(a_2.y-a_1.y)*(a_1.x-b_1.x);
        var u_b:Number  = (b_2.y-b_1.y)*(a_2.x-a_1.x)-(b_2.x-b_1.x)*(a_2.y-a_1.y);

        if (u_b!=0) {
            var ua:Number = ua_t/u_b;
            var ub:Number = ub_t/u_b;

            if (0<=ua && ua<=1 && 0<=ub && ub<=1) {
                result = new Intersect2D("Intersect");
                result.$points.push(new Point(a_1.x+ua*(a_2.x-a_1.x), a_1.y+ua*(a_2.y-a_1.y)));
            }
            else {
                result = new Intersect2D("No Intersect");
            }
        }
        else {
            if (ua_t==0 || ub_t==0) {
                result = new Intersect2D("Coincident");
            }
            else {
                result = new Intersect2D("Parallel");
            }
        }

        return result;
    }

      // 9. rectangleRectangle -------------------------

    /**
     * @method  rectangleRectangle
     * @description  Calculates intersection point(s), if any, between two
     *               rectangle shapes.
     * @usage  <pre>inst.rectangleRectangle(a1, a2, b1, b2);</pre>
     * @param   a1   (Point)  -- a rectangle 'a' Point object.
     * @param   a2   (Point)  -- a rectangle 'a' Point object.
     * @param   b1   (Point)  -- a rectangle 'b' Point object.
     * @param   b2   (Point)  -- a rectangle 'b' Point object.
     * @return  (Intersect2D)  -- returns a new Intersect2D object.
    **/
    public function rectangleRectangle(a1:Point, a2:Point, b1:Point, b2:Point):Intersect2D {
        trace ("$$$$$$$$$$ rectangleRectangle fired! $$$$$$$$$$");

        var a_1:Point = new Point(a1.x, a1.y);
        trace ("a_1: "+a_1.x+", "+a_1.y);
        var a_2:Point = new Point(a2.x, a2.y);
        trace ("a_2: "+a_2.x+", "+a_2.y);
        var b_1:Point = new Point(b1.x, b1.y);
        trace ("b_1: "+b_1.x+", "+b_1.y);
        var b_2:Point = new Point(b2.x, b2.y);
        trace ("b_2: "+b_2.x+", "+b_2.y);

        var min:Point = a_1.min(a_2);
        var max:Point = a_1.max(a_2);
        var topRight:Point = new Point(max.x, min.y);
        var bottomLeft:Point = new Point(min.x, max.y);
        var inter1:Intersect2D = this.lineRectangle(min, topRight, b_1, b_2);
        var inter2:Intersect2D = this.lineRectangle(topRight, max, b_1, b_2);
        var inter3:Intersect2D = this.lineRectangle(max, bottomLeft, b_1, b_2);
        var inter4:Intersect2D = this.lineRectangle(bottomLeft, min, b_1, b_2);
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

