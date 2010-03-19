package com.vizsage.as3mathlib.math.calc.solvers {
/**
 * @class       com.vizsage.as3mathlib.math.calc.solvers.Verlet
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description Verlet method IODE solver. The Verlet algorithm is a third order
 *              algorithm that uses the acceleration to estimate the final position.
 *              Note that the velocity plays no part in the integration of the
 *              equations.
 *
 *              <pre> x(n+1) = 2*x(n) - x(n-1) + a(n)*dt*dt
 *              v(n+1) = (x(n+1) - x(n-1))/(2 dt) + a(n)*dt</pre>
 *
 *              CAUTION! You MUST call the initialize if the state array is changed.
 *              The Verlet algorithm is not self-starting.  The current state and a
 *              prior state must both be known to advance the solution.  Since the
 *              prior state is not known for the initial conditions, a prior state
 *              is estimated when the initialize method is invoked.
 *              <p>
 *              CAUTION! This implementation assumes that the state vector has
 *              2*N + 1 variables. These variables alternate between position and
 *              velocity with the last variable being time. That is, the state
 *              vector is ordered as follows:
 *
 *              <pre> x1, d x1/dt, x2, d x2/dt, x3, d x3/dt ..... xN, d xN/dt, t</pre>
 * @usage       <pre>var inst:Verlet = new Verlet(_ode);</pre>
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
 *     - Redistributions of source c$ode must retain the above copyright notice,
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
 *       Verlet(_ode)
 *           1.  initialize(_stepSize)
 *           2.  step()
 *           3.  setStepSize(_stepSize)
 *           4.  getStepSize()
 *           5.  setTolerance(_tol)
 *           6.  getTolerance()
 *           7.  estimatePreviousState(state)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.calc.*;

public class Verlet implements com.vizsage.as3mathlib.math.calc.IODESolver {
	/**
	 * @property $stepSize  (Number)  -- parameter increment such as delta time.
	 * @property $numEqn  (Number)  -- number of equations.
	 * @property $rate  (Array)  -- rate with original positions.
	 * @property $priorState  (Array)  -- rate with new positions.
	 * @property $currentState  (Array)  -- current state.
	 * @property $ode  (IODE)  -- object that computes rate.
	**/
    private var $stepSize:Number = 0.1;
    private var $numEqn:Number = 0;
    private var $rate:Array;          // rate with original positions
    private var $priorState:Array;    // rate with new positions
    private var $currentState:Array;  // current state
    private var $ode:IODE;

    public function Verlet(_ode:IODE) {
        $ode = _ode;
        initialize($stepSize);
    }

      // ---------------------------------------------

    /**
     * @method  initialize
     * @description   Initializes the IODE solver. Two temporary state arrays and
     *                one rate array are allocated. The number of differential
     *                equations is determined by invoking getState().length on the
     *                IODE.
     * @usage  <pre>inst.initialize(_stepSize);</pre>
     * @param   _stepSize  (Number) -- step integer.
     * @return  (void)
    **/
    public function initialize(_stepSize:Number):void {
        $stepSize = _stepSize;
        var state:Array = $ode.getState();
        // if state vector not defined.
        if (state==null) $numEqn = 0;
        else $numEqn = state.length;
        $numEqn       = state.length;
        $rate         = new Array($numEqn);
        $priorState   = new Array($numEqn);
        $currentState = new Array($numEqn);
        estimatePreviousState(state);
    }

      // ---------------------------------------------

    /**
     * @method  step
     * @description   Steps (advances) the differential equations by the stepSize.
     *                The IODESolver invokes the IODE's getRate method to obtain the
     *                initial state of the system. The IODESolver then advances the
     *                solution and copies the new state into the state array at the
     *                end of the solution step.
     * @usage  <pre>inst.step();</pre>
     * @return  (Number)  -- returns step size.
    **/
    public function step():Number {
    	var i:uint;
        // state[]: x1, d x1/dt, x2, d x2/dt .... xN, d xN/dt, t
        var state:Array = $ode.getState();
        state = $currentState.concat();  // save the current state as the prior state
        if (state.length!=$numEqn) initialize($stepSize);
        $ode.getRate(state, $rate);  // get the initial rate
        var dt2:Number = $stepSize*$stepSize;  // the step size squared
        // increment the positions
        for (i=0;i<$numEqn-1;i+=2) // even numbers are positions
            state[i] = 2*state[i]-$priorState[i]+dt2*$rate[i+1];
        // increment the velocities
        for (i=1;i<$numEqn-1;i+=2)  // odd numbers are velocities
            state[i] = (state[i-1]-$priorState[i-1])/2.0/$stepSize;
        state[$numEqn-1] += $rate[$numEqn-1]*$stepSize;  // increment the independent parameter
        $currentState = $priorState.concat();  // save the current state as the prior state
        return $stepSize;
    }

      // ---------------------------------------------

    /**
     * @method  setStepSize
     * @description   Sets the step size. The step size remains fixed in this
     *                algorithm. The prior state array is reinitialized.
     * @usage  <pre>inst.setStepSize(_stepSize);</pre>
     * @param   _stepSize  (Number) -- step integer.
     * @return  (void)
    **/
    public function setStepSize(_stepSize:Number):void {
        $stepSize = _stepSize;
        estimatePreviousState($ode.getState());
    }

      // ---------------------------------------------

    /**
     * @method  getStepSize
     * @description   Gets the step size. The stepsize is constant in this algorithm.
     * @usage  <pre>inst.getStepSize();</pre>
     * @return  (Number)  -- returns step size.
    **/
    public function getStepSize():Number {
        return $stepSize;
    }

      // ---------------------------------------------

    /**
     * @method  setTolerance
     * @description   Abstract interface method.
     * @usage  <pre>not used.</pre>
     * @param   _tol  (Number) -- .
     * @return  (void)
    **/
    public function setTolerance(_tol:Number):void {}

      // ---------------------------------------------

    /**
     * @method  getTolerance
     * @description  Abstract interface method.
     * @usage  <pre>not used.</pre>
     * @return  (Number)
    **/
    public function getTolerance():Number {return 1.0e-9;}

      // ---------------------------------------------

    /**
     * @method  estimatePreviousState
     * @description   Estimate's the previous state. The Verlet method is not
     *                self-starting.
     * @usage  <pre>inst.estimatePreviousState(state);</pre>
     * @param   state  (Array) -- state array.
     * @return  (void)
    **/
    private function estimatePreviousState(state:Array):void {
    	var i:uint;
        $ode.getRate(state, $rate);  // get the rate at the start
        var midstate:Array = new Array($numEqn);
        for (i=0;i<$numEqn;i++) {
            // estimate the state at the midpoint
            midstate[i] = state[i]-$stepSize*$rate[i]/2;
        }
        $ode.getRate(midstate, $rate);  // get the rate at the midpoint
        for (i=0;i<$numEqn;i++)
            $priorState[i] = state[i]-$stepSize*$rate[i];
    }
}// class
}//package

