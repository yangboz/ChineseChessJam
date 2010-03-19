package com.vizsage.as3mathlib.math.calc {
/**
 * @interface   com.vizsage.as3mathlib.math.calc.ode.IODE
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description IODE defines a system of differential equations by providing
 *              access to the rate equations.
 * @usage       <pre>var inst:IODE = new IODE();</pre>
 * @param       none  -- interface has no parameters.
 * -----------------------------------------------
 * Latest update: September 19, 2004
 * -----------------------------------------------
 * AS2  revision copyright: � 2004, Richard Wright     [wisolutions2002@shaw.ca]
 * Java original copyright: � 2003, Wolfgang Christian [http://sip.clarku.edu/3e/]
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
 *       IODE()
 *           1.  getState()
 *           2.  getRate(state, rate)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

public interface IODE {

	// 1. getState -----------------------------------

    /**
     * @method getState
     * @description  Gets the state variables. The getState method is invoked by
     *               an ODESolver to obtain the initial state of the system. The
     *               ODE solver advances the solution and then copies new values
     *               into the state array at the end of the solution step.
     * @usage  <pre>inst.getState();</pre>
     * @return state  (Array)  -- returns the state array.
    **/
    function getState():Array;

	// 2. getRate ------------------------------------

    /**
     * @method getRate
     * @description  Gets the rate of change using the argument's state variables.
     *               This method may be invoked many times with different
     *               intermediate states as an ODESolver is carrying out the solution.
     * @usage  <pre>inst.getRate(state, rate);</pre>
     * @param state  (Array)  -- the state array.
     * @param rate  (Array)  -- the rate array.
    **/
     function getRate(state:Array, rate:Array):void;
}// class
}//package

