package com.vizsage.as3mathlib.math.alg {
/**
 * @class       com.vizsage.as3mathlib.math.alg.Polynomial
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Polynomial Class -- provides
 *              methods for polynomial calculations up to the 4th degree.
 *		        <p>
 * @usage       <pre>var inst:Polynomial = new Polynomial()</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * Dependency:    com.vizsage.as3mathlib.math.alg.Vector
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
 *   Functions:
 *       Polynomial()
 *           1.  init(coefs)
 *           2.  eval(x)
 *           3.  multiply(that)
 *           4.  divideScalar(scalar)
 *           5.  simplify()
 *           6.  bisection(min, max)
 *           7.  toString()
 *           8.  get _degree()
 *           9.  getDerivative()
 *           10. getRoots()
 *           11. getRootsInInterval(min, max)
 *           12. getLinearRoot()
 *           13. getQuadraticRoots()
 *           14. getCubicRoots()
 *           15. getQuarticRoots()
 *           16. pow2(num, exp)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Polynomial  {
	/**
	 * @property $coefs  -- array to hold polynomial coefficients.
	 * @property $TOLERANCE  -- static -- minimum value to truncate computation.
	 * @property $ACCURACY  -- static -- ceiling applied to log value in 'bisection' method.
	**/
    private var $coefs:Array;
    public static var $TOLERANCE:Number = 1e-6;
    public static var $ACCURACY:Number  = 6;

    // constructor
    public function Polynomial(...args) {
        //trace ("Polynomial Class loaded");
        this.init(args);
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Populates new instance's $coefs array with input array values.
     * @usage  <pre>inst.init(coefs);</pre>
     * @param   coefs   (Array)  -- an array containing coefficients of this instance.
     * @return  (void)
    **/
    private function init(coefs:Array):void {
        $coefs = [];
        var j:Number;

        for (j=coefs.length-1;j>=0;j--) $coefs.push(coefs[j]);
    }

      // 2. eval ---------------------------------------

    /**
     * @method  eval
     * @description  Calculates result of summation of coefficient multiplication
     *               by the input value.
     * @usage  <pre>inst.eval(x);</pre>
     * @param   x   (Number)  -- a real number.
     * @return  (Number)  -- returns result of claculation.
    **/
    public function eval(x:Number):Number {
        var result:Number = 0;
        var j:Number;

        for (j=$coefs.length-1;j>=0;j--) result = result*x+$coefs[j];

        return result;
    }

      // 3. multiply -----------------------------------

    /**
     * @method  multiply
     * @description  Calculates multiplication of the coefficients of this
     *               instance and the passed Polynomial object.
     * @usage  <pre>inst.multiply(that);</pre>
     * @param   that   (Polynomial)  -- a Polynomial object.
     * @return  (Polynomial)  -- returns a new Polynomial object containing the result of the multiplications.
    **/
    public function multiply(that:Polynomial):Polynomial {
        var result:Polynomial = new Polynomial();
        var j:Number;
        var k:Number;

        for (j=0;j<=this._degree+that._degree;j++) result.$coefs.push(0);
        for (j=0;j<=this._degree;j++) {
            for (k=0;k<=that._degree;k++) {
                result.$coefs[j+k] += $coefs[j]*that.$coefs[k];
            }
        }

        return result;
    }

      // 4. divideScalar -------------------------------

    /**
     * @method  divideScalar
     * @description  Calculates division of this instance's coefficients by the paseed scalar value.
     * @usage  <pre>inst.divideScalar(scalar);</pre>
     * @param   scalar   (Number)  -- a real number.
     * @return  (void)
    **/
    public function divideScalar(scalar:Number):void {
        var j:Number;

        for (j=0;j<$coefs.length;j++) $coefs[j] /= scalar;
    }

      // 5. simplify -----------------------------------

    /**
     * @method  simplify
     * @description  Simplifies this instance by testing $coefs elements against
     *               class tolerance property.
     * @usage  <pre>inst.simplify();</pre>
     * @return  (void)
    **/
    public function simplify():void {
        var j:Number;

        for (j=this._degree;j>=0;j--) {
            if (Math.abs($coefs[j])<=Polynomial.$TOLERANCE) $coefs.pop();
            else break;
        }
    }

      // 6. bisection ----------------------------------

    /**
     * @method  bisection
     * @description  Calculates bisection of this Polynomial instance.
     * @usage  <pre>inst.bisection(min, max);</pre>
     * @param   min   (Number)  -- a real number.
     * @param   max   (Number)  -- a real number.
     * @return  (Number)  -- returns result of Polynomial bisection operation.
    **/
    public function bisection(min:Number, max:Number):Number {
        var minValue:Number = this.eval(min);
        var maxValue:Number = this.eval(max);
        var result:Number = NaN;
        var j:Number;

        if 		(Math.abs(minValue) <= Polynomial.$TOLERANCE) 	result = min;
        else if (Math.abs(maxValue) <= Polynomial.$TOLERANCE) 	result = max;
        else if (minValue*maxValue <= 0) {
            var tmp1:Number  = Math.log(max-min);
            var tmp2:Number  = Math.log(10)*Polynomial.$ACCURACY;
            var iters:Number = Math.ceil((tmp1+tmp2)/Math.log(2));

            for (j=0;j<iters;j++) {
                result = 0.5*(min+max);
                var value:Number = this.eval(result);
                if (Math.abs(value)<=Polynomial.$TOLERANCE) break;
                if (value*minValue < 0) {
                    max 		= result;
                    maxValue 	= value;
                }
                else {
                    min 		= result;
                    minValue 	= value;
                }
            }
        }
        return result;
    }

      // 7. toString -----------------------------------

    /**
     * @method  toString
     * @description  Creates a string representation of this instance's
     *               coefficients, preserving positive and negative signs.
     * @usage  <pre>inst.toString();</pre>
     * @return  (String)  -- returns a string representation of this instance's coefficients.
    **/
    public function toString():String {
        var coefs:Array = [];
        var signs:Array = [];
        var j:Number;
        var tVal:Number;
        var sign:String;
        var sVal:String;

        for (j=$coefs.length-1;j>=0;j--) {
            var value:Number = $coefs[j];

            if (value!=0) {
                sign = (value<0) ? " - " : " + ";

                value = Math.abs(value);
                tVal = value;
                sVal = value.toString();
                if (j>0) {
                    if (tVal==1) sVal = "x";
                    else sVal += "x";
                }
                if (j>1) sVal += "^"+j;

                signs.push(sign);
                coefs.push(sVal);
            }
        }

        signs[0] = (signs[0]==" + ") ? "" : "-";

        var result:String = "";

        for (j=0;j<coefs.length;j++) result += signs[j]+coefs[j];

        return result;
    }

      // 8. get _degree ----------------------------------

    /**
     * @method  get _degree
     * @description Gets degree of this Polynomial instance.
     * @usage  <pre>inst._degree;</pre>
     * @return  (Number)  -- returns degree of this instance.
    **/
    public function get _degree():Number {
        return $coefs.length-1;
    }

      // 9. getDerivative ------------------------------

    /**
     * @method  getDerivative
     * @description  Gets derivative coefficients of this Polynomial instance.
     * @usage  <pre>inst.getDerivative();</pre>
     * @return  (Polynomial)  -- returns a new Polynomial object containing derivative coefficients of this instance's coefficients.
    **/
    public function getDerivative():Polynomial {
        var derivative:Polynomial = new Polynomial();
        var j:Number;

        for (j=1;j<$coefs.length;j++) {
            derivative.$coefs.push(j*$coefs[j]);
        }

        return derivative;
    }

      // 10. getRoots ----------------------------------

    /**
     * @method  getRoots
     * @description  Gets roots of this Polynomial instance.
     * @usage  <pre>inst.getRoots();</pre>
     * @return  (Array)  -- returns an array containing polynomial roots.
    **/
    public function getRoots():Array {
        var result:Array;

        this.simplify();
        switch (this._degree) {
            case 0: result = new Array();              break;
            case 1: result = this.getLinearRoot();     break;
            case 2: result = this.getQuadraticRoots(); break;
            case 3: result = this.getCubicRoots();     break;
            case 4: result = this.getQuarticRoots();   break;
            default: result = new Array();
            // should try Newton's method and/or bisection
        }

        return result;
    }

      // 11. getRootsInInterval ------------------------

    /**
     * @method  getRootsInInterval
     * @description  Gets roots in interval of this Polynomial instance.
     * @usage  <pre>inst.getRootsInInterval(min, max);</pre>
     * @param   min   (Number)  -- a real number.
     * @param   max   (Number)  -- a real number.
     * @return  (Array)  -- returns an array containing Polynomial roots.
    **/
    public function getRootsInInterval(min:Number, max:Number):Array {
        var roots:Array = [];
        var root:Number;
        var j:Number;

        if (this._degree==1) {
            root = this.bisection(min, max);
            if (!isNaN(root)) roots.push(root);
        }
        else {
            // get roots of derivative
            var deriv:Polynomial = this.getDerivative();
            var droots:Array = deriv.getRootsInInterval(min, max);

            if (droots.length>0) {
                // find root on [min, droots[0]]
                root = this.bisection(min, droots[0]);
                if (!isNaN(root)) roots.push(root);

                // find root on [droots[i], droots[i+1]] for 0 <= i <= count-2
                for (j=0;j<=droots.length-2;j++) {
                    root = this.bisection(droots[j], droots[j+1]);
                    if (!isNaN(root)) roots.push(root);
                }

                // find root on [droots[count-1], xmax]
                root = this.bisection(droots[droots.length-1], max);
                if (!isNaN(root)) roots.push(root);
            }
            else {
                // polynomial is monotone on [min, max], has at most one root
                root = this.bisection(min, max);
                if (!isNaN(root)) roots.push(root);
            }
        }

        return roots;
    }

      // 12. getLinearRoot -----------------------------

    /**
     * @method  getLinearRoot
     * @description  Gets root of a linear polynomial.
     * @usage  <pre>inst.getLinearRoot();</pre>
     * @return  (Array)  -- returns an array containing linear polynomial root.
    **/
    public function getLinearRoot():Array {
        var result:Array = [];
        var a:Number = $coefs[1];

        if (a!=0) result.push(-$coefs[0]/a);

        return result;
    }

      // 13. getQuadraticRoots -------------------------

    /**
     * @method  getQuadraticRoots
     * @description  Gets roots of a quadratic polynomial.
     * @usage  <pre>inst.getQuadraticRoots();</pre>
     * @return  (Array)  -- returns an array containing quadratic polynomial roots.
    **/
    public function getQuadraticRoots():Array {
        var results:Array = [];

        if (this._degree==2) {
            var a:Number = $coefs[2];
            var b:Number = $coefs[1]/a;
            var c:Number = $coefs[0]/a;
            var d:Number = b*b-4*c;

            if (d>0) {
                var e:Number = Math.sqrt(d);

                results.push(0.5*(-b+e));
                results.push(0.5*(-b-e));
            }
            else if (d==0) {
                // really two roots with same value, but we only return one
                results.push(0.5*-b);
            }
        }

        return results;
    }

      // 14. getCubicRoots -----------------------------

    /**
     * @method  getCubicRoots
     * @description  Gets roots of a cubic polynomial.
     * @usage  <pre>inst.getCubicRoots();</pre>
     * @return  (Array)  -- returns an array containing cubic polynomial roots.
    **/
    public function getCubicRoots():Array {
        var results:Array = [];

        if (this._degree==3) {
            var c3:Number = $coefs[3];
            var c2:Number = $coefs[2]/c3;
            var c1:Number = $coefs[1]/c3;
            var c0:Number = $coefs[0]/c3;
            var a:Number = (3*c1-c2*c2)/3;
            var b:Number = (2*c2*c2*c2-9*c1*c2+27*c0)/27;
            var offset:Number = c2/3;
            var discrim:Number = b*b/4+a*a*a/27;
            var halfB:Number = b/2;
            var tmp:Number;
            var root:Number;

            if (Math.abs(discrim)<=Polynomial.$TOLERANCE) discrim = 0;

            if (discrim>0) {
                var e:Number = Math.sqrt(discrim);

                tmp = -halfB+e;
                if (tmp>=0) root = Polynomial.pow2(tmp, 1/3);
                else root = -Polynomial.pow2(-tmp, 1/3);

                tmp = -halfB-e;
                if (tmp>=0 ) root += Polynomial.pow2(tmp, 1/3);
                else root -= Polynomial.pow2(-tmp, 1/3);

                results.push(root-offset);
            }
            else if (discrim<0) {
                var distance:Number = Polynomial.pow2(-a/3, 1/2);
                var angle:Number = Math.atan2(Math.sqrt(-discrim), -halfB)/3;
                var cos:Number = Math.cos(angle);
                var sin:Number = Math.sin(angle);
                var sqrt3:Number = Math.sqrt(3);

                results.push(2*distance*cos-offset);
                results.push(-distance*(cos+sqrt3*sin)-offset);
                results.push(-distance*(cos-sqrt3*sin)-offset);
            }
            else {
                if (halfB>=0) tmp = -Polynomial.pow2(halfB, 1/3);
                else tmp = Polynomial.pow2(-halfB, 1/3);
                results.push(2*tmp-offset);
                // really should return next root twice, but we return only one
                results.push(-tmp-offset);
            }
        }

        return results;
    }

      // 15. getQuarticRoots ---------------------------

    /**
     * @method  getQuarticRoots
     * @description  Gets roots of a quartic polynomial.
     * @usage  <pre>inst.getQuarticRoots();</pre>
     * @return  (Array)  -- returns an array containing quartic polynomial roots.
    **/
    public function getQuarticRoots():Array {
        var results:Array = [];
        var d:Number;
        var e:Number;
        var f:Number;
        var t1:Number;
        var t2:Number;
        var plus:Number;
        var minus:Number;

        if (this._degree==4) {
            var c4:Number = $coefs[4];
            var c3:Number = $coefs[3]/c4;
            var c2:Number = $coefs[2]/c4;
            var c1:Number = $coefs[1]/c4;
            var c0:Number = $coefs[0]/c4;
            var resolveRoots:Array = new Polynomial(1, -c2, c3*c1-4*c0, -c3*c3*c0+4*c2*c0-c1*c1).getCubicRoots();
            var y:Number = resolveRoots[0];
            var discrim:Number = c3*c3/4-c2+y;

            if (Math.abs(discrim)<=Polynomial.$TOLERANCE) discrim = 0;

            if (discrim>0) {
                e = Math.sqrt(discrim);
                t1 = 3*c3*c3/4-e*e-2*c2;
                t2 = ( 4*c3*c2-8*c1-c3*c3*c3)/(4*e);
                plus = t1+t2;
                minus = t1-t2;

                if (Math.abs(plus)<=Polynomial.$TOLERANCE) plus = 0;
                if (Math.abs(minus)<=Polynomial.$TOLERANCE) minus = 0;

                if (plus>=0) {
                    f = Math.sqrt(plus);

                    results.push(-c3/4+(e+f)/2);
                    results.push(-c3/4+(e-f)/2);
                }
                if (minus>=0) {
                    f = Math.sqrt(minus);
                    results.push(-c3/4+(f-e)/2);
                    results.push(-c3/4-(f+e)/2);
                }
            }
            else if (discrim<0) {
                // no roots
            }
            else {
                t2 = y*y-4*c0;

                if (t2>=-Polynomial.$TOLERANCE) {
                    if (t2<0) t2 = 0;
                    t2 = 2*Math.sqrt(t2);
                    t1 = 3*c3*c3/4-2*c2;
                    if (t1+t2>=Polynomial.$TOLERANCE) {
                        d = Math.sqrt(t1+t2);
                        results.push(-c3/4+d/2);
                        results.push(-c3/4-d/2 );
                    }
                    if (t1-t2>=Polynomial.$TOLERANCE) {
                        d = Math.sqrt(t1-t2);
                        results.push(-c3/4+d/2);
                        results.push(-c3/4-d/2);
                    }
                }
            }
        }

        return results;
    }

      // 16. pow2 --------------------------------------

    /**
     * @method  pow2
     * @description  Solves the Math.pow() negative value input bug.
     * @usage  <pre>inst.pow2(a, n);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   n   (Number)  -- a real number.
     * @return  (Number)  -- returns the result of the 'Math.pow' method.
    **/
    public static function pow2(a:Number, n:Number):Number {
        return (a==0) ? 0 : (a>0 ? Math.pow(a, n) : Math.pow(a*-1, n)*-1);
    }

}// class
}//package

