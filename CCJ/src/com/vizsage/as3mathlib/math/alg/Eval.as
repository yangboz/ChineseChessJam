package com.vizsage.as3mathlib.math.alg {
/**
 * @class       com.vizsage.as3mathlib.math.alg.Eval
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Eval Class.
 *              <p>
 *		        Provides methods for parsing string expression input, but is
 *              restricted to addition, subtraction, multiplication, division,
 *              and modulo operations. It supports parenthesized operation
 *              precedence as well as normal arithmetic precedence. Bitwise
 *              operations will be introduced to the class eventually.
 *		        <p>
 *              Implementation of Eval class for mathematical expressions:
 *              <blockquote><pre>
 *              &lt;addexpr&gt;     ::= &lt;mulExpr&gt;  ((+|-) &lt;mulExpr&gt;)*
 *              &lt;mulexpr&gt;     ::= &lt;unaryExpr&gt; ((*|/|%) &lt;unaryExpr&gt;)*
 *              &lt;unaryExpr&gt;   ::= [+|-]&lt;primaryExpr&gt;
 *              &lt;primaryExp&gt;  ::= &lt;number&gt; | ( addExpr ) | &lt;functionId&gt;(exprList)
 *              &lt;functionId&gt;  ::= [Math.]( sin | cos | pow | sqrt | tan | atan | ...)
 *              &lt;exprList&gt;    ::= [&lt;addExpr&gt;(, &lt;addExpr&gt;)*]
 *              &lt;number&gt;      ::= &lt;decNumber&gt; | &lt;floatNumber&gt;
 *              </pre></blockquote>
 * @usage       <pre>var inst:Eval = new Eval([stringExp])</pre>
 *              <blockquote><pre>
 *              Simple usage:
 *              var myEval:Eval = new Eval();
 *              trace(myEval.init("2+3"));
 *              trace(myEval.init("2+(3*100)"));
 *              trace(myEval.init("round(sin(2)+random()*1000)"));
 *              <p>
 *              Advanced usage (without variables):
 *              var compiledExp:String = myEval.compile("round(sin(2)+random()*1000)");
 *              for (var i:Number=0;i<5;i++) trace (myEval.execute(compiledExp));
 *              <p>
 *              Advanced usage (with variables):
 *              var compiledExp:String = myEval.compile("x * x");
 *              for (x=-5;x<5;x++) trace (myEval.execute(compiledExp));
 *              </pre></blockquote>
 * @param       stringExp (String)  -- a string representation of a mathematical
 *              expression.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright: � 2003, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright: � 2001, Ralf Bokelberg [www.bokelberg.de/actionscript]
 * -----------------------------------------------
 * nov. 2001 ralf bokelberg v0.01112602
 * actionscript@bokelberg.de
 * new versions can be found at http://www.bokelberg.de/actionscript
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
 *       Eval(stringExp)
 *           1.  init(stringExp)
 *           2.  compile(stringExp)
 *           3.  execute(compiledExp)
 *           4.  token(sName, sType, value)
 *           5.  nextToken()
 *           6.  isNotIDChar(ch)
 *           7.  isOperatorChar(ch)
 *           8.  isNotNumberChar(ch)
 *           9.  error(msg)
 *           10. plus(a, b)
 *           11. minus(a, b)
 *           12. mul(a, b)
 *           13. div(a, b)
 *           14. mod(a, b)
 *           15. pow2(x, y)
 *           16. addExpr()
 *           17. mulExpr()
 *           18. unaryExpr()
 *           19. primaryExpr()
 *           20. exprList(tVal_arr)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Eval  {
	/**
	 * @property $tok (Object)  -- a token object.
	 * @property $bError (Boolean)  -- flag for tracing error message.
	 * @property $iLen (Number)  -- a positive integer.
	 * @property $iPos (Number)  -- an integer.
	 * @property $sErrorMsg (String)  -- an explanation of error.
	 * @property $sExpr (String)  -- lower case of 'stringExp' input.
	 * @property $aStack (Array)  -- stack to hold expression heirarchy.
	**/
    private var $tok:Object = {
        $name:"",
        $type:"",
        $value:null
    };
    private var $bError:Boolean;
    private var $iLen:Number;
    private var $iPos:Number;
    private var $sErrorMsg:String;
    private var $sExpr:String;
    private var $aStack:Array;

    public function Eval(stringExp:String) {
        trace ("***** Eval Class fired");
        if (stringExp!=null) init(stringExp);
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Simple access to compile and execute to calculate an expression
     *               once. Look at compile and execute if you want to execute the
     *               same formula very often. Returns the calculated value of
     *               <tt>stringExp</tt>.
     * @usage  <pre>inst.init(stringExp);</pre>
     * @param   stringExp   (String)  -- a string representation of the expression to be evaluated.
     * @return  (String)  -- returns a string representation of the result of Eval manipulations.
    **/
    private function init(stringExp:String):Object {
        trace ("** Eval execute fired");
    	return execute(compile(stringExp));
    };

      // 2. compile ------------------------------------

    /**
     * @method  compile
     * @description  Translates the stringExp into a compiledExp for later execution.
     *               This is useful if you want to calculate the same expression with
     *               different variables very often.
     * @usage  <pre>inst.compile(stringExp);</pre>
     * @param   stringExp   (String)  -- a string representation of the expression to be evaluated.
     * @return  (String)  -- returns a string representation of the stack to be passed for Eval manipulations.
    **/
    public function compile(stringExp:String):String {
        trace ("** Eval compile fired");
        $bError = false;
        $sErrorMsg = "";
        $sExpr = stringExp.toLowerCase();
        $iLen = stringExp.length;
        $iPos = -1;
        $aStack = [];
        $tok.$name = "";
        $tok.$type = "";
        $tok.$value = null;
        trace ("1. compile: typeof(nextToken): "+(typeof(nextToken)));
        nextToken();
    	if (addExpr()) {
    	    trace ("2. compile: addExp(): "+($iPos>=$iLen)+", "+$aStack);
            if ($iPos>=$iLen) return $aStack.toString();
            else error("3. compile: error: too many tokens");
    	}
    	return $sErrorMsg;
    }

      // 3. execute ------------------------------------

    /**
     * @method  execute
     * @description  Calculate the <tt>compiledExp</tt> (see above) in the actual context
     *               of variables.
     * @usage  <pre>inst.execute(compiledExp);</pre>
     * @param   compiledExp   (String)  -- a string representation of the stack.
     * @return  (String)  -- returns a string representation of the stack's first element after executing the stack manipulation.
    **/
    public function execute(compiledExp:String):String {
        trace ("** Eval execute fired");
        trace ("1. execute: "+compiledExp);
    	var type:String 	= "";
    	var operands:Array 	= [];
    	for (var i:Number=0;i<compiledExp.length;i++) {
            type = compiledExp[i++];
            trace("2. execute: i: "+i+": type: "+type);
            if (type=="n") {
                operands.push( compiledExp[i] );
                trace ("3. execute:  push number ... operands.push(compiledExp["+i+"]): "+compiledExp[i]);
            }
            else if (type=="v") {
            	/*
                operands.push( eval(compiledExp[i]) );*/
                trace ("4. execute:  push variable ... operands.push(compiledExp["+i+"]): "+compiledExp[i]);
                throw new Error("AS2-AS3 Transition Error: can't eval in AS3 (tried to eval("+compiledExp[i]+")");
            }
            else if (type=="f0") {
                operands.push( compiledExp[i]() );
                trace ("5. execute:  push result from f0 ... operands.push(compiledExp["+i+"]()): "); //+compiledExp[i]());
            }
            else if(type=="f1") {
                operands.push( compiledExp[i](operands.pop()) );
                trace ("6. execute:  push result from f1 ... operands.push(compiledExp["+i+"](operands.pop())): "); //+compiledExp[i](operands.pop()));
            }
            else if (type=="f2") {
                operands.push(compiledExp[i](operands.pop(), operands.pop()));
                trace ("7. execute:  push result from f2 ... operands.push(compiledExp["+i+"](operands.pop(), operands.pop())): "); //+compiledExp[i](operands.pop(), operands.pop()));
            }
            else if (type=="f3") {
                operands.push(compiledExp[i](operands.pop(), operands.pop(), operands.pop()));
                trace ("8. execute:  push result from f3 ... operands.push(compiledExp["+i+"](operands.pop(), operands.pop(), operands.pop())): "); //+compiledExp[i](operands.pop(), operands.pop(), operands.pop()));
            }
            else {
                trace ("9. execute: tokentype not recognized: "+type);
                //return error("9. execute: tokentype not recognized: "+type);
            }
            trace ("10. execute: operands: "+operands);
    	}
    	trace ("11. execute: operands: "+operands);
    	trace ("12. execute: operands[0]: "+operands[0]+" : "+typeof(operands[0]));
    	return operands[0];
    }

      // 4. token --------------------------------------

    /**
     * @method  token
     * @description  Defines token object.
     * @usage  <pre>inst.token(sName, sType, value);</pre>
     * @param   sName   (String)  -- token character.
     * @param   sType   (String)  -- type of token.
     * @param   value   (Object)  -- evaluation of sName.
     * @return  (Object)  -- returns populated $tok object.
    **/
    private function token(sName:String, sType:String, value:Object):Object {
        trace ("** Eval token fired");
    	$tok.$name = sName;
    	$tok.$type = sType;
    	$tok.$value = value;
    	trace("new token: "+sName+":"+sType+":"+value+" : "+(typeof(value)));
    	return $tok;
    }

      // 5. nextToken ----------------------------------

    /**
     * @method  nextToken
     * @description  Tests expression input character to decide if it is a token.
     * @usage  <pre>inst.nextToken();</pre>
     * @return  (Boolean)
    **/
    private function nextToken():Boolean {
        trace ("** Eval nextToken fired");
    	var ch:String;
    	var s:String;
    	// skip whitespace
    	do $iPos++;
    	while ($iPos<$iLen && (ch=$sExpr.charAt($iPos))<=" ");
    	if ($iPos>=$iLen) {
            trace ("1. nextToken: $iPos > $sExpr.length");
            return false;
    	}

    	// is it an operator ?
    	if (isOperatorChar(ch)) {
            $tok = token(ch, "", "");
            trace ("2. nextToken: operator: "+ch+" rest:"+$sExpr.substring($iPos+1)+":end");
            return true;
    	}

		// is it an identifier ?
    	if (ch>="a" && ch<="z") {
    	    trace ("3. nextToken: if (ch>='a' && ch<='z')");
            s = ch;
            do {
                $iPos++;
                if ($iPos>=$iLen) break;
                ch = $sExpr.charAt($iPos);
                if (isNotIDChar(ch)) break;
                s += ch;
                trace ("4. nextToken: s: "+s);
            }
            while (1);
            $iPos--;
            if (s.indexOf("math.")==0) s = s.substring(5);
            if (typeof(s)=="function") {
                $tok = token(s, "f", s);
                trace ("5. nextToken: (typeof(s)=='function')) ... $tok: "+$tok);
            }/*
            // FIXME -- can't eval in AS3 
            else if (typeof(eval(s))=="function") {
                $tok = token(s, "f", eval(s));
                trace ("6. nextToken: (typeof(eval(s))=='function')) ... $tok: "+$tok);
            }*/
            else {
                $tok = token(s, "v", s);
                trace ("7. nextToken: else ... $tok: "+$tok);
            }
            trace ("8. nextToken: ID: "+s+" rest:"+$sExpr.substring($iPos+1)+":end");
            return true;

        }

        //is it a number ?
        if ((ch>="0" && ch<="9") || ch==".") {
            s = ch;
            do {
                $iPos++;
                if ($iPos>=$iLen) break;
                ch = $sExpr.charAt($iPos);
                if (isNotNumberChar(ch)) break;
                s += ch;
            }
            while (1);
            $iPos--;
            trace ("9. nextToken: $tok.$type: "+$tok.$type+": $tok.$name: "+$tok.$name+", rest:"+$sExpr.substring($iPos+1)+":end");
            if (typeof(Number(s))=="number") {
                trace ("10. nextToken: (typeof(Number(s))=='number'): "+(typeof(Number(s))=="number"));
                $tok = token(s, "n", Number(s));
                return true;
            }
            else {
                trace ("11. nextToken: (typeof(Number(s))=='number'): "+(typeof(Number(s))=="number"));
                return false;
            }
    	}
    	return error("12. nextToken: no more tokens available: "+ch+" rest: "+$sExpr.substring($iPos+1));
	}

      // 6. isNotIDChar --------------------------------

    /**
     * @method  isNotIDChar
     * @description  Tests input character to decide if it isn't an ID character.
     * @usage  <pre>inst.isNotIDChar(ch);</pre>
     * @param   ch   (String)  -- a single character from 'stringExp'.
     * @return  (Boolean)
    **/
    private function isNotIDChar(ch:String):Boolean {
        trace ("** Eval isNotIDChar fired");
    	return ("abcdefghijklmnopqrstuvwxyz._").indexOf(ch)<0;
    }

      // 7. isOperatorChar -----------------------------

    /**
     * @method  isOperatorChar
     * @description  Tests input character to decide if it is an Operator character.
     * @usage  <pre>inst.isOperatorChar(ch);</pre>
     * @param   ch   (String)  -- a single character from 'stringExp'.
     * @return  (Boolean)
    **/
    private function isOperatorChar(ch:String):Boolean {
        trace ("** Eval isOperatorChar fired");
    	return ("+-*/%(), ").indexOf(ch)>=0;
    }

      // 8. isNotNumberChar ----------------------------

    /**
     * @method  isNotNumberChar
     * @description  Tests input character to decide if it isn't a Number character.
     * @usage  <pre>inst.isNotNumberChar(ch);</pre>
     * @param   ch   (String)  -- a single character from 'stringExp'.
     * @return  (Boolean)
    **/
    private function isNotNumberChar(ch:String):Boolean {
        trace ("** Eval isNotNumberChar fired");
    	return ("0123456789.e").indexOf(ch)<0;
    }

      // 9. error --------------------------------------

    /**
     * @method  error
     * @description  Tests state of $bError Boolean, if false, populates $sErrorMsg.
     * @usage  <pre>inst.error(msg);</pre>
     * @param   msg   (String)  -- an error message.
     * @return  (Boolean)
    **/
    private function error(msg:String):Boolean {
        trace ("** Eval error fired");
    	if (!$bError) {
            $sErrorMsg = "1. ERROR at "+$iPos+": "+msg;
            trace("1. error: $sErrorMsg: "+$sErrorMsg);
            $bError = true;
    	}
    	return false;
    }

      // 10. plus ---------------------------------------

    /**
     * @method  plus
     * @description  Calculates 'a' added to 'b'.
     * @usage  <pre>inst.plus(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  --  a real number.
     * @return  (Number)  -- returns addition result.
    **/
    private function plus(a:Number, b:Number):Number {
        trace ("** Eval plus fired");
    	return a+b;
    }

      // 11. minus --------------------------------------

    /**
     * @method  minus
     * @description  Calculates 'b' subtracted from 'a'.
     * @usage  <pre>inst.minus(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns subtraction result.
    **/
    private function minus(a:Number, b:Number):Number {
        trace ("** Eval minus fired");
    	return a-b;
    }

      // 12. mul ----------------------------------------

    /**
     * @method  mul
     * @description  Calculates 'a' multiplied by 'b'.
     * @usage  <pre>inst.mul(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns multiplication result.
    **/
    private function mul(a:Number, b:Number):Number {
        trace ("** Eval mul fired");
    	return a*b;
    }

      // 13. div ----------------------------------------

    /**
     * @method  div
     * @description  Calculates 'a' division by 'b'.
     * @usage  <pre>inst.div(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns division result.
    **/
    private function div(a:Number, b:Number):Number {
        trace ("** Eval div fired");
    	return a/b;
    }

      // 14. mod ----------------------------------------

    /**
     * @method  mod
     * @description  Calculates 'a' modulo 'b'.
     * @usage  <pre>inst.mod(a, b);</pre>
     * @param   a   (Number)  -- a real number.
     * @param   b   (Number)  -- a real number.
     * @return  (Number)  -- returns modulo result.
    **/
    private function mod(a:Number, b:Number):Number {
        trace ("** Eval mod fired");
    	return a%b;
    }

      // 15. pow2 ----------------------------------------

    /**
     * @method  pow2
     * @description  Solves the 'Math.pow()' negative input bug.
     * @usage  <pre>inst.pow2(x, y);</pre>
     * @param   x   (Number)  -- a real number.
     * @param   y   (Number)  --  a real number.
     * @return  (Number)  -- returns exponentiation result.
    **/
    private function pow2(x:Number, y:Number):Number {
        trace ("** Eval pow2 fired");
        if (x==0 && y>0) return 0;
        if (x<0 && y==Math.floor(y)) {
            if (y%2) return(-Math.pow(-x, y));
            else return Math.pow(-x, y);
        }
        return Math.pow(x, y);
    }

      // 16. addExpr ------------------------------------

    /**
     * @method  addExpr
     * @description  Tests for additive expression -- link in the method chain
     *               calls, called from 'exprList and in turn calls 'multExpr'.
     * @usage  <pre>inst.addExpr();</pre>
     * @return  (Boolean)
    **/
    private function addExpr():Boolean {
        trace ("** Eval addExpr fired");
    	//var r1;
    	//var r2;
    	if (mulExpr()) {
            while (1) {
                if ($tok.$name=="+") {
                    if (!nextToken()) return error("1. addExpr: 1 expression expected");
                    if (mulExpr()) {
                        $aStack.push("f2");
                        $aStack.push(plus);
                    }
                    else return error("2. addExpr: 2 expression expected");
                }
                else if ($tok.$name=="-") {
                    if (!nextToken()) return error("3. addExpr: 3 expression expected");
                    if (mulExpr()) {
                        $aStack.push("f2");
                        $aStack.push(minus);
                    }
                    else return error("4. addExpr: 4 expression expected");
                }
                else break;
            }
            return true;
    	}
    	else return error("5. addExpr: 6 expression expected");
    }

      // 17. mulExpr ------------------------------------

    /**
     * @method  mulExpr
     * @description  Tests for multiplicative expression -- link in the method chain
     *               calls, called from 'addExpr' and in turn calls 'unaryExpr'.
     * @usage  <pre>inst.mulExpr();</pre>
     * @return  (Boolean)
    **/
    private function mulExpr():Boolean {
        trace ("** Eval mulExpr fired");
    	//var r1;
    	//var r2;
    	if (unaryExpr()) {
            while (1) {
                if ($tok.$name=="*") {
                    if (!nextToken()) return error("1. mulExpr: 1 expression expected");
                    if (unaryExpr()) {
                        $aStack.push("f2");
                        $aStack.push(mul);
                    }
                    else return error("2. mulExp: 2 expression expected");
                }
                else if ($tok.$name=="/") {
                    if (!nextToken()) return error("3. mulExpr: 3 expression expected");
                    if (unaryExpr()) {
                        $aStack.push("f2");
                        $aStack.push(div);
                    }
                    else return error("4. mulExp: 4 expression expected");
                }
                else if ($tok.$name=="%") {
                    if (!nextToken()) return error("5. mulExpr: 5 expression expected");
                    if (unaryExpr()) {
                        $aStack.push("f2");
                        $aStack.push(mod);
                    }
                    else return error("6. mulExp: 6 expression expected");
                }
                else break;
            }
            return true;
    	}
    	else return error("7. mulExp: 7 expression expected");
    }

      // 18. unaryExpr ----------------------------------

    /**
     * @method  unaryExpr
     * @description  Tests for unary expression -- final link in chained method calls,
     *               if $tok.$name is not '+' or '-', recurs 'primaryExpr'.
     * @usage  <pre>inst.unaryExpr();</pre>
     * @return  (Boolean)
    **/
    private function unaryExpr():Boolean {
        trace ("** Eval unaryExpr fired");
    	if ($tok.$name=="+") {
            if (!nextToken()) return error("1. unaryExpr: 1 expression expected");
            if (unaryExpr()) return true;
            else return error("2. unaryExpr: 2 expression expected");
    	}
    	else if ($tok.$name=="-") {
            if (!nextToken()) return error("3. unaryExpr: 3 expression expected");
            $aStack.push("n");
            $aStack.push(0);
            if (unaryExpr()) {
                $aStack.push("f2");
                $aStack.push(minus);
                return true;
            }
            else return error("4. unaryExpr: 4 expression expected");
    	}
    	else if (primaryExpr()) return true;
    	else return error("5. unaryExpr: 3 expression expected");
    }

      // 19. primaryExpr --------------------------------

    /**
     * @method  primaryExpr
     * @description  Tests expression by filtering all possible conditions --
     *               the method chain starts here by calling 'exprList, and
     *               continues by successively calling 'addExpr', 'multExpr',
     *               and 'unaryExpr'.
     * @usage  <pre>inst.primaryExpr();</pre>
     * @return  (Boolean)
    **/
    private function primaryExpr():Boolean {
        trace ("** Eval primaryExpr fired");
    	var r1:Object;
    	//var r2;
    	//var r3;
    	var tVal_arr:Array = [];

    	if ($tok.$name=="(") {
            if (!nextToken()) return error("1. primaryExpr: 1 expression expected");
            if (addExpr()) {
                if ($tok.$name==")") {
                    nextToken();
                    return true;
                }
                else return error("2. primaryExpr: 2 ')' expected");
            }
            else return error("3. primaryExpr: 3 expression expected");
    	}
    	else if ($tok.$type=="n") {
            $aStack.push("n");
            $aStack.push($tok.$value);
            trace ("4. primaryExpr: number: tVal??"); //+this.tVal); // no reference
            nextToken();
            return true;
    	}
    	else if ($tok.$type=="f") {
            r1 = $tok;
            if (nextToken() && $tok.$name=="(") {
                if (!nextToken()) return error("5. primaryExpr: 4 token expected");
                if ($tok.$name==")") {
                    nextToken();
                    $aStack.push("f0");
                    $aStack.push(r1.$value);
                    return true;
                }
                else if (exprList(tVal_arr)) {
                    if ($tok.$name==")") {
                        nextToken();
                        $aStack.push("f"+tVal_arr.length);
                        //replace original pow(x, y) because of a bug with x <= 0
                        if (tVal_arr.length==2 && r1.$name=="pow") $aStack.push(pow2);
                        else $aStack.push(r1.$value);
                        trace("function: "+r1.$value+typeof(r1.$value)+typeof(r1));
                        return true;
                    }
                    else return error("6. primaryExpr: 5 ')' expected");
                }
                else return error("7. primaryExpr: 6 exprList expected");
            }
            else return error("8. primaryExp: 7 '(' expected");
    	}
    	else if ($tok.$type=="v") {
            $aStack.push("v");
            $aStack.push($tok.$name);
            nextToken();
            return true;

    	}
    	else return error("9. primaryExpr: 8 expression expected: "+$tok.$name+" "+$tok.$type);
    }

      // 20. exprList -----------------------------------

    /**
     * @method  exprList
     * @description  Called from 'primaryExp' -- tests for the end of expression list.
     * @usage  <pre>inst.exprList(tVal_arr);</pre>
     * @param   tVal_arr   (Array)  -- passed array from 'primaryExpr'.
     * @return  (Boolean)
    **/
    private function exprList(tVal_arr:Array):Boolean {
        trace ("** Eval exprList fired");
    	while (addExpr()) {
            tVal_arr.push(1);
            if ($tok.$name!=", ") break;
            if (!nextToken()) return error("1. exprList: 1 expression expected");
    	}
    	return true;
    }

      //////////////////////////////////////////////////
      // Tests
      //////////////////////////////////////////////////

    /*
    trace("\n\n\n___________________________________________\n" + (s = "2") + " = " + new Eval(s));
    trace("\n\n\n___________________________________________\n" + (s = "2 + 3") + " = " + new Eval(s));
    trace("\n\n\n___________________________________________\n" + (s = "2 * 3") + " = " + new Eval(s));
    trace("\n\n\n___________________________________________\n" + (s = "2 + 3 * 4") + " = " + new Eval(s));
    trace("\n\n\n___________________________________________\n" + (s = "(2 + 3) * 4") + " = " + new Eval(s));
    trace("\n\n\n___________________________________________\n" + (s = "pow(sin(1), 2)") + " = " + new Eval(s));
    trace("\n\n\n___________________________________________\n" + (s = "random() * 10 + sin(1)") + " = " + new Eval(s));
    trace("\n\n\n___________________________________________\n" + (s = "round(random() * 50) + pow(sin(1), 2)") + " = " + new Eval(s));
     */

}// class
}//package

