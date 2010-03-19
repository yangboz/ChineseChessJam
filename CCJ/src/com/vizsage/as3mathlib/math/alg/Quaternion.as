package com.vizsage.as3mathlib.math.alg {
/**
 * @class       com.vizsage.as3mathlib.math.alg.Quaternion
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Quaternion Class -- provides
 *              methods for quaternion transformation.
 *		        <p>
 *              I've swayed from using '$' as a class-based variable identifier for
 *              this class due to the increased usage of UI-defined class variables
 *              for this group of classes: Point, Vector, Quaternion, Col, and ColMC
 *              classes all reflect this format.
 * @usage       <pre>var inst:Quaternion = new Quaternion(x, y, z, w)</pre>
 * @param       x (Number)  -- x-axis component of quaternion.
 * @param       y (Number)  -- y-axis component of quaternion.
 * @param       z (Number)  -- z-axis component of quaternion.
 * @param       w (Number)  -- transform component of quaternion.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependency:    com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.alg.Matrix
 * -----------------------------------------------
 * AS2 revision copyright: � 2003, Richard Wright   [wisolutions2002@shaw.ca]
 * AS1 original copyright: � 2003, Brandon Williams [brandon@plotdev.com]
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
 *       Quaternion(w, x, y, z)
 *           1.  toString()
 *           2.  resetComponents(w, x, y, z)
 *           3.  copyComponents(q)
 *           4.  magnitude()
 *           5.  normalize()
 *           6.  multiply(q)
 *           7.  axisAngle(theta, A)
 *           8.  rotationMatrix()
 * ----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * ----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.alg.Matrix;

public class Quaternion  {
	/**
	 * @property w (Number)  -- 'w' component property.
	 * @property V (Vector)  -- Vector component property.
	**/
    public var w:Number;
    public var V:Vector;

    // constructor
    public function Quaternion(w:Number, x:Number, y:Number, z:Number) {
        w = w;
        V = new Vector(x, y, z);
    }

      // 1. toString

    /**
     * @method  toString
     * @description  Makes quaternion trace-able.
     * @usage  <pre>inst.toString();</pre>
     * @return  (String)  -- returns a string representation of this instance's properties.
    **/
    public function toString():String {
        return ("Quaternion = ["+w+", "+V.x+", "+V.y+", "+V.z+"]");
    }

      // 2. resetComponents

    /**
     * @method  resetComponents
     * @description   Resets the components of the quaternion.
     * @usage  <pre>inst.resetComponents(w, x, y, z);</pre>
     * @param   w   (Number)  -- a real number.
     * @param   x   (Number)  -- a real number.
     * @param   y   (Number)  -- a real number.
     * @param   z   (Number)  -- a real number.
     * @return  (void)
    **/
    public function resetComponents(w:Number, x:Number, y:Number, z:Number):void {
        w = w;
        V = new Vector(x, y, z);
    }

      // 3. copyComponents

    /**
     * @method  copyComponents
     * @description  Copies the components of the quaternion 'q' into this instance.
     * @usage  <pre>inst.copyComponents(q);</pre>
     * @param   q   (Quaternion)  -- an object that contains copied components.
     * @return  (void)
    **/
    public function copyComponents(q:Quaternion):void {
        w = q.w;
        V = new Vector(q.V.x, q.V.y, q.V.z);
    }

      // 4. magnitude

    /**
     * @method  magnitude
     * @description  Defines the magnitude of the quaternion.
     * @usage  <pre>inst.magnitude();</pre>
     * @return  (Number)  -- returns magnitude of this instance.
    **/
    public function magnitude():Number {
        return (Math.sqrt(w*w+V.x*V.x+V.y*V.y+V.z*V.z));
    }

      // 5. normalize

    /**
     * @method  normalize
     * @description  Normalizes the quaternion.
     * @usage  <pre>inst.normalize();</pre>
     * @return  (void)
    **/
    public function normalize():void {
        var mag:Number = this.magnitude();

        w /= mag;
        V.scalar(1.0/mag);
    }

      // 6. multiply

    /**
     * @method  multiply
     * @description  Defines the multiplication of this instance with 'q'.
     * @usage  <pre>inst.multiply(q);</pre>
     * @param   q   (Quaternion)  -- a Quaternion object.
     * @return  (Quaternion)  -- returns a new Quaternion object that contains the multiplication of this instance with 'q'.
    **/
    public function multiply(q:Quaternion):Quaternion {
        return (new Quaternion((w*q.w-V.x*q.V.x-V.y*q.V.y-V.z*q.V.z),
				               (w*q.V.x+V.x*q.w+V.y*q.V.z-V.z*q.V.y),
				               (w*q.V.y+V.x*q.V.z+V.y*q.w-V.z*q.V.x),
				               (w*q.V.z+V.x*q.V.y+V.y*q.V.x-V.z*q.w)));
    }

      // 7. axisAngle

    /**
     * @method  axisAngle
     * @description  Sets the elements of the quaternion to represent a
     *               rotation around the unit vector 'A' by an angle of theta.
     * @usage  <pre>inst.axisAngle(theta, A);</pre>
     * @param   theta   (Number)  -- a real number representing angle input.
     * @param   A   (Vector)  - a direction Vector object.
     * @return  (void)
    **/
    public function axisAngle(theta:Number, A:Vector):void {
        w = Math.cos(theta/2.0);
        V.copyComponents(A);
        V.scalar(Math.sin(theta/2.0));
    }

      // 8. rotationMatrix

    /**
     * @method  rotationMatrix
     * @description  Calculates the rotation matrix of the quaternion.
     * @usage  <pre>inst.rotationMatrix();</pre>
     * @return  (Matrix)  -- returns the rotation matrix of this instance.
    **/
    public function rotationMatrix():Matrix {
        // rotation matrix that will be returned
        var M:Matrix = new Matrix(4, 4);

        // values that are repeatedly used and can be pre-calculated to save computations
        var xx:Number = V.x*V.x;
        var xy:Number = V.x*V.y;
        var xz:Number = V.x*V.z;
        var xw:Number = V.x*w;
        var yy:Number = V.y*V.y;
        var yz:Number = V.y*V.z;
        var yw:Number = V.y*w;
        var zz:Number = V.z*V.z;
        var zw:Number = V.z*w;

        // calculate the elements of the rotation matrix
        M.$m[0][0] = 1-2*(yy+zz);
        M.$m[0][1] = 2*(xy-zw);
        M.$m[0][2] = 2*(xz+yw);
        M.$m[0][3] = 0.0;

        M.$m[1][0] = 2*(xy+zw);
        M.$m[1][1] = 1-2*(xx+zz);
        M.$m[1][2] = 2*(yz-xw);
        M.$m[1][3] = 0.0;

        M.$m[2][0] = 2*(xz-yw);
        M.$m[2][1] = 2*(yz+xw);
        M.$m[2][2] = 1-2*(xx+yy);
        M.$m[2][3] = 0.0;

        M.$m[3][0] = 0;
		M.$m[3][1] = 0;
		M.$m[3][2] = 0;
        M.$m[3][3] = 1;

        return (M);
    }

}// class
}//package

