package com.vizsage.as3mathlib.types.lists {
/**
 * @class       com.vizsage.as3mathlib.types.lists.Dictionary
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the Dictionary Class.
 *              <p>
 *		        Provides methods for creatung a lookup dictionary, similar
 *              in concept to an associative array.
 * @usage       <pre>var inst:Dictionary = new Dictionary(keyList, dataList)</pre>
 * @param       keyList (Array)  -- a list of categories.
 * @param       dataList (Array)  -- a list of category data.
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2 copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
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
 *       Dictionary(arguments)
 *           1.  init(keyList, dataList)
 *           2.  addKey(key, data)
 *           3.  deleteKey(key)
 *           4.  getKeyData(key)
 *           5.  getKeyString(key)
 *           6.  toString()
 *           7.  copyRecurs()
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class Dictionary extends Object {
	/**
	 * @property none  -- no class properties.
	**/

    public function Dictionary(keyList:Array = null, dataList:Array = null) {
    	keyList  = (keyList == null)  ? (new Array()) : (keyList);
    	dataList = (dataList == null) ? (new Array()) : (dataList);
    	
        //trace ("Dictionary Class loaded");
        if (arguments) this.init(keyList, dataList);
    }

      // 1. init ---------------------------------------

    /**
     * @method  init
     * @description  Initializes this instance and populates it with input.
     * @usage  <pre>inst.init(keyList, dataList);</pre>
     * @param   keyList   (Array)  -- a list of categories.
     * @param   dataList   (Array)  -- a list of category data.
     * @return  (void)
    **/
    private function init(keyList:Array, dataList:Array):void {
        var j:Number;

        for (j=0; j<keyList.length; j++) this[keyList[j]] = dataList[j];
    }

      // 2. addKey -------------------------------------

    /**
     * @method  addKey
     * @description  Adds a category and its data to this instance.
     * @usage  <pre>inst.addKey(key, data);</pre>
     * @param   key   (String)  -- a new category.
     * @param   data   (Object)  -- new category data.
     * @return  (void)
    **/
    public function addKey(key:String, data:Object):void {
        this[key] = data;
    }

      // 3. deleteKey ----------------------------------

    /**
     * @method  deleteKey
     * @description  Deletes a category from this instance.
     * @usage  <pre>inst.deleteKey(key);</pre>
     * @param   key   (String)  -- a category for deletion.
     * @return  (void)
    **/
    public function deleteKey(key:String):void {
        delete this[key];
    }

      // 4. getKeyData ---------------------------------

    /**
     * @method  getKeyData
     * @description  Gets data from passed category.
     * @usage  <pre>inst.getKeyData(key);</pre>
     * @param   key   (String)  -- a category that holds data for return.
     * @return  (Object)  --
    **/
    public function getKeyData(key:String):Object {
        return this[key];
    }

      // 5. getKeyString -------------------------------

    /**
     * @method  getKeyString
     * @description  Gets data from passed category, and creates a string for display.
     * @usage  <pre>inst.getKeyString(key);</pre>
     * @param   key   (String)  -- a category for lookup.
     * @return  (String)  -- returns a string representation of a category and its data.
    **/
    public function getKeyString(key:String):String {
        return key+":"+this[key];
    }

      // 6. toString -----------------------------------

    /**
     * @method  toString
     * @description  Gets all categories and their data, and creates a string
     *               for display.
     * @usage  <pre>inst.toString();</pre>
     * @return  (String)  -- returns a string representation of the entire dictionary.
    **/
    public function toString():String {
        var arr:Array = [];
        var j:Number;
        var str:String = "";

        for (var arg:Object in this) arr.unshift(arg, this[arg]);
        for (j=0;j<arr.length;j+=2) {
        	str += arr[j] + ":" + arr[j+1] + ", ";
        }

        return str.substr(0, -1);
    }

      // 7. copyRecurs ---------------------------------

	// I had to exclude the copying of functions, because it causes infinite
    // recursion. I haven't investigated this too much yet, but this code may serve
    // as a starting point. - Matt Burch
    // http://chattyfig.figleaf.com/ezmlm/ezmlm-cgi/1/51430

    /**
     * @method  copyRecurs
     * @description  Creates a new instance populated with this instance's
     *               categories and data.
     * @usage  <pre>var myCopiedObj = inst.copyRecurs();</pre>
     * @return  (Dictionary)  -- returns a copy of this instance as a new Dictionary.
    **/
    public function copyRecurs():Dictionary {
	    //var temp:Object = {};
	    var temp:Dictionary = new Dictionary();

	    for (var p:Object in this) {
	        var pType:String = typeof this[p];
	        trace (p+":"+pType);
	        var pTypeIsPrimitive:Boolean =
	        (
	            pType=="number" ||
	            pType=="string" ||
	            pType=="object" ||
	            pType=="boolean"
	        );
	        trace ("pTypeIsPrimitive:"+pTypeIsPrimitive);
	        if (pTypeIsPrimitive) {
	            //temp[p] = this[p];
	            temp.addKey(p.toString(), this[p]);
	        }
	        else {
	            //if (pType!="function") temp[p] = this[p].copyRecurs();
	            //else temp[p] = this[p].toString();
	            if (pType!="function") this.init(temp[p], this[p].copyRecurs());
	            else this.init(temp[p], this[p].getKeyString());
	        }
	   }
	   trace ("temp:"+temp.toString());

	   return temp;
	}

}// class
}//package

