package com.vizsage.as3mathlib.math.calc.solvers {
/**
 * @class       com.vizsage.as3mathlib.math.calc.solvers.RK45MultiStep
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description RK45MultiStep extends RK45, which implements the behaviours of the
 *              IODESolver Interface. Perform multiple Runge-Kutta 4/5 IODE steps so
 *              that a uniform step size is maintained. Constructs the RK45MultiStep
 *              IODESolver for a system of ordinary differential equations.
 * @usage       <pre>var inst:RK45MultiStep = new RK45MultiStep(_ode);</pre>
 * @param       _ode  (IODE)  -- the system of differential equations.
 * -----------------------------------------------
 * Latest update: January 11, 2005
 * -----------------------------------------------
 * AS2  revision copyright: � 2005, Richard Wright     [wisolutions2002@shaw.ca]
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
 *       RK45MultiStep(_ode)
 *           1.  initialize(_stepSize)
 *           2.  step()
 *           3.  setStepSize(_stepSize)
 *           4.  getStepSize()
 *           5.  setTolerance(_tol)
 *           6.  getTolerance()
 *           7.  plus()
 *           8.  minus()
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.calc.*;

public class RK45MultiStep extends RK45 implements IODESolver {
    /**
     * @property $maxMessages  (Number) -- static, maximum number of error messages.
     * @property $fixedStepSize  (Number)  -- fixed number for step size.
    **/
    private static var $maxMessages:Number = 4;
    private var $fixedStepSize:Number = 0.1;

    public function RK45MultiStep(_ode:IODE) {
        super(_ode);
    }

      // 1. initialize -------------------------------------------

    /**
     * @method  initialize
     * @description  Initializes the IODE solver. Temporary state and rate arrays
     *               are allocated by invoking the superclass method.
     * @usage  <pre>inst.initialize(_stepSize);</pre>
     * @param  _stepSize  (Number)  -- the step size.
    **/
    override public function initialize(_stepSize:Number):void {
        $fixedStepSize = _stepSize;
        super.initialize(_stepSize);
    }

      // 2. step -------------------------------------------

    /**
     * @method  step
     * @description  Steps (advances) the differential equations by the stepSize.
     *               The IODESolver invokes the IODE's getRate method to obtain
     *               the initial state of the system. The IODESolver then advances
     *               the solution and copies the new state into the state array at
     *               the end of the solution step.
     * @usage  <pre>inst.step();</pre>
     * @return  (Number)  -- returns the step size.
    **/
    override public function step():Number {
        if ($fixedStepSize>0) return $fixedStepSize-plus();
        else return $fixedStepSize-minus();
    }

      // 3. setStepSize -------------------------------------------

    /**
     * @method  setStepSize
     * @description  Sets the step size.
     * @usage  <pre>inst.initialize(_stepSize);</pre>
     * @param _stepSize  (Number)  -- the step size.
    **/
    override public function setStepSize(_stepSize:Number):void {
        $maxMessages = 4;               // reset the message counter
        $fixedStepSize = _stepSize;     // the fixed step size
        super.setStepSize(_stepSize);   // the variable step size
    }

      // 4. getStepSize -------------------------------------------

    /**
     * @method  getStepSize
     * @description  Gets the step size. The step size is the fixed step size,
     *               not the size of the RK4/5 steps that are combined into a
     *               single step.
     * @usage  <pre>inst.getStepSize();</pre>
     * @return  (Number)  -- returns the step size.
    **/
    override public function getStepSize():Number {
        return $fixedStepSize;
    }

      // 5. setTolerance -------------------------------

    /**
     * @description  Sets the tolerance of the adaptive IODE solver. This is an
     *               an abstract method to support IODESolver interface.
     * @param  tol  (Number)  -- the tolerance.
    **/
    override public function setTolerance(_tol:Number):void {}

      // 6. getTolerance -------------------------------

    /**
     * @description  Gets the tolerance of the adaptive IODE solver. This is an
     *               an abstract method to support IODESolver interface.
     * @return  (Number)  -- returns the relative tolerance.
    **/
    override public function getTolerance():Number { return NaN; }

      // 7. plus ---------------------------------------

    /**
     * @method  plus
     * @description  Steps the ode with a positive stepsize.
     * @usage  <pre>inst.plus();</pre>
     * @return  (Number)  -- returns the step size.
    **/
    private function plus():Number {  
    	// positive step size
        var remainder:Number = $fixedStepSize;                    // dt will keep track of the remaining time
        if ((super.getStepSize()<=0) ||                           // is the stepsize postive?
            (super.getStepSize()>$fixedStepSize) ||               //is the stepsize larger than what is requested?
            ($fixedStepSize-super.getStepSize()==$fixedStepSize)) // is the stepsize smaller than the precision? 
        {
            super.setStepSize($fixedStepSize);                    // reset the step size and let it adapt to an optimum size
        }
        while (remainder>this.$tol*$fixedStepSize) {           // check to see if we are close enough
            var oldRemainder:Number = remainder;
            if (remainder<super.getStepSize()) {                                                     
            	// temporarily reduce the step size so that we hit the exact dt value
                var tempStep:Number = super.getStepSize();        // save the current optimum step size
                super.setStepSize(remainder);                     // set the RK4/5 step size to the remainder
                var delta:Number = super.step();
                remainder -= delta;
                super.setStepSize(Math.min(tempStep, delta));      // restore the optimum step size
                
            }
            else remainder -= super.step();                       // do a RK45 step and set the remainder
            
            // check to see if roundoff error prevents further calculation.
            if ((Math.abs(oldRemainder-remainder)<=100*Number.MIN_VALUE) ||
                (this.$tol*$fixedStepSize/100.0>super.getStepSize())) {
                if ($maxMessages<=0) break;
                $maxMessages--;
                trace ("Warning: RK45MultiStep did not converge. Remainder = "+remainder);
                if ($maxMessages==0) trace ("Further warnings suppressed.");
                break;
            }
        }
        return remainder;
    }

      // 8. minus --------------------------------------

    /**
     * @method  minus
     * @description  Steps the $ode with a negative stepsize.
     * @usage  <pre>inst.minus();</pre>
     * @return  (Number)  -- returns the step size.
    **/
    private function minus():Number {                               
    	// negative step size
        var remainder:Number = $fixedStepSize;                    // dt will keep track of the remaining time
        if ((super.getStepSize()>=0) ||                           // is the step negative?
            (super.getStepSize()<$fixedStepSize) ||               // is the stepsize larger than what is requested?
            ($fixedStepSize-super.getStepSize()==$fixedStepSize)) // is the stepsize smaller than the precision? 
        {   
            super.setStepSize($fixedStepSize);                    // reset the step size and let it adapt to an optimum size
        }
        while (remainder<this.$tol*$fixedStepSize) {                           
        	// check to see if we are close enough
            var oldRemainder:Number = remainder;
            if (remainder>super.getStepSize()) {
                var tempStep:Number = super.getStepSize();        // save the current optimum step size
                super.setStepSize(remainder);                     // set the step RK4/5 size to the remainder
                var delta:Number = super.step();
                remainder -= delta;
                super.setStepSize(Math.max(tempStep, delta));      // restore the optimum step size
            }
            else remainder -= super.step();                       // do a RK45 step and set the remainder
            // check to see if roundoff error prevents further calculation.
            if ((Math.abs(oldRemainder-remainder)<=100*Number.MIN_VALUE) ||
                (this.$tol*$fixedStepSize/100.0<super.getStepSize())) {
                if ($maxMessages <= 0) break;
                $maxMessages--;
                trace ("Warning: RK45MultiStep did not converge. Remainder = "+remainder);
                if ($maxMessages==0) trace ("Further warnings surppressed.");
                break;
            }
        }
        return remainder;
    }
}// class
}//package

