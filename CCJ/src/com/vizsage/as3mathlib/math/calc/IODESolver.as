package com.vizsage.as3mathlib.math.calc {
/**
 * @interface   com.vizsage.as3mathlib.math.calc.IODESolver
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description IODESolver interface defines a minimal differential equation solver.
 * @usage       <pre>var inst:IODESolver = new IODESolver();</pre>
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
 *       IODESolver()
 *           1.  initialize(_stepSize)
 *           2.  step()
 *           3.  setStepSize(_stepSize)
 *           4.  getStepSize()
 *           5.  setTolerance(_tol)
 *           6.  getTolerance()
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

public interface IODESolver  {

      // 1. initialize ---------------------------------

    /**
     * @method  initialize
     * @description  Initializes the IODE solver. IODE solvers use this method to
     *               allocate temporary arrays that may be required to carry out
     *               the solution. The number of differential equations is
     *               determined by invoking getState().length on the ODE.
     * @usage  <pre>inst.initialize(_stepSize);</pre>
     * @param _stepSize  (Number)  -- the step size.
     * @return  (void)
    **/
    function initialize(_stepSize:Number):void;

      // 2. step ---------------------------------------

    /**
     * @method  step
     * @description  Steps (advances) the differential equations by the stepSize.
     *               The IODESolver invokes the IODE's getRate method to obtain the
     *               initial state of the system. The IODESolver then advances the
     *               solution and copies the new state into the state array at the
     *               end of the solution step.
     * @usage  <pre>inst.step();</pre>
     * @return(Number)  -- returns the step size.
    **/
    function step():Number;

      // 3. setStepSize --------------------------------

    /**
     * @method  setStepSize
     * @description  Sets the initial step size. The step size may change if the
     *               IODE solver implements an adaptive step size algorithm such
     *               as RK4/5.
     * @usage  <pre>inst.setStepSize(_stepSize);</pre>
     * @param  _stepSize  (Number)  -- the step size.
     * @return  (void)
    **/
    function setStepSize(_stepSize:Number):void;

      // 4. getStepSize --------------------------------

    /**
     * @method  getStepSize
     * @description  Gets the step size.
     * @usage  <pre>inst.getStepSize(();</pre>
     * @return  (Number)  -- returns the step size.
    **/
    function getStepSize():Number;

      // 5. setTolerance -------------------------------

    /**
     * @description  Sets the tolerance of the adaptive ODE solver.
     * @param  _tol  (Number)  -- the tolerance.
    **/
    function setTolerance(_tol:Number):void;

      // 6. getTolerance -------------------------------

    /**
     * @description  Gets the tolerance of the adaptive ODE sovler.
     * @return  (Number)  -- returns the relative tolerance.
    **/
    function getTolerance():Number;

}// class
}//package

