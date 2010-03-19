package com.vizsage.as3mathlib.math.calc.solvers {
/**
 * @class       com.vizsage.as3mathlib.math.calc.solvers.RK45
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description RK45 implements the behaviours of the IODESolver Interface
 *              -- a Runge-Kutta 4/5 IODE solver with variable step size. Constructs
 *              the RK45 IODESolver for a system of ordinary differential equations.
 * @usage       <pre>var inst:RK45 = new RK45(_ode);</pre>
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
 *       RK45(_ode)
 *           1.  initialize(_stepSize)
 *           2.  step()
 *           3.  setStepSize(_stepSize)
 *           4.  getStepSize()
 *           5.  setTolerance(_tol) -- abstract
 *           6.  getTolerance() -- abstract
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.calc.*;

public class RK45 implements com.vizsage.as3mathlib.math.calc.IODESolver {
    /**
     * @property $b  (Array)  -- nested constants array.
     * @property $ch  (Array)  -- constants array.
     * @property $ct  (Array)  -- constants array.
     * @property $stepSize  (Number)  -- step size.
     * @property $numEqn  (Number)  -- number of equations in the ode.
     * @property $truncErr  (Number)  -- estimated error.
     * @property $err  (Number)  -- maximum error.
     * @property $tol  (Number)  -- tolerance minimum.
     * @property $ode  (IODE)  -- the system of differential equations.
     * @property $tempState  (Array)  -- temporary state array.
     * @property $f  (Array)  -- nested state array.
    **/
    public static var $b:Array = [
        [2.0/9.0],
        [1.0/12.0, 1.0/4.0],
        [69.0/128.0, -243.0/128.0, 135.0/64.0],
        [-17.0/12.0, 27.0/4.0, -27.0/5.0, 16.0/15.0],
        [65.0/432.0, -5.0/16.0, 13.0/16.0, 4.0/27.0, 5.0/144.0]
    ];
    public static var $ch:Array = [47.0/450.0, 0.0, 12.0/25.0, 32.0/225.0, 1.0/30.0, 6.0/25.0];
    public static var $ct:Array = [-1.0/150.0, 0.0, 3.0/100.0, -16.0/75.0, -1.0/20.0, 6.0/25.0];

    /* alternate constants
    public static var $b:Array =
    [
        [1.0/5.0],
        [3.0/40.0, 9.0/40.0],
        [3.0/10.0, -9.0/10.0, 6.0/5.0],
        [226.0/729.0, -25.0/27.0, 880.0/729.0, 55.0/729.0],
        [-181.0/270.0, 5.0/2.0, -266.0/297.0, -91.0/27.0, 189.0/55.0]
    ];
    public static var $ch:Array =[19.0/216.0, 0.0, 1000.0/2079.0, -125.0/216.0, 81.0/88.0, 5.0/56.0];
    public static var $ct:Array =
    [
        31.0/540.0-19.0/216.0,
        0.0,
        190.0/297.0-1000.0/2079.0,
        -145.0/108.0+125.0/216.0,
        351.0/220.0-81.0/88.0,
        1.0/20.0-5.0/56.0
    ];
    */

    private var $stepSize:Number = 0.01;
    private var $numEqn:Number = 0;
    private var $truncErr:Number;
    private var $err:Number;
    protected var $tol:Number = 1.0e-6;
    private var $ode:IODE;
    private var $tempState:Array; // []
    private var $f:Array; // [][]

    public function RK45(_ode:IODE) {
        $ode = _ode;
        initialize($stepSize);
    }

      // 1. initialize ------------------------------------

    /**
     * @method  initialize
     * @description  Initializes the IODE solver. Temporary state and rate arrays
     *               are allocated. The number of differential equations is
     *               determined by invoking getState().length on the IODE.
     * @usage  <pre>inst.initialize(_stepSize);</pre>
     * @param  _stepSize  (Number)  -- the step size.
    **/
    public function initialize(_stepSize:Number):void {
        $stepSize = _stepSize;
        var state:Array = $ode.getState();
        if (state==null) return;                     // state vector not defined.

        if ($numEqn!=state.length) {
            $numEqn = state.length;
            $tempState = new Array($numEqn);
            $f = new Array(6);                       // the six intermediate rates
            for (var j:Number=0;j<6;j++) $f[j] = new Array($numEqn);
        }
    }

      // 2. step -------------------------------------------

    /**
     * @method  step
     * @description  Steps (advances) the differential equations by the $stepSize.
     *               The IODESolver invokes the IODE's getRate method to obtain
     *               the initial state of the system. The IODESolver then advances
     *               the solution and copies the new state into the state array
     *               at the end of the solution step.
     * @usage  <pre>inst.step();</pre>
     * @return  (Number)  -- returns the step size.
    **/
    public function step():Number {
        var state:Array = $ode.getState();
        if (state.length!=$numEqn) initialize($stepSize);
        var i:Number, j:Number, k:Number;                  // loop counters
        var iterations:Number = 10;
        var currentStep:Number = $stepSize;

        $tempState = state.concat();                     // save the initial state
        $ode.getRate(state, $f[0]);                       // get the initial rates
        do {
            iterations--;
            currentStep = $stepSize;
            for (k=1;k<6;k++) {
                for (i=0;i<$numEqn;i++) {
                    state[i] = $tempState[i];            // reset to the initial state
                    for (j=0;j<k;j++) {
                        state[i] = state[i]+$stepSize*$b[k-1][j]*$f[j][i];
                    }
                }
                $ode.getRate(state, $f[k]);               // get the intermediate rates
            }
            $err = 0;
            for (i=0;i<$numEqn;i++) {
                state[i] = $tempState[i];                // reset the initial state
                $truncErr = 0;
                for (k=0;k<6;k++) {
                    state[i] += $stepSize*$ch[k]*$f[k][i];  // step the initial state
                    $truncErr += $stepSize*$ct[k]*$f[k][i]; // estimate the error
                }
                $truncErr = Math.abs($truncErr);
                if ($err<$truncErr) $err = $truncErr;       // find the maximum error
            }
            if ($err<=Number.MIN_VALUE) {                                         // $err is too small to measure
                $err = $tol/1.0e5;  // forces stepsize to increase by a factor of 10
            }
            // find h step for the next try.
            if ($err>$tol) {
                $stepSize = 0.9*$stepSize*Math.pow($tol/$err, 0.25); // shrink if $err is too large
            }
            else if($err<2.0*$tol) {
                $stepSize = 0.9*$stepSize*Math.pow($tol/$err, 0.2); //grow if the $err is too small
            }
        }
        while ($err>$tol && iterations>0);

        return currentStep;        // the value of the step that was actually taken.
    }

      // 3. setStepSize ------------------------------------

    /**
     * @method  setStepSize
     * @description  Sets the step size. The step size may change when the step
     *               method is invoked.
     * @usage  <pre>inst.setStepSize(_stepSize);</pre>
     * @param  _stepSize  (Number)  -- the step size.
    **/
    public function setStepSize(_stepSize:Number):void {
        $stepSize = _stepSize;
    }

      // 4. getStepSize ------------------------------------

    /**
     * @method  getStepSize
     * @description  Gets the step size. The stepsize is adaptive and may
     *               change as the step() method is invoked.
     * @usage  <pre>inst.getStepSize();</pre>
     * @return  (Number)  -- returns the step size.
    **/
    public function getStepSize():Number {
        return $stepSize;
    }

      // 5. setTolerance ------------------------------------

    /**
     * @method  setTolerance
     * @description  Sets $tol class property.
     * @usage  <pre>inst.setTolerance(_tol);</pre>
     * @param _tol  (Number)  -- a real number for tolerance.
    **/
    public function setTolerance(_tol:Number):void {
        $tol = Math.abs(_tol);
    }

      // 6. getTolerance ------------------------------------

    /**
     * @method getTolerance
     * @description  Gets $tol class property.
     * @usage  <pre>inst.getTolerance();</pre>
     * @return  (Number)  -- returns $tol class property.
    **/
    public function getTolerance():Number {
        return $tol;
    }

}// class
}//package

