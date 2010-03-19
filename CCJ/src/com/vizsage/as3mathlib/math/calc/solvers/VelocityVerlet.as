package com.vizsage.as3mathlib.math.calc.solvers {
	import com.vizsage.as3mathlib.math.calc.IODESolver;
	import com.vizsage.as3mathlib.math.calc.IODE;
	
/**
 * @class       com.vizsage.as3mathlib.math.calc.solvers.VelocityVerlet
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description VelocityVerlet:  A velocity Verlet method IODE solver. The velocity
 *              Verlet algorithm is a self-starting equivalent of the Verlet
 *              algorithm. It assumes a constant acceleration to estimate the
 *              final position and an average accleration to estimate the final
 *              velocity. The position is first updated, the force is calcualted
 *              at the new position, and then the velocity is updated.
 *
 *              <pre> x(n+1) = x(n) + v(n)* dt + a(n)*dt*dt/2
 *              a_est=F(x(n+1), v(n), t)/m
 *              v(n+1) = v(n) + (a(n)+a_est)*dt/2</pre>
 *
 *              CAUTION! The IODE interface produces an inefficient implementation
 *              of the velocity Verlet algorithm since the force is evaluated twice.
 *              The velocity Verlet algorithm is usually coded directly into the
 *              model so that the force need only be evaluated once.
 *              <p>
 *              CAUTION! This implementation assumes that the state vector has
 *              2*N + 1 variables. These variables alternate between position and
 *              velocity with the last variable being time. That is, the state
 *              vector is ordered as follows:
 *
 *              <pre> x1, d x1/dt, x2, d x2/dt, x3, d x3/dt ..... xN, d xN/dt, t</pre>
 * @usage       <pre>var inst:VelocityVerlet = new VelocityVerlet(_ode);</pre>
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
 *       VelocityVerlet(_ode)
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


public class VelocityVerlet implements com.vizsage.as3mathlib.math.calc.IODESolver {
	/**
	 * @property $stepSize  (Number)  -- parameter increment such as delta time.
	 * @property $numEqn  (Number)  -- number of equations.
	 * @property $rate1  (Array)  -- array that stores the 1st rate.
	 * @property $rate2  (Array)  -- array that stores the 2nd rate.
	 * @property $ode  (IODE)  -- object that computes rate.
	**/
    private var $stepSize:Number = 0.1;
    private var $numEqn:Number = 0;
    private var $rate1:Array;   // rate with orginal positions
    private var $rate2:Array;  // rate with new positions
    private var $ode:IODE;

    public function VelocityVerlet(_ode:IODE) {
        $ode = _ode;
        initialize($stepSize);
    }

      // ---------------------------------------------

    /**
     * @method  initialize
     * @description   Initializes the IODE solver. Two temporary rate arrays are
     *                allocated. The number of differential equations is determined
     *                by invoking getState().length on the IODE.
     * @usage  <pre>inst.initialize(_stepSize);</pre>
     * @param   _stepSize  (Number) -- step integer.
     * @return  (void)
    **/
    public function initialize(_stepSize:Number):void {
        $stepSize = _stepSize;
        var state:Array = $ode.getState();
        // state vector not defined.
        if (state==null) $numEqn = 0;
        else $numEqn = state.length;
        $rate1 = new Array($numEqn);
        $rate2 = new Array($numEqn);
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
        if (state.length!=$numEqn) initialize($stepSize);
        $ode.getRate(state, $rate1);  			// get the initial rate
        var dt2:Number = $stepSize*$stepSize;  	// the step size squared
        
        // increment the positions using the velocity and acceleration
        for (i=0;i<$numEqn-1;i+=2) {
            state[i] = state[i]+$stepSize*$rate1[i]+dt2*$rate1[i+1]/2;
        }
        
        $ode.getRate(state, $rate2);  			// get rate using the new positions
        for (i=1;i<$numEqn-1;i+=2) {
            // increment the velocities with the average rate
            state[i] = state[i]+$stepSize*($rate1[i]+$rate2[i])/2.0;
        }
        
        state[$numEqn-1] += $rate1[$numEqn-1]*$stepSize;  // increment the independent parameter
        return $stepSize;
    }

      // ---------------------------------------------

    /**
     * @method  setStepSize
     * @description   Sets the step size. The step size remains fixed in this
     *                algorithm.
     * @usage  <pre>inst.setStepSize(_stepSize);</pre>
     * @param   _stepSize  (Number) -- step integer.
     * @return  (void)
    **/
    public function setStepSize(_stepSize:Number):void {
        $stepSize = _stepSize;
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
}// class
}//package

