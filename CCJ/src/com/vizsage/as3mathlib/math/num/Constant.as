package com.vizsage.as3mathlib.math.num {
/**
 * @class       com.vizsage.as3mathlib.math.num.Constant
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static properties of the Constant Class.
 *              <p>
 *		        Provides constants for further mathematical manipulation. This
 *              collection will be added to in future, thus the separate class.
 * @usage       <pre>Constant.constProp;</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright © 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright © 2003, Robert Penner  [www.robertpenner.com]
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
 *   Static Constant Properties:
 *           1. DEG2RAD
 *           2. RAD2DEG
 *           3. PHI
 *           4. LAMBDA
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This collection will be added to in future, thus the separate class.
 * -----------------------------------------------
**/

public class Constant  {
	/**
	 * @property DEG2RAD (Number)  -- static -- changes degrees to radians ... Math.PI/180.
	 * @property RAD2DEG (Number)  -- static -- changes radians to degrees ... 180/Math.PI.
	 * @property PHI (Number)  -- static -- the golden mean (phi) ... (1+Math.sqrt(5))/2.
	 * @property LAMBDA (Number)  -- static -- Euler-Mascheroni constant (lambda or C) ... 0.57721566490143.
	**/

    // 1. change degrees to radians ... Math.PI/180
    public static var DEG2RAD:Number = 0.0174532925199433;

      // ------------------------------------------------------------

    // 2. change radians to degrees ... 180/Math.PI
    public static var RAD2DEG:Number = 57.2957795130823;

      // ------------------------------------------------------------

    // 3. the golden mean (phi) ... (1+Math.sqrt(5))/2
    public static var PHI:Number = 1.61803398874989;

      // ------------------------------------------------------------

    // 4. Euler-Mascheroni constant (lambda or C)
    //        (    n              )
    //   lim  ( sigma 1/k - ln(n) )
    //  n->oo (   k=1             )
    public static var LAMBDA:Number = 0.57721566490143;

}// class
}//package

