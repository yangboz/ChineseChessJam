package com.vizsage.as3mathlib.math.geom.util {
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.Texture
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Texture Class.
 *              <p>
 *		        Provides methods for the IObj interface based on JS RayTracer2 by
 *              John Haggerty.
 *              <p>
 *              The <tt>color</tt> argument needs to be setup with a target assigned
 *              to a MovieClip as above. <tt>pigment</tt> is optional and should be
 *              a function that returns a color. The color argument is then ignored.
 *              Required syntax to setup Col object:
 *              <blockquote><pre>
 *              var target:Col = new Col(clip);
 *              var color:Col = new Col(target[, r:Number, g:Number, b:Number]);
 *              optional: col1.init(r:Number, g:Number, b:Number);
 *		        </pre></blockquote>
 * @usage       <pre>var inst:Texture = new Texture(mc, color, finish, pigment);</pre>
 * @param       mc (MovieClip)  -- scope MovieClip object.
 * @param       color (Col)  -- a Col class instance.
 * @param       finish (Finish)  -- a Finich class instance.
 * @param       pigment (Function)  -- a Function object.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.util.Finish
 *                com.vizsage.as3mathlib.math.geom.util.Transformation
 *                com.vizsage.as3mathlib.types.Col
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
 *       Texture(color, finish, pigment)
 *           1. copy()
 *           2. colorAt(pos)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This class is under construction .. it presently loads
 *       without error, but the testing environment is incomplete. There are
 *       traces and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.util.Finish;
import com.vizsage.as3mathlib.math.geom.util.Transformation;
import com.vizsage.as3mathlib.types.Col;
import flash.display.MovieClip;
import flash.geom.ColorTransform;

public class Texture  {
	/**
	 * @property $clip (MovieClip)  -- scope MovieClip object.
	 * @property $target (Col)  -- a Col object for scope.
	 * @property $color (Col)  -- a Col object.
	 * @property $finish (Finish)  -- a Finish object.
	 * @property $pigment (Function)  -- a Function object.
	 * @property $confirm (Function)  -- a Function object.
	 * @property $transform (Transformation)  -- a Transformation object.
	 * @property $err (Object)  -- a debug object containing messages.
	 * @property $errored (Boolean)  -- undefined unless $err object is introduced.
	 * @property $defaultTex (Texture)  -- a Texture object, initialized to white with flat finish.
	 * @property $defaultAmbientLight (Number)  -- static -- referred from Finish class.
	**/
    public var $clip:MovieClip;
    public var $target:		ColorTransform;
	public var $color:		ColorTransform;
    public var $finish:		Finish;
    public var $pigment:	Function;
    public var $confirm:	Function;
    public var $transform:	Transformation;
    public var $err:		Object;
    public var $errored:	Boolean;
    public var $defaultTex:	Texture;
    public static var $defaultAmbientLight:Number = .2;

    // constructor
    public function Texture(mc:MovieClip, color:ColorTransform = null, finish:Finish = null, pigment:Function = null) {
    	throw new Error("AS2-AS3 Transition Error: Color changed to ColorTransform and we haven't fixed it yet"); return null; 
    	/*
        trace ("Texture Class fired");
    	if (color) {
    	    $target = new Col(mc);
	        $color = new Col($target);
    	    $color = color;
	    }
	    else {
	        $target = new Col(mc);
	        $color = new Col($target, 255, 255, 255);
	    }
	    if (finish)	$finish = finish;
	    else $finish = new Finish();
	    if (pigment) $pigment = pigment;
	    $transform = Transformation.$IdentityTrans.copy();
	    $defaultTex = new Texture($clip, new Col($target, 255, 255, 255), new Finish(0, 0));
	    */
    }

      // 1. copy ---------------------------------------

    /**
     * @method  copy
     * @description  Copies this instance's properties.
     * @usage  <pre>inst.copy();</pre>
     * @return  (Texture)  -- returns a new Texture object, a copy of this instance.
    **/
    public function copy():Texture {
	    var toReturn:Texture;
    	var newColor:ColorTransform = new ColorTransform();
    	newColor.concat($color);
		
		// FIXME -- this used to clone the Function $pigment -- now it doesn't -- is this OK?
	    toReturn = new Texture($clip, newColor, $finish.copy(), $pigment);
	    toReturn.$transform = $transform.copy();

	    return toReturn;
    }

      // 2. colorAt ------------------------------------

    /**
     * @method  colorAt
     * @description  Creates a new Col object if $pigment property exists.
     * @usage  <pre>inst.colorAt(pos, mc);</pre>
     * @param   pos   (Vector)  -- a direction Vector object.
     * @param   mc   (MovieClip)  -- passed scope MovieClip object.
     * @return  (Col)  -- returns a new Col object if $pigment, else this instance's $color property.
    **/
    public function colorAt(pos:Vector, mc:MovieClip):ColorTransform {
    	throw new Error("AS2-AS3 Transition Error: Color changed to ColorTransform and we haven't fixed it yet"); return null; 
    	/*
        var toReturn:Col;

	    if ($pigment) {
		    var posTransformed:Vector = pos.transformed($transform.$inverse);

		    try {
		        toReturn = $pigment(posTransformed);
		    }
		    catch ($err) {
			    if (!$confirm("Error in pigment function when evaluated at "+posTransformed+": \n"+$err.message+"\n Substituting black as the return value. Continue render?")) $errored = true;
			    $target = new Col(mc);
			    toReturn = new Col($target);
			    toReturn.init(0, 0, 0);
		    }

		    return toReturn;
	    }

	    else return $color;
	    */
    }

}// class
}//package

