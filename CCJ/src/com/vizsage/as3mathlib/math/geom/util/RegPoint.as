package com.vizsage.as3mathlib.math.geom.util {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	
/**
 * @class       com.vizsage.as3mathlib.math.geom.util.RegPoint
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the RegPoint Class.
 *              <p>
 *		        Provides methods for manipulating a MovieClip's registration point..
 * @usage       <pre>var inst:RegPoint = new RegPoint();</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright � 2003, Robert Penner  [www.robertpenner.com]
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
 *   Functions:
 *       RegPoint()
 *           1.  set _x2(v)
 *           2.  get _x2()
 *           3.  set _y2(v)
 *           4.  get _y2()
 *           5.  set _xscale2(v)
 *           6.  get _xscale2()
 *           7.  set _yscale2(v)
 *           8.  get _yscale2()
 *           9.  set _rotation2(v)
 *           10. get _rotation2(v)
 *           11. get _xmouse2(v)
 *           12. get _ymouse2(v)
 *           13. setPropRel(prop, amount)
 *           14. init()
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class RegPoint extends MovieClip {
	/**
	 * @property $xreg (Number)  -- x-axis position for registration point
	 * @property $yreg (Number)  -- y-axis position for registration point.
	 * @property $pt(MovieClip)  -- clip to display registration ponit.
	**/
    public var $xreg:Number 	= 0;
    public var $yreg:Number 	= 0;
    public var $pt:MovieClip 	= null;

    // constructor
    public function RegPoint(bArg:Array) {
        //trace ("RegPoint Class fired: "+bArg);
        if (bArg) 	init(true);
        else 		init();
    }

      // 1. set _x2 ------------------------------------

    /**
     * @method  set _x2
     * @description  Sets x-axis position wrt parent.
     * @usage  <pre>inst._x2 = v;</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (void)
    **/
    public function set _x2(n:Number):void {
        var a:Point = new Point($xreg,$yreg);
        a = this.localToGlobal(a);
        a = this.parent.globalToLocal(a);
        this.x += n-a.x;
    }

      // 2. get _x2 ------------------------------------

    /**
     * @method  get _x2
     * @description  Gets x-axis position wrt parent.
     * @usage  <pre>inst._x2;</pre>
     * @return  (Number)  -- returns a real number.
    **/
    public function get _x2():Number {
        var a:Point = new Point($xreg,$yreg);
        a = this.localToGlobal(a);
        a = this.parent.globalToLocal(a);
        return a.x;
    }

      // 3. set _y2 ------------------------------------

    /**
     * @method  set _y2
     * @description  Sets y-axis position wrt parent.
     * @usage  <pre>inst._y2 = n;</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (void)
    **/
    public function set _y2(n:Number):void {
        var a:Point = new Point($xreg,$yreg);
        a = this.localToGlobal(a);
        a = this.parent.globalToLocal(a);
        this.y += n-a.y;
    }

      // 4. get _y2 ------------------------------------

    /**
     * @method  get _y2
     * @description  Gets y-axis position wrt parent.
     * @usage  <pre>inst._y2;</pre>
     * @return  (Number)  -- returns a real number.
    **/
    public function get _y2():Number {
        var a:Point = new Point($xreg,$yreg);
        a = this.localToGlobal(a);
        a = this.parent.globalToLocal(a);
        return a.y;
    }

      // 5. set _xscale2 -------------------------------

    /**
     * @method  set _xscale2
     * @description  Sets xscale property of this instance.
     * @usage  <pre>inst._xscale2 = n;</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (void)
    **/
    public function set _xscale2(n:Number):void {
        this.setPropRel("_xscale", n);
    }

      // 6. get _xscale2 -------------------------------

    /**
     * @method  get _xscale2
     * @description  Gets xscale property of this instance.
     * @usage  <pre>inst._xscale2;</pre>
     * @return  (Number)  -- returns a real number.
    **/
    public function get _xscale2():Number {
        return this.scaleX;
    }

      // 7. set _yscale2 -------------------------------

    /**
     * @method  set _yscale2
     * @description   Sets yscale property of this instance.
     * @usage  <pre>inst._yscale2 = n;</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (void)
    **/
    public function set _yscale2(n:Number):void {
        this.setPropRel("_yscale", n);
    }

      // 8. get _yscale2 -------------------------------

    /**
     * @method  get _yscale2
     * @description    Gets yscale property of this instance.
     * @usage  <pre>inst._yscale2;</pre>
     * @return  (Number)  -- returns a real number.
    **/
    public function get _yscale2():Number {
        return this.scaleY;
    }

      // 9. set _rotation2 -----------------------------

    /**
     * @method  set _rotation2
     * @description    Sets rotation property of this instance.
     * @usage  <pre>inst._rotation2 = n;</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (void)
    **/
    public function set _rotation2(n:Number):void {
        this.setPropRel("_rotation", n);
    }

      // 10. get _rotation2 ----------------------------

    /**
     * @method  get _rotation2
     * @description  Gets rotation property of this instance.
     * @usage  <pre>inst._rotation2;</pre>
     * @return  (Number)  -- returns a real number.
    **/
    public function get _rotation2():Number {
        return this.rotation;
    }

      // 11. get _xmouse2 ------------------------------

    /**
     * @method  get _xmouse2
     * @description  Gets x-axis difference between mouse and registration point.
     * @usage  <pre>inst._xmouse2;</pre>
     * @return  (Number)  -- returns x-axis difference.
    **/
    public function get _xmouse2():Number {
        return this.mouseX - $xreg;
    }

      // 12. get _ymouse2 ------------------------------

    /**
     * @method  get _ymouse2
     * @description  Gets y-axis difference between mouse and registration point.
     * @usage  <pre>inst._ymouse2;</pre>
     * @return  (Number)  -- returns y-axis difference.
    **/
    public function get _ymouse2():Number {
        return this.mouseY - $yreg;
    }

      // 13. setPropRel --------------------------------

    /**
     * @method  setPropRel
     * @description  Sets passed property relative to parent coordinates.
     * @usage  <pre>inst.setPropRel(prop, amount);</pre>
     * @param   prop   (String)  -- a string for MC property.
     * @param   amount   (Number)  -- a real number.
     * @return  (void)
    **/
    public function setPropRel(prop:String, amount:Number):void {
        var a:Point = new Point($xreg,$yreg);
        var b:Point = new Point($xreg,$yreg);
        
        this.localToGlobal(a);
        this.localToGlobal(b);
        this.parent.globalToLocal(a);
        this.parent.globalToLocal(b);
        
        this[prop] = amount;
        
        this.x -= b.x-a.x;
        this.y -= b.y-a.y;
    }

      // 14. init --------------------------------------

    /**
     * @method  init
     * @description  Initializes registration point MC $pt.
     * @usage  <pre>inst.init(bArg);</pre>
     * @param   bArg   (Boolean)  -- if true, initializes $pt.
     * @return  (void)
    **/
    private function init(bArg:Boolean=false):void {
        //trace ("RegPoint init fired");
        if (bArg) {
        	// FIXME -- did I do this right?
            $pt = new MovieClip();
            this.addChild($pt);
			with ($pt) {
				_x = 0;
				_y = 0;
				beginFill(0x00FF00, 40);
				lineStyle(0);
				moveTo(-2, -2);
				lineTo(2, -2);
				lineTo(2, 2);
				lineTo(-2, 2);
				lineTo(-2, -2);
				lineTo(2, 2);
				moveTo(-2, 2);
				lineTo(2, -2);
				endFill();
            }
        }
        // this trace shows 2 $pt 's for some reason??
        //for (var arguments in this) {
        //    trace (arguments+":"+this[arguments]);
        //}
    }

}// class
}//package

