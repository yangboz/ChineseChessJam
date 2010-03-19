package com.vizsage.as3mathlib.math.calc {
/**
 * @class       com.vizsage.as3mathlib.math.calc.FunctionRate
 * @author      Richard Wright - wisolutions2002@shaw.ca
 * @version     1.7
 * @description FunctionRate implements the behaviours of the IODE Interface.
 * @usage       <pre>var inst:FunctionRate = new FunctionRate(_f, start);</pre>
 * @param       _f:Function --
 * @param       start:Number --
 * -----------------------------------------------
 * Latest update: September 19, 2004
 * -----------------------------------------------
 * AS2  revision copyright: � 2003, Richard Wright     [wisolutions2002@shaw.ca]
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
 *       FunctionRate(_f, start)
 *           1.  getState()
 *           2.  getRate(state, rate)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.calc.*;

public class FunctionRate implements com.vizsage.as3mathlib.math.calc.IODE {
	/**
	 * @property $state  (Array)  --
	 * @property $f  (Function)  --
	**/
    public var $state:Array = [];
    public var $f:Function;

    public function FunctionRate(_f:Function, start:Number) {
        //trace ("FunctionRate Class loaded");
        $state = new Array(2);

        $state[0] = 0;       // integral
        $state[1] = start;   // independent variable
        $f = _f;
    }

      // 1. getState -----------------------------------------------

    /**
     * @method  getState
     * @description
     * @usage  <pre>inst.getState();</pre>
     * @return  (Array)
    **/
    public function getState():Array {
        //trace ("**FunctionRate getState fired");
        return $state;
    }

      // 2. getRate ------------------------------------------------

    /**
     * @method  getRate
     * @description
     * @usage  <pre>inst.getRate(state, rate);</pre>
     * @param   state  (Array) -- .
     * @param   rate  (Array)  -- .
     * @return  (Array)
    **/
    public function getRate(state:Array, rate:Array):void {
        //trace ("**FunctionRate getState fired");
        rate[0] = $f.call(this, state[1]); // integral
        rate[1] = 1;                      // independent variable
    }

}// class
}//package

