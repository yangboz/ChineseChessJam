package com.vizsage.as3mathlib.math.geom.curve {
/**
 * @class       com.vizsage.as3mathlib.math.geom.curve.BezQuad
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the BezQuad Class.
 *              <p>
 *		        Supports display of my quadratic Bezier curve testing application's
 *              methodology. Presently, it only supports 2D -- I plan to re-work the
 *              architecture to support 3D definitons, as well as re-factoring for a
 *              more generic class instantiation.
 * @usage       <pre>var inst:BezQuad = new BezQuad();</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.geom.util.Graphic
 *                com.vizsage.as3mathlib.math.alg.Point
 * -----------------------------------------------
 * AS2 revision copyright: � 2003, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright: � 2002, Andres Duran   [http://www.actionscript.cl/]
 * AS1 original copyright: � 2002, Robert Penner  [http://www.robertpenner.com]
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
 *       BezQuad()
 *           1.  quadratic(t, a, b, c)
 *           2.  quadratic2D(t, pt1, pt2, pt3)
 *           3.  points(pt1, pt2, pt3)
 *           4.  segment(pt1, pt2, pt3, t1, t2)
 *           5.  control(t1, t2, a, b, c)
 *           6.  vertex(pt1, pt2, pt3)
 *           7.  symmetryAxis(pt1, pt2, pt3)
 *           8.  angle(t, pt1, pt2, pt3)
 *           9.  derivative(t, a, b, c)
 *           10. projection(pt1, pt2, pt3)
 *           11. focalLength(pt1, pt2, pt3)
 *           12. focus(pt1, pt2, pt3)
 *           13. latusRectum(pt1, pt2, pt3)
 *           14. directrix(pt1, pt2, pt3)
 *           15. bezArea(pt1, pt2, pt3)
 *           16. arcLength(pt1, pt2, pt3)
 *           17. drawTangents(pt1, pt2, pt3)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: - most functions need work to handle 3d - unfinished.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.geom.util.Graphic;
import com.vizsage.as3mathlib.math.alg.Point;

public class BezQuad  {
	/**
	 * @property $p1 (Point)  -- holder for initial start Point object.
	 * @property $p2 (Point)  -- holder for initial control Point object.
	 * @property $p3 (Point)  -- holder for initial end Point object.
	 * @property $b1 (Point)  -- holder for segment start Point object.
	 * @property $b2 (Point)  -- holder for segment control Point object.
	 * @property $b3 (Point)  -- holder for segment end Point object.
	 * @property $sym1 (Point)  -- holder for symmetry axis start Point object.
	 * @property $sym2 (Point)  -- holder for symmetry axis end Point object.
	 * @property $dir1 (Point)  -- holder for directrix start Point object.
	 * @property $dir2 (Point)  -- holder for directrix end Point object.
	 * @property $vm (Number)  -- vertex mean.
	 * @property $vt (Number)  -- vertex scalar.
	 * @property $vx (Number)  -- vertex x-axis position.
	 * @property $vy (Number)  -- vertex y-axis position.
	 * @property $va (Number)  -- vertex angle.
	 * @property $rax (Number)  -- projection point a x-axis position.
	 * @property $ray (Number)  -- projection point a y-axis position.
	 * @property $rbx (Number)  -- projection point b x-axis position.
	 * @property $rby (Number)  -- projection point b y-axis position.
	 * @property $ra (Number)  -- projection distance, start point to vertex.
	 * @property $rb (Number)  -- projection distance, vertex to end point.
	 * @property $alfa (Number)  -- projection ccw-angle from vertex.
	 * @property $beta (Number)  -- projection cw-angle from vertex.
	 * @property $a (Number)  -- focal point length.
	 * @property $fx (Number)  -- focus x-axis position.
	 * @property $fy (Number)  --  focus y-axis position.
	 * @property $arc (Number)  -- quadBez arc length.
	 * @property $area (Number)  -- area defined under quadBez arc.
	**/
    public var $p1:Point, $p2:Point, $p3:Point;
    public var $b1:Point, $b2:Point, $b3:Point;
    public var $sym1:Point, $sym2:Point;
    public var $dir1:Point, $dir2:Point;
    public var $bi1:Point, $bi2:Point, $bi3:Point;
    public var $vm:Number, $vt:Number, $vx:Number, $vy:Number, $va:Number;
    public var $rax:Number, $ray:Number, $rbx:Number, $rby:Number;
    public var $ra:Number, $rb:Number;
    public var $alfa:Number, $beta:Number, $a:Number;
    public var $fx:Number, $fy:Number;
    public var $arc:Number, $area:Number;

    public function BezQuad() {
        //trace ("BezQuad Class loaded");
    }

      // 1. quadratic ----------------------------------

    /**
     * @method  quadratic
     * @description  Calculates a 1d quadratic equation.
     * @usage  <pre>inst.quadratic(t, a, b, c);</pre>
     * @param   t   (Number)  -- a scalar value.
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @param   c   (Number)  -- a real number.
     * @return  (Number)  -- returns 1d quadratic calculation.
    **/
    public function quadratic(t:Number, a:Number, b:Number, c:Number):Number {
    	return a+t*(2*(1-t)*(b-a)+t*(c-a));
    }

      // 2. quadratic2d --------------------------------

    /**
     * @method  quadratic2d
     * @description  Calculates 2d quadratic equations.
     * @usage  <pre>inst.quadratic2d(pt1, pt2, pt3, t);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @param   t   (Number)  -- a scalar value.
     * @return  (Point)  -- returns a Point object containing 2d quadratic calculations.
    **/
    public function quadratic2d(pt1:Point, pt2:Point, pt3:Point, t:Number):Point {
        var k:Number = 2*(1-t);
        var t_obj:Point = new Point
        (
            pt1.x+t*(k*(pt2.x-pt1.x)+t*(pt3.x-pt1.x)),
            pt1.y+t*(k*(pt2.y-pt1.y)+t*(pt3.y-pt1.y))
        );

        return t_obj;
    }

      // 3. points -------------------------------------

    /**
     * @method  points
     * @description  Initializes class Point object properties.
     * @usage  <pre>inst.points(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (void)
    **/
    public function points(pt1:Point, pt2:Point, pt3:Point):void {
    	$p1 = new Point(pt1.x, pt1.y);
    	$p2 = new Point(pt2.x, pt2.y);
    	$p3 = new Point(pt3.x, pt3.y);
    }

      // 4. segment ------------------------------------

    /**
     * @method  segment
     * @description  Calculates three bisector Point objects, $b1 and $b2 bisect
     *               $p1-$p2 and $p2-$p3 respectively, then $b3 bisects $b1-$b2.
     * @usage  <pre>inst.segment(pt1, pt2, pt3, t1, t2);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @param   t1   (Number)  -- a scalar value.
     * @param   t2   (Number)  -- a scalar value.
     * @return  (Object)  -- returns three bisector Point objects.
    **/
    public function segment(pt1:Point, pt2:Point, pt3:Point, t1:Number, t2:Number):Object {
        points(pt1, pt2, pt3);
        var $b1:Point = new Point(quadratic(t1, pt1.x, pt2.x, pt3.x),
        						  quadratic(t1, pt1.y, pt2.y, pt3.y));
        var $b2:Point = new Point(quadratic(t2, pt1.x, pt2.x, pt3.x),
        						  quadratic(t2, pt1.y, pt2.y, pt3.y));
        var $b3:Point = new Point(control  (t1, t2, pt1.x, pt2.x, pt3.x),
        						  control  (t1, t2, pt1.y, pt2.y, pt3.y));
        return {$b1:$b1, $b2:$b2, $b3:$b3};
    };

      // 5. control ------------------------------------

    /**
     * @method  control
     * @description  Calculates control basis value for passed axis values.
     * @usage  <pre>inst.control(t1, t2, a, b, c);</pre>
     * @param   t1   (Number)  -- a scalar value.
     * @param   t2   (Number)  -- a scalar value.
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @param   c   (Number)  -- a real number.
     * @return  (Number)  -- returns a 1d axis value.
    **/
    public function control(t1:Number, t2:Number, a:Number, b:Number, c:Number):Number {
    	return a+(t1+t2)*(b-a)+t1*t2*(c-2*b+a);
    }

      // 6.vertex -------------------------------------

    /**
     * @method  vertex
     * @description  Defines parabola vertex class instance properties.
     * @usage  <pre>inst.vertex(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (void)
    **/
    public function vertex(pt1:Point, pt2:Point, pt3:Point):void {
        points(pt1, pt2, pt3);
    	$vm = -(pt2.x-.5*pt3.x-.5*pt1.x)/(pt2.y-.5*pt3.y-.5*pt1.y);
      	$vt = (-$vm*(pt2.x-pt1.x)+(pt2.y-pt1.y))/($vm*(pt1.x-2*pt2.x+pt3.x)-(pt1.y-2*pt2.y+pt3.y));
    	$vx = quadratic($vt, pt1.x, pt2.x, pt3.x);
    	$vy = quadratic($vt, pt1.y, pt2.y, pt3.y);
    	$va = angle($vt, pt1, pt2, pt3);
    }

      // 7. symmetryAxis ------------------------------

    /**
     * @method  symmetryAxis
     * @description  Defines parabola symmetry axis, which runs through parabola
     *               vertex and focus points.
     * @usage  <pre>inst.symmetryAxis(pt1, pt2, pt3, r);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @param   r   (Number)  -- radius value for display.
     * @return  (Object)  -- returns an object containing symmetry axis start and end Point objects.
    **/
    public function symmetryAxis(pt1:Point, pt2:Point, pt3:Point, r:Number):Object {
        this.vertex(pt1, pt2, pt3);
        
    	var ax:Number, ay:Number, bx:Number, by:Number;
    	ax = $vx + r*Math.cos( Math.atan($vm) - 0.5*Math.PI );
    	ay = $vy + r*Math.sin( Math.atan($vm) - 0.5*Math.PI );
    	bx = $vx + r*Math.cos( Math.atan($vm) + 0.5*Math.PI );
    	by = $vy + r*Math.sin( Math.atan($vm) + 0.5*Math.PI );
    	return {$sym1:new Point(ax, ay), $sym2:new Point(bx, by)};
    }

      // 8. angle --------------------------------------

    /**
     * @method  angle
     * @description  Defines angle based on the derivatives of passed scalar
     *               and angle vertices.
     * @usage  <pre>inst.angle(t, pt1, pt2, pt3);</pre>
     * @param   t   (Number)  -- a scalar value.
     * @param   pt1   (Point)  -- focus vertex Point object.
     * @param   pt2   (Point)  -- angle vertex Point object.
     * @param   pt3   (Point)  -- angle vertex Point object.
     * @return  (Number)  -- returns angle of pt2 and pt3 wrt p1.
    **/
    public function angle(t:Number, pt1:Point, pt2:Point, pt3:Point):Number {
        points(pt1, pt2, pt3);

    	return (Math.atan2(derivative(t, pt1.y, pt2.y, pt3.y), derivative(t, pt1.x, pt2.x, pt3.x)));
    }

      // 9. derivative ---------------------------------

    /**
     * @method  derivative
     * @description  Calculates the 1d derivative of passed scalar and axis data.
     * @usage  <pre>inst.derivative(t, a, b, c);</pre>
     * @param   t   (Number)  -- a scalar value.
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @param   c   (Number)  -- a real number.
     * @return  (Number)  -- returns the 1d derivative of passed axis data.
    **/
    public function derivative(t:Number, a:Number, b:Number, c:Number):Number {
    	return 2*a*(t-1)+2*b*(1-2*t)+2*c*t;
    }

      // 10. projection --------------------------------

    /**
     * @method  projection
     * @description  Defines a projection object containing this instance's
     *               projection data.
     * @usage  <pre>inst.projection(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (Object)  -- returns an object containing all projection data.
    **/
    public function projection(pt1:Point, pt2:Point, pt3:Point):Object {
    	// FIXME -- what is the 4th arg supposed to be here?
        var sym:Object = symmetryAxis(pt1, pt2, pt3, 1);

        var ax:Number, ay:Number, bx:Number, by:Number;
        var v:Point = new Point($vx, $vy);

    	$ra 	= Graphic.projectDistance(pt1, v);
    	$rb 	= Graphic.projectDistance(v, $p3);
    	$alfa 	= $va-Graphic.radAngle(pt1, v);
    	$beta	= Graphic.radAngle(v, pt3)-$va;
    	$rax 	= $ra*Math.cos($alfa);
    	$ray 	= $ra*Math.sin($alfa);
    	ax 		= $vx+$rax*Math.cos($va+Math.PI);
    	ay 		= $vy+$rax*Math.sin($va+Math.PI);
    	$rbx 	= $rb*Math.cos($beta);
    	$rby 	= $rb*Math.sin($beta);
        bx 		= $vx+$rbx*Math.cos($va);
        by 		= $vy+$rbx*Math.sin($va);

        var pa:Point = new Point(ax, ay);
        var pb:Point = new Point(bx, by);
        var pv:Point = new Point($vx, $vy);

        var proj1:Number = Math.round(Graphic.projectDistance(pa, pt1)*100)/100;
        var proj2:Number = Math.round(Graphic.projectDistance(pa, pv)*100)/100;
        var proj3:Number = Math.round(Graphic.projectDistance(pb, pt3)*100)/100;
        var proj4:Number = Math.round(Graphic.projectDistance(pb, pv)*100)/100;
        var ratio1:Number = Math.round(proj1/proj2*100)/100;
        var ratio2:Number = Math.round(proj3/proj4*100)/100;

        return {
            proj1:	proj1, 	proj2:proj2, 	proj3:proj3, 	proj4:proj4,
            ratio1:ratio1, 	ratio2:ratio2,
            pa:pa, 			pb:pb, 			pv:pv, 			$p1:pt1, 		$p3:pt3,
            $sym1:sym.$sym1, $sym2:sym.$sym2
        };
    }

      // 11. focalLength --------------------------------

    /**
     * @method  focalLength
     * @description  Calculates focal length to pass to 'focus'.
     * @usage  <pre>inst.focalLength(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (void)
    **/
    public function focalLength(pt1:Point, pt2:Point, pt3:Point):void {
        projection(pt1, pt2, pt3);
    	$a = .25*$ra*Math.cos($alfa)/Math.tan($alfa);
    }

      // 12. focus --------------------------------------

    /**
     * @method  focus
     * @description  Defines this instance's focus x-axis and y-axis positions.
     * @usage  <pre>inst.focus(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (void)
    **/
    public function focus(pt1:Point, pt2:Point, pt3:Point):void {
        focalLength(pt1, pt2, pt3);
    	$fx = $vx+$a*Math.cos($va+.5*Math.PI);
    	$fy = $vy+$a*Math.sin($va+.5*Math.PI);
    }

      // 13. latusRectum --------------------------------

    /**
     * @method  latusRectum
     * @description  Calculates latus rectum, which parallels the directrix at
     *               the parabola focus point, and it's length defined by each
     *               parabola intersection.
     * @usage  <pre>inst.latusRectum(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (Object)  -- returns an object containing latusRectum and semiLatusRectum distances, and their Point objects.
    **/
    public function latusRectum(pt1:Point, pt2:Point, pt3:Point):Object {
        focus(pt1, pt2, pt3);

    	var lax:Number, lay:Number, lbx:Number, lby:Number;

    	lax = $fx+2*$a*Math.cos($va-Math.PI);
    	lay = $fy+2*$a*Math.sin($va-Math.PI);
    	lbx = $fx+2*$a*Math.cos($va);
    	lby = $fy+2*$a*Math.sin($va);

    	var la:Point = new Point(lax, lay);
    	var lb:Point = new Point(lbx, lby);

    	return {
            latusRectum:Math.round(Graphic.projectDistance(la, lb)*100)/100,
            semiLatusRectum:Math.round(Graphic.projectDistance(la, lb)*100)/200,
            la:la, lb:lb
        };
    }

      // 14. directrix ----------------------------------

    /**
     * @method  directrix
     * @description  Defines the parabola directrix, which is perpendicular to the
     *               symmetry axis at a point which is at the same magnitude as the
     *               focus, but opposite direction, from the control projection
     *               point on the Bezier curve.
     * @usage  <pre>inst.directrix(pt1, pt2, pt3, r);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @param   r   (Number)  -- radius value for display.
     * @return  (Object)  -- returns an object containing directrix start and end Point objects.
    **/
    public function directrix(pt1:Point, pt2:Point, pt3:Point, r:Number):Object {
        vertex(pt1, pt2, pt3);

    	var ax:Number, ay:Number, bx:Number, by:Number, dx:Number, dy:Number;

    	dx = $vx+$a*Math.cos($va-.5*Math.PI);
    	dy = $vy+$a*Math.sin($va-.5*Math.PI);
    	ax = dx+r*Math.cos($va);
    	ay = dy+r*Math.sin($va);
    	bx = dx-r*Math.cos($va);
    	by = dy-r*Math.sin($va);

    	return {$dir1:new Point(ax, ay), $dir2:new Point(bx, by)};
    }

      // 15. bezArea ------------------------------------

    /**
     * @method  bezArea
     * @description  Calculates the total area under the Bezier curve.
     * @usage  <pre>inst.bezArea(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (Number)  -- returns area defined under the Bezier arc.
    **/
    public function bezArea(pt1:Point, pt2:Point, pt3:Point):Number {
    	$area = (2/3)*Graphic.triangleArea(pt1, pt2, pt3);

        return $area;
    }

      // 16. arcLength ----------------------------------

    /**
     * @method  arcLength
     * @description  Calculates total length of the Bezier curve.
     * @usage  <pre>inst.arcLength(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
	 * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (Number)  -- returns the Bezier arc length.
    **/
    public function arcLength(pt1:Point, pt2:Point, pt3:Point):Number {
        projection(pt1, pt2, pt3);

    	var l1:Number = .5*Graphic.parabolaArcLength($ray, 2*Math.abs($rax));
    	var l2:Number = .5*Graphic.parabolaArcLength($rby, 2*Math.abs($rbx));

    	$arc = ($rax<0 || $rbx<0) ? Math.abs(l2-l1) : l1+l2;

        return $arc;
    }

      // 17. drawTangents ---------------------------------

    /**
     * @method  drawTangents
     * @description  Defines an object containing angle and bisector data to
     *               draw tangent lines for the start point, end point, and
     *               control projection point on the Bezier curve.
     * @usage  <pre>inst.drawTangents(pt1, pt2, pt3);</pre>
     * @param   pt1   (Point)  -- start Point object.
     * @param   pt2   (Point)  -- control Point object.
     * @param   pt3   (Point)  -- end Point object.
     * @return  (Object)  -- returns an object containing bisection and control points, and bisection angles.
    **/
    public function drawTangents(pt1:Point, pt2:Point, pt3:Point):Object {
        var bisect1:Point = Graphic.getMiddle(pt1, pt2);
        var bisect2:Point = Graphic.getMiddle(pt2, pt3);

        $bi1 = new Point(bisect1.x, bisect1.y);
        $bi2 = new Point(bisect2.x, bisect2.y);

        var bisect3:Point = Graphic.getMiddle($bi1, $bi2);

        $bi3= new Point(bisect3.x, bisect3.y);

        return {
            ang1:Math.round((Graphic.angle(pt1, pt2)-Graphic.angle(pt2, $bi3))*100)/100,
            ang2:Math.round((Graphic.angle(pt2, pt3)-Graphic.angle(pt2, $bi3))*100)/100,
            $bi1:$bi1, $bi2:$bi2, $bi3:$bi3,
            pt1:pt1, pt2:pt2, pt3:pt3
        };
    }

}// class
}//package

