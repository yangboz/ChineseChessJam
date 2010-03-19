package com.vizsage.as3mathlib.types {
/**
 * @class       com.vizsage.as3mathlib.types.Arr
 * @author      Richard Wright
 * @version     1.7
 * @description Implements the behaviours of the Arr Class.
 *              <p>
 *		        Provides methods for extending the core Array class. It can
 *              be instantiated as an empty array or by a list of arguments,
 *              which first clears then populates the class $arr:Array property.
 * @usage       <pre>var inst:Arr = new Arr();</pre>
 * @param       none -- no class input parameters, or a list of variant parameters.
 * -----------------------------------------------
 * Latest update: August 5, 2004
 * -----------------------------------------------
 * AS2 revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
 * AS1 original copyright � 2003, Robert Penner  [www.robertpenner.com]
 *                        � 2002, Gary Fixler    [amf@garyfixler.com]
 *                        � 2001, Branden Hall   [http://www.waxpraxis.org]
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
 *       Arr()
 *            1.  get _len()
 *            2.  get _min()
 *            3.  get _max()
 *            4.  map(func)
 *            5.  filter(func)
 *            6.  reduce(func)
 *            7.  shuffle()
 *            8.  sortNumeric()
 *            9.  qSort()
 *            10. pairSums()
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Arr extends Array {
	/**
	 * @property $arr (Array) -- private -- an array holder for variant class arguments.
    **/
    private var $arr:Array = [];

    public function Arr(...args) {
        //trace ("Arr Class loaded");
        var j:Number;

        $arr = [];
        for (j=0;j<args.length;j++) $arr.push(args[j]);
    }

      // 1. get _len --------------------------------

    /**
     * @method  get _len
     * @description  Gets length of private class property $arr.
     * @usage  <pre>inst._len;</pre>
     * @return  (Number)  -- returns the class property $arr length.
    **/
    public function get _len():uint {
        return $arr.length;
    }

      // 2. get _min ----------------------------------------

    /**
     * @method  get _min
     * @description  Gets the minimum value of the class property $arr elements.
     * @usage  <pre>inst._min;</pre>
     * @return  (Number)  -- returns the minimum element value.
    **/
    public function get _min():Number {
        var min:Number = $arr[0];
        var j:Number;

        for (j=0;j<$arr.length;j++) if ($arr[j]<min) min = $arr[j];

        return min;
    }

      // 3. get _max ----------------------------------------

    /**
     * @method  get _max
     * @description  Gets the maximum value of the class property $arr elements.
     * @usage  <pre>inst._max;</pre>
     * @return  (Number)  -- returns the maximum element value.
    **/
    public function get _max():Number {
        var max:Number = $arr[0];
        var j:Number;

        for (j=0;j<$arr.length;j++) if ($arr[j]>max) max = $arr[j];

        return max;
    }

      // 4. map ----------------------------------------

    /**
     * @method  map
     * @description  Creates a new Arr instance using this instance $arr arguments
     *               as arguments for the passed function.
     * @usage  <pre>inst.map(func);</pre>
     * @param   func   (Function)  -- a function available to the UI scope.
     * @return  (Arr)  -- returns a new class instance whose property $arr contains a list of the results from passing the function.
    **/
    public function map(func:Function):Arr {
        var result:Arr = new Arr();
        var j:Number;

        for (j=0;j<$arr.length;j++) result.push(func($arr[j]));

        return result;
    }


      // 5. filter -------------------------------------

    /**
     * @method  filter
     * @description  Filters identical elements of the class instance $arr based
     *               on the results of passing the argument function to $arr.
     * @usage  <pre>inst.filter(func);</pre>
     * @param   func   (Function)  -- a function available to the UI scope.
     * @return  (Array)  -- returns an array of identical elements.
    **/
    public function filter(func:Function):Array {
        var result:Array = [];
        var j:Number;

        for (j=0;j<$arr.length;j++) {
            if (func($arr[j])==true) result.push($arr[j]);
        }

        return result;
    }

      // 6. reduce -------------------------------------

    /**
     * @method  reduce
     * @description  A reduction of $arr element values is produced by applying
     *               $arr[n-1] and $arr[n] to the passed function argument.
     * @usage  <pre>inst.reduce(func);</pre>
     * @param   func   (Function)  -- a function available to the UI scope.
     * @return  (Number)  -- returns a result of passing the argument function to $arr elements, replacing 'result' with the new result for each element.
    **/
    public function reduce(func:Function):Number {
        var result:Number = $arr[0];
        var j:Number;

        for (j=1;j<$arr.length;j++) result = func(result, $arr[j]);

        return result;
    }

      // 7. shuffle ------------------------------------

    // exclusive-random

    /**
     * @method  shuffle
     * @description  Randomly shuffles the class property $arr elements.
     * @usage  <pre>inst.shuffle();</pre>
     * @return  (Array)  -- returns a shuffled class property $arr.
    **/
    public function shuffle():Array {
        var len:Number = $arr.length;
        var j:Number;

        for (j=0;j<len;j++) {
            var rand:Number = Math.floor(Math.random()*len);

            //swap current index with a random one
            var temp:Number = $arr[j];
            $arr[j] = $arr[rand];
            $arr[rand] = temp;
        }

        return $arr;
    }

      // 8. sortNumeric --------------------------------

    /**
     * @method  sortNumeric
     * @description  Includes a dependent method 'sortNum' for sort by number
     *               which is passed as an argument to the Array.sort method.
     * @usage  <pre>inst.sortNumeric();</pre>
     * @return  (Array)  -- returns the class instance $arr sorted min-max.
    **/
    public function sortNumeric():Array {
        function sortNum(a:Number, b:Number):Number {
            return a-b;
        }

        return $arr.sort(sortNum);
    }

      // 9. qSort --------------------------------------

    /**
     * @method  qSort
     * @description  Recursive quick sort that sorts class property
     *               $arr elements. This was proven to be faster than
     *               the low-level Array.sort() in Flash 5, and since
     *               it is still a valid method it is included here.
     * @usage  <pre>inst.qSort();</pre>
     * @return  (Array)  -- returns the class instance $arr sorted min-max.
    **/
    public function qSort():Array {
        var bot:Number;
        var top:Number;

        if (arguments[0]==null) bot = 0;
        else bot = arguments[0];
        if (arguments[1]==null) top = $arr.length-1;
        else top = arguments[1];
        if (top-bot==1) {
            if ($arr[top]<$arr[bot]) {
                var temp:Number = $arr[top];

                $arr[top] = $arr[bot];
                $arr[bot] = temp;
            }
        }
        else {
            // Set up loop for tail recursion
            while (bot<top) {
                var j:Number = bot;
                var k:Number = top;
                var pivot:Number = $arr[bot];

                while (j<k) {
                    while ($arr[k]>pivot) --k;
                    $arr[j] = $arr[k];
                    while (j<k && (($arr[j]<pivot) || ($arr[j]==pivot))) ++j;
                    $arr[k] = $arr[j];
                }
                $arr[j] = pivot;
                $arr.qSort(bot, j-1);
                bot = j+1;
            }
        }

        return $arr;
    }

      // 10. pairSums -----------------------------------

    /**
     * @method  pairSums
     * @description  Finds sum pairs of the class property $arr elements
     *               equal to the passed argument.
     * @usage  <pre>inst.pairSums(n);</pre>
     * @param   n   (Number)  -- a real number.
     * @return  (Arr)  -- returns a new class instance containing all pair sums.
    **/
    public function pairSums(n:Number):Arr {
        var l:Array = $arr.slice();
        var k:Arr = new Arr();
        var o1:Number;
        var o2:Number;

        while ((o1=l.length-1)>0) {
            for (o2=o1;o2-->0;) {
                if (l[o1]+l[o2]==n) k.push([l[o1], l[o2]]);
            }
            l.pop();
        }
        return k;
    }

}// class
}//package

