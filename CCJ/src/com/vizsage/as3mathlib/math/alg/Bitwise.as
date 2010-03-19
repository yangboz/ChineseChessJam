package com.vizsage.as3mathlib.math.alg {
/**
 * @class       com.vizsage.as3mathlib.math.alg.Bitwise
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the static behaviours of the Bitwise Class.
 *              <p>
 *		        All methods in this class are static, allowing for inline bitwise
 *              operations without the need for class instantiation.
 * @usage       <pre>Bitwise.classMethod(args);</pre>
 * @param       none  -- no class input parameters.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 revision copyright � 2003, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright � 2002, Jos Juffermans [jjuffermans@CHELLO.com]
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
 *          Bitwise()
 *              1.  binToDec(bin)
 *              2.  decToBin(dec)
 *              3.  binPad(bin, len)
 *              4.  binOr(bin1, bin2, .., binN)
 *              5.  binAnd(bin1, bin2, .., binN)
 *              6.  binXor(bin1, bin2, .., binN)
 *              7.  binNot(bin)
 *              8.  binInvert(bin)
 *              9.  binInvert64(bin)
 *              10. binShiftLeft(bin, pos)
 *              11. binShiftRight(bin, pos)
 *              12. binShiftRightUnsigned(bin, pos)
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Bitwise {
	/**
	 * @property none  -- no class properties.
	**/

    // constructor
    public function Bitwise() {
        //trace ("Bitwise Class loaded");
    }

      // 1. binToDec -----------------------------------

    /**
     * @method  binToDec
     * @description  Converts binary string input to decimal number output.
     * @usage   <pre>Bitwise.binToDec("-01001");</pre>
     * @param   bin   (String)  -- must be a string to avoid octal conversion.
     * @return  (Number)  -- returns a decimal base.
    **/
    public static function binToDec(bin:String):Number {
    	return parseInt(bin, 2);
    }

      // 2. decToBin -----------------------------------

    /**
     * @method  decToBin
     * @description  Converts decimal number input to binary string output.
     * @usage   <pre>Bitwise.decToBin(-9);</pre>
     * @param   dec   (Number)  -- positive or negative integer - method ignores fractional input.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function decToBin(dec:Number):String {
    	return dec.toString(2);
    }

      // 3. binPad -------------------------------------

    /**
     * @method  binPad
     * @description  Pads binary string input to desired bit length string output.
     * @usage   <pre>Bitwise.binPad("0111", 32);</pre>
     * @param   bin   (String)  -- must be a string to avoid octal conversion.
     * @param   len   (Number)  -- 2^n (up to 64) - usually 8, 32, or 64.
     * @return  (String)  -- returns a string representation of a padded binary base.
    **/
    public static function binPad(bin:String, len:Number):String {
        var fill:String;

        if (bin.charAt(0)=="-") fill = "-", bin = bin.substr(1);
        else fill = "";

    	return (fill+"0000000000000000000000000000000000000000000000000000000000000000").substr(0, len-bin.length)+bin;
    }

      // 4. binOr --------------------------------------

    /**
     * @method  binOr
     * @description logical bitwise OR operation
     * @usage   <pre>Bitwise.binOr("110001", "000100", "000111");</pre>
     * @param   arguments   (String)  -- list of binary arguments must be strings to avoid octal conversion.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function binOr(...args):String {
    	var test:Number = parseInt(args[0], 2);
    	var j:Number;

    	for (j=1;j<args.length;j++) {
            test |= parseInt(args[j], 2);
    	}

    	return test.toString(2);
    }

      // 5. binAnd -------------------------------------

    /**
     * @method  binAnd
     * @description  Logical bitwise AND operation.
     * @usage   <pre>Bitwise.binAnd("01001", "1010");</pre>
     * @param   arguments   (String)  -- list of  binary arguments must be strings to avoid octal conversion.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function binAnd(...args):String {
    	var test:Number = parseInt(args[0], 2);
    	var j:Number;

    	for (j=1;j<args.length;j++) {
            test &= parseInt(args[j], 2);
    	}

    	return test.toString(2);
    }

      // 6. binXor -------------------------------------

    /**
     * @method  binXor
     * @description  Logical bitwise XOR operation.
     * @usage   <pre>Bitwise.binXor("01001", "1010");</pre>
     * @param   arguments   (String)  -- list of binary arguments must be strings to avoid octal conversion.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function binXor(...args):String {
    	var test:Number = parseInt(args[0], 2);
    	var j:Number;

    	for (j=1;j<args.length;j++) {
            test ^= parseInt(args[j], 2);
    	}

    	return test.toString(2);
    }

      // 7. binNot -------------------------------------

    /**
     * @method  binNot
     * @description  Logical bitwise NOT operation.
     * @usage   <pre>Bitwise.binNot("01001");</pre>
     * @param   bin   (String)  -- must be a string to avoid octal conversion.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function binNot(bin:String):String {
    	return (~parseInt(bin, 2)).toString(2);
    }

      // 8. binInvert ----------------------------------

    /**
     * @method  binInvert
     * @description  Inverts binary input using logical bitwise XOR operation
     *               and pads to 32 bits.
     * @usage   <pre>Bitwise.binInvert("0101010101010101010101");</pre>
     * @param   bin   (String)  -- must be a string to avoid octal conversion.
     * @return  (String)  -- returns a string representation of a 32-bit binary base.
    **/
    public static function binInvert(bin:String):String {
    	return Bitwise.binXor(bin, ("11111111111111111111111111111111").substr(0, bin.length));
    }

      // 9. binInvert64 -------------------------------

    /**
     * @method  binInvert64
     * @description  Inverts binary input using logical bitwise XOR operation
     *               and pads to 64 bits.
     * @usage   <pre>Bitwise.binInvert64("0101010101010101010101");</pre>
     * @param   bin   (String)  -- must be a string to avoid octal conversion.
     * @return  (String)  -- returns a string representation of a 64-bit binary base.
    **/
    public static function binInvert64(bin:String):String {
    	return Bitwise.binXor(bin, ("1111111111111111111111111111111111111111111111111111111111111111").substr(0, bin.length));
    }

      // 10. binShiftLeft ------------------------------

    /**
     * @method  binShiftLeft
     * @description  Shifts binary string input 'pos' digits to the left --
     *               multiplication.
     * @usage   <pre>Bitwise.binShiftLeft("-01001", 2);</pre>
     * @param   bin   (String)  -- must be a string to avoid octal conversion.
     * @param   pos   (Number)  -- a positive integer.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function binShiftLeft(bin:String, pos:Number):String {
    	return (parseInt(bin, 2)<<pos).toString(2);
    }

      // 11. binShiftRight -----------------------------

    /**
     * @method  binShiftRight
     * @description  Shifts binary string input 'pos' digits to the right --
     *               diviision.
     * @usage   <pre>Bitwise.binShiftRight("-01001", 2);</pre>
     * @param   bin   (String)  --  must be a string to avoid octal conversion.
     * @param   pos   (Number)  -- a positive integer.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function binShiftRight(bin:String, pos:Number):String {
    	return (parseInt(bin, 2)>>pos).toString(2);
    }

      // 12. binShiftRightUnsigned ---------------------

    /**
     * @method  binShiftRightUnsigned
     * @description  The same as the binShiftRight method except that it does
     *               not preserve the sign of the binary string input.
     * @usage   Bitwise.binShiftRightUnsigned("-01001", 2)
     * @param   bin   (String)  -- must be a string to avoid octal conversion.
     * @param   pos   (Number)  -- a positive integer.
     * @return  (String)  -- returns a string representation of a binary base.
    **/
    public static function binShiftRightUnsigned(bin:String, pos:Number):String {
    	return (parseInt(bin, 2)>>>pos).toString(2);
    }

}// class
}//package

