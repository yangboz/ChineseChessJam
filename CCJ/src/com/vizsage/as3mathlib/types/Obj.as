package com.vizsage.as3mathlib.types {
/**
 * @class         com.vizsage.as3mathlib.types.Obj
 * @author        Richard Wright
 * @version       1.6
 * @description   Implements the behaviours of the Obj SuperClass.
 *                <p>
 *		          Provides methods for the IObj interface based on JS RayTracer2 by
 *                John Haggerty.
 * @usage         <pre>var inst:Obj = new Obj(arguments);</pre>
 * @param         arguments (variant)  -- arguments vary, depending on subclass instantiation.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * Dependencies:  com.vizsage.as3mathlib.math.alg.Vector
 *                com.vizsage.as3mathlib.math.geom.polytope.Box
 *                com.vizsage.as3mathlib.math.geom.util.Intersection
 *                com.vizsage.as3mathlib.math.geom.util.Ray
 *                com.vizsage.as3mathlib.math.geom.util.Texture
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
 *       Obj(arguments)
 *             1.  copy()
 *             2.  initialize()
 *             3.  findIntersectionsUntransformed(ray)
 *             4.  isPointInsideUntransformed(pos)
 *             5.  getNormalAtUntransformed(pos)
 *             6.  getColorAt(isect, objs, lights, traceLevel, effect)
 *             7.  numericalOrder(a, b) - static
 *             8.  correctBounds()
 *             9.  generalLowLevelObjectInitialization()
 *             10. findBoundInts(v1, v2, dim, odim1, odim2, s, d) - static
 *             11. boundTest(ray)
 *             12. boundTestPoint(pos)
 *             13. findIntersections(ray)
 *             14. getNormalAt(pos, isect)
 *             15. isPointInside(pos)
 *             16. setupDefaultModifiers()
 *             17. copyModifiers(newObj)
 * -----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 * -----------------------------------------------
 * NOTE: This Obj superclass is under construction .. it presently loads
 *       without error, but the testing environment is incomplete, and
 *       method inheritance has yet to be refined. There might be traces
 *       and old code snippets within the code to assist in debugging.
 * -----------------------------------------------
**/

import com.vizsage.as3mathlib.math.alg.Vector;
import com.vizsage.as3mathlib.math.geom.polytope.Box;
import com.vizsage.as3mathlib.math.geom.util.Intersection;
import com.vizsage.as3mathlib.math.geom.util.Ray;
import com.vizsage.as3mathlib.math.geom.util.Texture;
import com.vizsage.as3mathlib.math.geom.util.Transformation;
import com.vizsage.as3mathlib.types.Col;
import flash.geom.ColorTransform;

public class Obj implements com.vizsage.as3mathlib.types.IObj {
	/**
	 * @property $texture (Texture)  -- object passed with class instance 'arguments[0]'.
	 * @property $transform (Transformation)  -- object passed with class instance 'arguments[1]'.
	 * @property $boundedBy (Box)  -- object passed with class instance 'arguments[2]'.
	 * @property $castShadows (Boolean)  -- 'setupDefaultModifiers' default is 'true', slows processing.
	 * @property $inversed (Boolean)  -- 'setupDefaultModifiers' default is 'false'.
	 * @property $infiniteBounds (Boolean)  -- 'setupDefaultModifiers' default is 'false'.
	 * @property $volumeOutsideOfBounds (Boolean)  -- 'setupDefaultModifiers' default is 'false'.
	 * @property $textureOverridesParent (Boolean)  -- 'setupDefaultModifiers' default is 'false'.
	 * @property $maxTraceLevel (Number)  -- value sent from UI main.as.
	 * @property $bailout (Number)  -- value sent from UI main.as.
	 * @property $boundsTransformed (Boolean)  -- static -- default is 'false'.
	**/
    public var $texture:Texture;
    public var $transform:Transformation;
    public var $boundedBy:Box;
    public var $castShadows:Boolean;
    public var $inversed:Boolean;
    public var $infiniteBounds:Boolean;
    public var $volumeOutsideOfBounds:Boolean;
    public var $textureOverridesParent:Boolean;
    public var $maxTraceLevel:Number = 10;
    public var $bailout:Number = 1/255;
    public static var $boundsTransformed:Boolean = false;

    // Class parameters:
    // Texture(mc:MovieClip, color:Col, finish:Finish, pigment:Function)
    // Transformation(vx, vy, vz, c:Vector, dontFindInverse, actualOrder:Boolean)
    // Box(v1, v2:Vector, isBound:Boolean)

    // constructor
    public function Obj() { /*
        trace ("Obj Class loaded");
    	// all 3d objects are subclasses of this
    	$texture 	= texture;
    	$transform 	= new Transformation(args[1]);
    	trace ("$texture: "+$texture+"\n$transform: "+$transform);
    	$boundedBy = new Box(args[2]);
    	trace ("$boundedBy: "+$boundedBy);*/
    }

      // 1. copy() ------------------------------------------

    /**
     * @method  copy
     * @description Virtual function to be overridden by subclass ...
     *              copies super's properties with its 'copyModifiers' method.
     * @usage  <pre>
     *         inst.copy();
     *         // which in turn calls the method:
     *         this.copyModifiers(newObj);
     *         </pre>
     * @param   none   -- no method parameters.
     * @return  (Obj)  -- returns a copy of its properties.
    **/
    public function copy():Obj {
        var obj:Obj = new Obj();
        return obj;
    }

      // 2. initialize --------------------------------------

     /**
      * @method  initialize
      * @description Virtual function to be overridden by subclass ...
      *              defines a bounding box construct and all low-level
      *              instantiation for the subclass instance.
      * @usage  <pre>
      *         var inst:Obj = new Obj();
      *         // which in turn fires the inst.initialize() method
      *         </pre>
      * @param   none   (void)  -- no method parameters.
      * @return  (void)
     **/
     public function initialize():void {}

      // 3. findIntersectionsUntransformed ------------------

    /**
     * @method  findIntersectionsUntransformed
     * @description  Virtual function to be overridden by subclass ...
     *               defines bounding box vertices in 3-space.
     * @usage  <pre>instObj.findIntersectionsUntransformed();</pre>
     * @param   ray   (Ray)  -- tracer object that defines point and direction in n3 space.
     * @return  (Array)  -- returns a list of Intersection objects, or an empty list.
    **/
    public function findIntersectionsUntransformed(ray:Ray):Array {return [];}

      // 4. isPointInsideUntransformed ----------------------

    /**
     * @method  isPointInsideUntransformed
     * @description  Virtual function to be overridden by subclass ...
     *               tests bounding box and vector for union.
     * @usage  <pre>
     *         instObj.isPointInsideUntransformed(pos);
     *         </pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Boolean)
    **/
    public function isPointInsideUntransformed(pos:Vector):Boolean {return true;}

      // 5. getNormalAtUntransformed ------------------------

    /**
     * @method  getNormalAtUntransformed
     * @description  Virtual function to be overridden by subclass ...
     *               which defines bounding box to vector normal in 3-space
     *               before transformation.
     * @usage  <pre>
     *         instObj.getNormalAtUntransformed(pos);
     *         </pre>
     * @param   pos   (Vector)  -- a position Vector object.
     * @return  (Vector)  -- returns normal of untransformed vector.
    **/
    public function getNormalAtUntransformed(pos:Vector):Vector { 
    	return pos; 
    }

      // 6. getColorAt ------------------------------------------------------------

    /**
     * @method  getColorAt
     * @description
     * @usage  <pre>inst.getColorAt(isect, objs, lights, traceLevel, effect);</pre>
     * @param   isect   (Intersection)  -- focus Intersection class instance.
     * @param   objs   (Array)  -- a list of shape objects passed to a Ray class instance.
     * @param   lights   (Array)  -- a list of LightSource class instances.
     * @param   traceLevel   (Number)  -- a real number passed to test against class instance $maxTraceLevel property.
     * @param   effect   (Number)  -- a real number passed to test against class instance $bailout property.
     * @return  (Col)  -- returns a Col object for this subclass instance.
    **/
    public function getColorAt(isect:Intersection, objs:Array, lights:Array, traceLevel:Number, effect:Number):ColorTransform {
    	throw new Error("AS2-AS3 Transition Error: Color changed to ColorTransform and we haven't fixed it yet"); return null; 
    	/*
        trace ("\n$$ 1. getColorAt fired");

    	var pos:Vector = isect.getPos();
    	var dir:Vector = isect.$ray.$dir;
    	var colorHere:Col;
    	var a:Number;

    	trace ("1a. pos.x:"+pos.x+", y:"+pos.y+", z:"+pos.z);
    	trace ("1b. dir.x:"+dir.x+", y:"+dir.y+", z:"+dir.z);

    	for (a=0;a<isect.$objectStack.length;a++) {
    	    trace ("1c. a:"+a+", isect.$objectStack["+a+"].\n    $texture:"+isect.$objectStack[a].$texture+", \n    $transform:"+isect.$objectStack[a].$transform+", \n    $boundedBy:"+isect.$objectStack[a].$boundedBy);
    		if (a==isect.$objectStack.length-1 || isect.$objectStack[a].$textureOverridesParent) {
    			colorHere = isect.$objectStack[a].$texture.colorAt(pos);
    			trace ("1d. Bool ||: true .. colorHere: "+colorHere);
    			break;
    		}
    	}

    	var toReturn:Col = colorHere.scalar($texture.$finish.$ambient);
    	var normal:Vector = getNormalAt(pos, isect);
    	var reflectionDir:Vector;
    	var reflectionRay:Ray;

    	if (Vector.dot(Vector.neg(dir), normal)<0) {
    	    normal = Vector.neg(normal);
    	    trace ("2a.Bool Vector.neg(dir), normal)<0: true .. normal: "+normal);
    	}
    	if ($texture.$finish.$reflection!=0 || $texture.$finish.$specular!=0) {
    	    reflectionDir = Vector.adder(Vector.neg(dir), Vector.scaler(Vector.adder(Vector.scaler(normal, Vector.dot(normal, Vector.neg(dir))), dir), 2));
    	    trace ("2b. Bool ||: true .. reflectionDir: "+reflectionDir);
    	}
    	if ($texture.$finish.$reflection!=0 && traceLevel<$maxTraceLevel && effect>=$bailout) {
    		reflectionRay = new Ray(pos, reflectionDir);
    		toReturn = toReturn.adds(reflectionRay.traceForColor(objs, lights, traceLevel+1, effect*$texture.$finish.$reflection).scalar($texture.$finish.$reflection));
    	    trace ("2c. Bool &&: true .. reflectionRay: "+reflectionRay+", toReturn: "+toReturn);
    	}
    	if ($texture.$finish.$diffuse!=0 || $texture.$finish.$specular!=0) {
    		for (a=0;a<lights.length;a++) {
    		    trace ("2d. Bool ||: true .. a: "+a+" .. lights["+a+"]: "+lights[a]);

    			var lightDir:Vector = Vector.normalizer(Vector.adder(lights[a].pos, Vector.neg(pos)));
    			var cosAngle:Number = Vector.dot(normal, lightDir);

    			if (cosAngle>0) {
    				var incomingLightColor = lights[a].getLightColorAt(objs, pos); // (tests for shadow)

    				trace ("2da. Bool cosAngle>0: true .. incomingLightColor: "+incomingLightColor);
    				if (incomingLightColor.red!=0 || incomingLightColor.green!=0 || incomingLightColor.blue!=0) {
    					//toReturn = Col.adds(toReturn, Col.scalar(Col.mult(colorHere, incomingLightColor), cosAngle*$texture.$finish.$diffuse));
    					toReturn = toReturn.adds(colorHere.mult(incomingLightColor).scalar(cosAngle*$texture.$finish.$diffuse));
    					trace ("2db. Bool ||: true .. toReturn: "+toReturn);
    					if ($texture.$finish.$specular!=0) {
    						var specular:Number = Vector.dot(reflectionDir, lightDir);

    						trace ("2dc. Bool $texture.$finish.$specular!=0: true .. specular: "+specular);
    						if (specular>0) {
    							specular = Math.pow(specular, $texture.$finish.$glossiness);
    							//toReturn = Col.adds(toReturn, Col.scalar(incomingLightColor, specular*$texture.$finish.$specular));
    							toReturn = toReturn.adds(incomingLightColor.scalar(specular*$texture.$finish.$specular));
    						    trace ("2dd. Bool specular>0: true .. specular: "+specular+", toReturn: "+toReturn);
    						}
    					}
    				}
    			}
    		}
    	}

    	return toReturn;
    	*/
    }

      // 7. numericalOrder ------------------------------------------------------------

    /**
     * @method  numericalOrder
     * @description  Static dependent method of Array.sort() for use with Obj
     *               subclasses -- presently only called from Box class instance.
     * @usage  <pre>subclassInst.sort(Obj.numericalOrder);</pre>
     * @param   a   (Number)  -- a real number _arr[n-1] generated with subclass' Array.sort method.
     * @param   b   (Number)  -- a real number _arr[n] generated with subclass' Array.sort method.
     * @return  (Number)  -- returns a positive or negative value which is evaluated by the subclass' Array.sort method.
    **/
    public static function numericalOrder(a:Number, b:Number):Number {
        return a-b;
    }

      // 8. correctBounds ------------------------------------------------------------

    /**
     * @method  correctBounds
     * @description  Changes the class instance bounding box to take
     *               transformations into account.
     * @usage  <pre>inst.correctBounds();</pre>
     * @return  (void)
    **/
    public function correctBounds():void {
        trace ("\n$$ 3. correctBounds fired");

    	var v1:Vector = $boundedBy.$v1;
    	var v2:Vector = $boundedBy.$v2;
    	var a:Number;
    	var corners:Array = [v1,
    					v2,
    					new Vector(v1.x, v1.y, v2.z),
    					new Vector(v1.x, v2.y, v1.z),
    					new Vector(v2.x, v1.y, v1.z),
    					new Vector(v1.x, v2.y, v2.z),
    					new Vector(v2.x, v1.y, v2.z),
    					new Vector(v2.x, v2.y, v1.z)];
        trace ("3a. corners:Array: "+corners);
    	for (a=0;a<8;a++) corners[a] = corners[a].transformed($transform);
    	trace ("3b. corners:Array: "+corners);
    	var nv1:Vector = new Vector(corners[0].x, corners[0].y, corners[0].z);
    	var nv2:Vector = new Vector(corners[0].x, corners[0].y, corners[0].z);

    	for (a=1;a<8;a++) {
    		if (corners[a].x<nv1.x) nv1.x = corners[a].x;
    		if (corners[a].y<nv1.y) nv1.y = corners[a].y;
    		if (corners[a].z<nv1.z) nv1.z = corners[a].z;
    		if (corners[a].x>nv2.x) nv2.x = corners[a].x;
    		if (corners[a].y>nv2.y) nv2.y = corners[a].y;
    		if (corners[a].z>nv2.z) nv2.z = corners[a].z;
    	}
    	$boundedBy.$v1 = nv1;
    	$boundedBy.$v2 = nv2;
    	trace ("3c. $boundedBy.$v1.x:"+$boundedBy.$v1.x+", y:"+$boundedBy.$v1.y+", z:"+$boundedBy.$v1.z+"\n$boundedBy.$v2.x: "+$boundedBy.$v2.x+", y:"+$boundedBy.$v2.y+", z:"+$boundedBy.$v2.z+"\nnv1: "+nv1+"\nnv2: "+nv2);
    }

      // 9. generalLowLevelObjectInitialization ------------------------------------------------------------

    /**
     * @method  generalLowLevelObjectInitialization
     * @description  Called at the end of the initialization function of all
     *               lowest-level object subclasses (spheres, boxes, cylinders, etc).
     * @usage  <pre>inst.generalLowLevelObjectInitialization();</pre>
     * @return  (void)
    **/
    public function generalLowLevelObjectInitialization():void {
        trace ("\n$$ 4. generalLowLevelObjectInitialization fired");
    	$volumeOutsideOfBounds = !$infiniteBounds && $inversed;
    	if (!$infiniteBounds && !$transform.$identity) this.correctBounds();
    	trace ("4a. $volumeOutsideOfBounds: "+$volumeOutsideOfBounds);
    	trace ("4b. (!$infiniteBounds && !$transform.$identity): "+(!$infiniteBounds && !$transform.$identity));
    }

      // 10. findBoundInts ------------------------------------------------------------

    /**
     * @method  findBoundInts
     * @description  Static method used by 'boundTest' method.
     * @usage  <pre>inst.findBoundInts(v1, v2, dim, odim1, odim2, s, d);</pre>
     * @param   v1   (Vector)  -- a bounding box Vector object.
     * @param   v2   (Vector)  -- a bounding box Vector object.
     * @param   dim   (String)  -- a string passing 'x'.
     * @param   odim1   (String)  -- a string passing 'y'.
     * @param   odim2   (String)  -- a string passing 'z'.
     * @param   s   (Vector)  -- local pointer to Ray class instance $start Vector object.
     * @param   d   (Vector)  -- local pointer to Ray class instance $dir Vector object.
     * @return  (Boolean)
    **/
    public static function findBoundInts(v1:Vector, v2:Vector, dim:String, odim1:String, odim2:String, s:Vector, d:Vector):Boolean {
        trace ("\n$$ 5. findBoundInts fired");
        trace ("5a. Bool (d[dim]==0): "+(d[dim]==0));

    	if (d[dim]==0) return false;

    	var int1:Number = (v1[dim]-s[dim])/d[dim];
    	var intPoint1:Vector = Vector.adder(s, Vector.scaler(d, int1));

        trace ("5b. Bool &&(1): "+(int1>0 && intPoint1[odim1]>=v1[odim1] && intPoint1[odim1]<v2[odim1] && intPoint1[odim2]>=v1[odim2] && intPoint1[odim2]<v2[odim2]));
    	if (int1>0 && intPoint1[odim1]>=v1[odim1] && intPoint1[odim1]<v2[odim1] && intPoint1[odim2]>=v1[odim2] && intPoint1[odim2]<v2[odim2]) return true;

    	var int2:Number = (v2[dim]-s[dim])/d[dim];
    	var intPoint2:Vector = Vector.adder(s, Vector.scaler(d, int2));

    	trace ("5c. Bool &&(2): "+(int2>0 && intPoint2[odim1]>=v1[odim1] && intPoint2[odim1]<v2[odim1] && intPoint2[odim2]>=v1[odim2] && intPoint2[odim2]<v2[odim2]));
    	if (int2>0 && intPoint2[odim1]>=v1[odim1] && intPoint2[odim1]<v2[odim1] && intPoint2[odim2]>=v1[odim2] && intPoint2[odim2]<v2[odim2]) return true;

    	return false;
    }

      // 11. boundTest ------------------------------------------------------------

    /**
     * @method  boundTest
     * @description  Boolean to test whether passed 'ray' argument resides
     *               within subclass instance bounding box.
     * @usage  <pre>inst.boundTest(ray);</pre>
     * @param   ray   (Ray)  -- a Ray class instance that defines its $start and $dir Vector objects.
     * @return  (Boolean)
    **/
    public function boundTest(ray:Ray):Boolean {
        trace ("\n$$ 6. boundTest fired");

    	// create bounding box of the transformed object if it hasn't already been created:
    	if ($infiniteBounds) return true;

    	var v1:Vector = $boundedBy.$v1;
    	var v2:Vector = $boundedBy.$v2;
    	var s:Vector = ray.$start;

    	trace ("6a. v1:"+v1+", v2:"+v2+", s:"+s);

    	if (s.x>=v1.x && s.x<=v2.x &&
    	    s.y>=v1.y && s.y<=v2.y &&
    	    s.z>=v1.z && s.z<=v2.z) return true;

    	var d:Vector = ray.$dir;

    	trace ("6b. d:"+d.toString());

    	return (
    		Obj.findBoundInts(v1, v2, "x", "y", "z", s, d) ||
    		Obj.findBoundInts(v1, v2, "y", "x", "z", s, d) ||
    		Obj.findBoundInts(v1, v2, "z", "x", "y", s, d)
    	);
    }

      // 12. boundTestPoint ------------------------------------------------------------

    /**
     * @method  boundTestPoint
     * @description  Boolean used in 'isPointInside' method.
     * @usage  <pre>inst.boundTestPoint(pos);</pre>
     * @param   pos   (Vector)  -- a Vector object defining point wrt to Obj subclass instance.
     * @return  (Boolean)
    **/
    public function boundTestPoint(pos:Vector):Boolean {
        trace ("\n$$ 7. boundTestPoint fired");

    	if ($infiniteBounds) return true;

    	var v1:Vector = $boundedBy.$v1;
    	var v2:Vector = $boundedBy.$v2;

    	trace ("7a. v1:"+v1.toString()+", v2:"+v2.toString());

    	return (
    	    pos.x>=v1.x && pos.y>=v1.y &&
    	    pos.z>=v1.z && pos.x<=v2.x &&
    	    pos.y<=v2.y && pos.z<=v2.z
    	);
    }

      // 13. findIntersections ------------------------------------------------------------

    /**
     * @method  findIntersections
     * @description  Defines all subclass instance intersections found by
     *               referencing the 'ray' argument that exist within its
     *               bounding box.
     * @usage  <pre>inst.findIntersections(ray);</pre>
     * @param   ray   (Ray)  -- a Ray class instance that defines its $start and $dir Vector objects.
     * @return  (Array)  -- returns an array of found intersections.
    **/
    public function findIntersections(ray:Ray):Array {
        trace ("\n$$ 8. findIntersections fired");

    	if ((ray.$isShadowTest && !$castShadows) || !boundTest(ray)) return [];

    	trace ("8a. (ray.$isShadowTest && !$castShadows) || !this.boundTest(ray):"+(ray.$isShadowTest && !$castShadows) || !this.boundTest(ray));

    	if ($transform.$identity) return $boundedBy.findIntersectionsUntransformed(ray);

	    trace ("8b. $transform.$identity:"+($transform.$identity));

    	var usingRay:Ray = ray.transformed($transform.$inverse);
    	var toReturn:Array = $boundedBy.findIntersectionsUntransformed(usingRay);
    	var a:Number;

    	trace ("8c. usingRay:"+usingRay+", toReturn:"+toReturn+", a:"+a);

    	for (a=0;a<toReturn.length;a++) {
    		toReturn[a].$depth *= usingRay.$distMult; // corrects depth since we're changing the intersection's ray
    		toReturn[a].$ray = ray;
    		trace ("8d_"+a+". toReturn["+a+"].$depth:"+toReturn[a].$depth+", toReturn["+a+"].$ray:"+toReturn[a].$ray);
    	}

    	return toReturn;
    }

      // 14. getNormalAt ------------------------------------------------------------

    /**
     * @method  getNormalAt
     * @description  Defines normal vector based on the 'pos' Vector object and
     *               the focus intersection using a winding number algorithm
     *               affecting the direction of the class instance $transform
     *               property.
     * @usage  <pre>inst.getNormalAt(pos, isect);</pre>
     * @param   pos   (Vector)  -- an object defining a point in 3-space wrt the subclass instance.
     * @param   isect   (Intersection)  -- focus intersection.
     * @return  (Vector)  -- returns a normalized Vector object.
    **/
    public function getNormalAt(pos:Vector = null, isect:Intersection = null):Vector {
        trace ("\n$$ 9. getNormalAt fired");
    	throw new Error ("AS2-AS3 Transition Error: what did 'Vector.normalizer( $boundedBy.getNormalAtUntransformed(pos, isect) );' mean?");
		/*
    	var toReturn:Vector;

		// FIXME -- I have no idea what the 
    	//    toReturn = Vector.normalizer( $boundedBy.getNormalAtUntransformed(pos, isect) );
    	// lines should be
    	if ($transform.$identity) {
    	    toReturn = Vector.normalizer( $boundedBy.getNormalAtUntransformed(pos, isect) );
    	    trace ("9a. ($transform.$identity):"+($transform.$identity)+", toReturn:"+toReturn.toString());
    	}
    	else {
    		// multiply by the transpose of the inverse of the Transformation matrix.
    		var transInv:Transformation = $transform.$inverse;
    		var baseNorm:Vector = $boundedBy.getNormalAtUntransformed( pos.transformed(transInv), isect );

    		toReturn = Vector.normalizer
    		(
    		    new Vector
    		    (
    			    Vector.dot(new Vector(transInv.$vx.x, transInv.$vy.x, transInv.$vz.x), baseNorm),
    			    Vector.dot(new Vector(transInv.$vx.y, transInv.$vy.y, transInv.$vz.y), baseNorm),
    			    Vector.dot(new Vector(transInv.$vx.z, transInv.$vy.z, transInv.$vz.z), baseNorm)
    		    )
    		);
    		trace ("9b. transInv:\n"+transInv+", \nbaseNorm:"+baseNorm+", toReturn:"+toReturn.toString());
    	}

    	var inverseIt:Boolean = false;
    	var a:Number;

    	for (a=0;a<isect.$objectStack.length;a++) {
    		if (isect.$objectStack[a].$inversed) inverseIt = !inverseIt;
    		trace ("9c_"+a+". (isect.$objectStack[a].$inversed):"+(isect.$objectStack[a].$inversed)+", inverseIt:"+inverseIt);
    	}

    	if (inverseIt) toReturn = Vector.neg(toReturn);
    	trace ("9d. (inverseIt):"+(inverseIt)+", toReturn:"+toReturn.toString());

    	return toReturn;*/
    	return null;
    }

      // 15. isPointInside ------------------------------------------------------------

    /**
     * @method  isPointInside
     * @description  Boolean to confirm if passed Vector object defines a
     *               point inside this subclass instance's bounding box.
     * @usage  <pre>inst.isPointInside(pos);</pre>
     * @param   pos   (Vector)  -- a Vector object defining a point in 3-space wrt this subclass instance's bounding box.
     * @return  (Boolean)
    **/
    public function isPointInside(pos:Vector):Boolean {
        trace ("\n$$ 10. isPointInside fired");

    	var toReturn:Boolean;

    	if (!boundTestPoint(pos)) toReturn = false;
    	else if ($transform.$identity) toReturn = $boundedBy.isPointInsideUntransformed(pos);
    	else toReturn = $boundedBy.isPointInsideUntransformed(pos.transformed($transform.$inverse));
    	trace ("10a. (!boundTestPoint(pos):"+(!boundTestPoint(pos))+", ($transform.$identity):"+($transform.$identity)+", toReturn:"+toReturn);

    	if ($inversed) toReturn = !toReturn;
    	trace ("10b. ($inversed):"+($inversed)+", toReturn:"+toReturn);

    	return toReturn;
    }

      // 16. setupDefaultModifiers ------------------------------------------------------------

    /**
     * @method  setupDefaultModifiers
     * @description  Sets up subclass instance with low-level superclass properties.
     * @usage  <pre>inst.setupDefaultModifiers();</pre>
     * @return  (void)
    **/
    public function setupDefaultModifiers():void {
        trace ("\n$$ 11. setupDefaultModifiers fired");

        $texture = $texture.$defaultTex.copy();
    	$transform = Transformation.$IdentityTrans.copy();
    	$castShadows = true;
    	$inversed = false;
    	$infiniteBounds = false;
    	$volumeOutsideOfBounds = false;
    	$textureOverridesParent = false;
    	trace ("11a. $transform:\n"+$transform+", \n$castShadows:"+$castShadows+", $inversed:"+$inversed+", $infiniteBounds:"+$infiniteBounds+", \n$volumeOutsideOfBounds:"+$volumeOutsideOfBounds+", $textureOverridesParent:"+$textureOverridesParent);
    }

      // 17. copyModifiers ------------------------------------------------------------

    /**
     * @method  copyModifiers
     * @description  Copies subclass object's superclass properties to 'newObj'
     *               argument and calls the new class instance 'initialize' method.
     * @usage  <pre>inst.copyModifiers(newObj);</pre>
     * @param   newObj   (Obj)  -- new class instance which inherits the Obj superclass properties.
     * @return  (Obj)  -- returns a new Obj class instance with a copy of inherited properties.
    **/
    public function copyModifiers(newObj:Obj):Obj {
        trace ("\n$$ 12. copyModifiers fired");
    	newObj.$texture = $texture.copy();
    	newObj.$transform = $transform.copy();
    	newObj.$castShadows = $castShadows;
    	newObj.$inversed = $inversed;
    	newObj.$infiniteBounds = $infiniteBounds;
    	newObj.$volumeOutsideOfBounds = $volumeOutsideOfBounds;
    	newObj.$textureOverridesParent = $textureOverridesParent;
    	newObj.initialize();
    	trace ("12a. newObj.$texture:"+newObj.$texture+", \n$transform:\n"+newObj.$transform+", \n$castShadows:"+newObj.$castShadows+", $inversed:"+newObj.$inversed+", $infiniteBounds:"+newObj.$infiniteBounds+", \n$volumeOutsideOfBounds:"+newObj.$volumeOutsideOfBounds+", $textureOverridesParent:"+newObj.$textureOverridesParent);

    	return newObj;
    }

}// class
}//package

