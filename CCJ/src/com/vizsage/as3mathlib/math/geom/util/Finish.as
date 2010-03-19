package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.Finish
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Finish Class.
 *              <p>
 *		        Provides utility methods for the IObj interface based on JS
 *              RayTracer2 by John Haggerty.
 * @usage       <pre>var inst:Finish = new Finish(specular, glossiness, reflection, ambient, diffuse)</pre>
 * @param       specular (Number)  -- a real number between 0 and 1.
 * @param       glossiness (Number)  -- a real number between 1 and infinity.
 * @param       reflection (Number)  -- a real number between 0 and 1.
 * @param       ambient (Number)  -- a real number between 0 and 1.
 * @param       diffuse (Number)  -- a real number between 0 and 1.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.geom.util.Texture
 * -----------------------------------------------
 * AS2 revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
 * JS  original copyright � 2003, John Haggerty  [http://www.slimeland.com/]
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
 *       Finish(specular, glossiness, reflection, ambient, diffuse)
 *             1.  copy()
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This class is under construction .. it presently loads
 *       without error, but the testing environment is incomplete. There are
 *       traces and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.geom.util.Texture;

public class Finish  {
	/**
	 * @property $specular (Number)  -- a real number between 0 and 1.
	 * @property $glossiness (Number)  -- a real number between 1 and infinity.
	 * @property $reflection(Number)  -- a real number between 0 and 1.
	 * @property $ambient (Number)  -- a real number between 0 and 1.
	 * @property $diffuse (Number)  -- a real number between 0 and 1.
	**/
    public var $specular:Number;
    public var $glossiness:Number;
    public var $reflection:Number;
    public var $ambient:Number;
    public var $diffuse:Number;

    // constructor
    public function Finish(specular:Number, glossiness:Number, reflection:Number, ambient:Number, diffuse:Number) {
        trace ("Finish Class fired");
	    if (typeof(specular)=="undefined") $specular = 0;
	    else $specular = specular;
	    if (typeof(glossiness)=="undefined") $glossiness = 10;
	    else $glossiness = glossiness;
	    if (typeof(reflection)=="undefined") $reflection = 0;
	    else $reflection = reflection;
	    if (typeof(ambient)=="undefined") $ambient = Texture.$defaultAmbientLight;
	    else $ambient = ambient;
	    if (typeof(diffuse)=="undefined") $diffuse = 1-Texture.$defaultAmbientLight;
	    else $diffuse = diffuse;
    }

      // 1. copy ---------------------------------------

    /**
     * @method  copy
     * @description  Copies this instance's properties.
     * @usage  <pre>inst.copy();</pre>
     * @return  (Finish)  -- returns a new Finish object, a copy of this instance.
    **/
    public function copy():Finish {
	    return new Finish($specular, $glossiness, $reflection, $ambient, $diffuse);
    }

}// class
}//package

