package com.vizsage.as3mathlib.math.geom.intersect2D {
/**
 * @class       com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DParams
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Intersect2DParams Class.
 *              This is an Intersect2D utility class.
 * @usage       <pre>var inst:Intersect2DParams = new Intersect2DParams(name, params);</pre>
 * @param  name (String)  -- a string fo shape type.
 * @param  params (Array)  -- a holder for shape type parameters.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D -- superclass
 *                -- subclass list:
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez2
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez3
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DBez3Bez3
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DCircle
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DLine
 *                    - com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2DParams
 * -----------------------------------------------
 * AS2 revision copyright: � 2003, Richard Wright     [wisolutions2002@shaw.ca]
 * JS  original copyright: � 2000-2002, Kevin Lindsey [http://www.kevlindev.com/]
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
 *       Intersect2DParams(name, params)
 *             1.  init(name, params)
 * -----------------------------------------------
 * Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: - presently not functional - testing in progress  //  *** TODO
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.geom.intersect2D.Intersect2D;

public class Intersect2DParams extends Intersect2D {
	/**
	 * @property $name (String)  -- a string for shape type.
	 * @property $params (Array)  -- a holder for shape type parameters.
	**/
    public var $name:String;
    public var $params:Array;

    // Intersect2DParams
    public function Intersect2DParams (name:String, params:Array) {
    	super(name);
        //trace ("Intersect2DParams loaded");
        if (arguments.length>0) init(name, params);
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Initializes a new class instance.
     * @usage  <pre>inst.init(name, params);</pre>
     * @param   name   (String)   -- a string for shape type.
     * @param   params   (Array)  -- a holder for shape type parameters.
     * @return  void
    **/
    private function init(name:String, params:Array):void {
        $name = name;
        $params = params;
    }

}// class
}//package

      // -----------------------------------------------

      // relevant functions from the shape classes (AS1)

	    ////15. intersectShape
	    //Path.prototype.intersectShape = f\unction(shape)
	    //{
	    //    var result = new Intersect2D("No Intersect");
	    //    for (var i=0;i<this.segments.length;i++)
	    //    {
	    //        var inter = Intersect2D.intersectShapes(this.segments[i], shape);
	    //        result.appendPoints(inter.points);
	    //    }
	    //    if (result.points.length>0) result.status = "Intersect";
	    //    return result;
	    //};
	    //
	    // 16. getIntersect2DParams
	    //Path.prototype.getIntersect2DParams = f\unction()
	    //{
	    //    return new Intersect2DParams("Path", []);
        //};

