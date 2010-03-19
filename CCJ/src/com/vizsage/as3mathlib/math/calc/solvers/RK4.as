package com.vizsage.as3mathlib.math.calc.solvers {
/**
 * @class       com.vizsage.as3mathlib.math.calc.solvers.RK4
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description A fourth order Runge-Kutta IODE solver. Constructs the RK4
 *              IODESolver for a system of ordinary differential equations.
 * @usage       <pre>var inst:RK4 = new RK4(_ode);</pre>
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
 *       RK4(_ode)
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

/*
 * The org.opensourcephysics.numerics package contains numerical methods
 * for the book Simulations in Physics.
 * Copyright (c) 2003  H. Gould, J. Tobochnik, and W. Christian.
 */
import com.vizsage.as3mathlib.math.calc.*;

public class RK4 implements com.vizsage.as3mathlib.math.calc.IODESolver {
	/**
	 * @property $stepSize  (Number)  -- parameter increment such as delta time.
	 * @property $numEqn  (Number)  -- number of equations.
	 * @property $rate1  (Array)  -- array that stores the 1st rate.
	 * @property $rate2  (Array)  -- array that stores the 2nd rate.
	 * @property $rate3  (Array)  -- array that stores the 3rd rate.
	 * @property $rate4  (Array)  -- array that stores the 4th rate.
	 * @property $k1  (Array)  -- array that stores the 1st computed state.
	 * @property $k2  (Array)  -- array that stores the 2nd computed state.
	 * @property $k3  (Array)  -- array that stores the 3rd computed state.
	 * @property $ode  (IODE)  -- object that computes rate.
	**/
    private var $stepSize:Number = 0.1;
    private var $numEqn:Number  = 0;
    private var $rate1:Array;
    private var $rate2:Array;
    private var $rate3:Array;
    private var $rate4:Array;
    private var $k1:Array;
    private var $k2:Array;
    private var $k3:Array;
    private var $ode:IODE;

    public function RK4(_ode:IODE) {
        $ode = _ode;
        initialize($stepSize);
    }

      // ---------------------------------------------

    /**
     * @method  initialize
     * @description   Initializes the IODE solver. Four rate arrays and three
     *                temporary state arrays are allocated. The number of
     *                differential equations is determined by invoking
     *                getState().length on the IODE.
     * @usage  <pre>inst.initialize(_stepSize)</pre>
     * @param   _stepSize  (Number) -- step integer.
     * @return  (void)
    **/
    public function initialize(_stepSize:Number):void {
        $stepSize = _stepSize;
        var state:Array = $ode.getState();
        // if state vector not defined
        if(state==null) return;
        if($numEqn != state.length) {
            $numEqn = state.length;
            $rate1  = new Array($numEqn);
            $rate2  = new Array($numEqn);
            $rate3  = new Array($numEqn);
            $rate4  = new Array($numEqn);
            $k1     = new Array($numEqn);
            $k2     = new Array($numEqn);
            $k3     = new Array($numEqn);
        }
    }

      // ---------------------------------------------

    /**
     * @method  step
     * @description   Steps (advances) the differential equations by the stepSize.
     *                The IODESolver invokes the IODE's getRate method to obtain
     *                the initial state of the system. The IODESolver then advances
     *                the solution and copies the new state into the state array
     *                at the end of the solution step.
     * @usage  <pre>inst.step()</pre>
     * @return  (Number)  -- returns step size.
    **/
    public function step():Number {
    	var i:uint;
        var state:Array = $ode.getState();
        if (state.length!=$numEqn) initialize($stepSize);
        $ode.getRate(state, $rate1);
        for (i=0;i<$numEqn;i++)
            $k1[i] = state[i]+$stepSize*$rate1[i]/2;
        $ode.getRate($k1, $rate2);
        for (i=0;i<$numEqn;i++)
            $k2[i] = state[i]+$stepSize*$rate2[i]/2;
        $ode.getRate($k2, $rate3);
        for (i=0;i<$numEqn;i++)
            $k3[i] = state[i]+$stepSize*$rate3[i];
        $ode.getRate($k3, $rate4);
        for (i=0;i<$numEqn;i++)
            state[i] = state[i]+$stepSize*($rate1[i]+2*$rate2[i]+2*$rate3[i]+$rate4[i])/6.0;
        return $stepSize;
    }

      // ---------------------------------------------

    /**
     * @method  setStepSize
     * @description   Sets the step size. The step size remains fixed in this
     *                algorithm.
     * @usage  <pre>inst.setStepSize(_stepSize)</pre>
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
     * @usage  <pre>inst.getStepSize()</pre>
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
