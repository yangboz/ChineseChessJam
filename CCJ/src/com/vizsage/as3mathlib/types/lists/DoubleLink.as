package com.vizsage.as3mathlib.types.lists {
/**
 * @class       com.vizsage.as3mathlib.types.lists.DoubleLink
 * @author      Richard Wright
 * @version     1.6
 * @description Implements the behaviours of the DoubleLink Class.
 *              <p>
 *		        Provides methods for replicating in Flash a doubly linked
 *              list API in C, written in 1996 by Carl J. Nobile.
 * @usage       <pre>var inst:DoubleLink = new DoubleLink();</pre>
 * @param       none -- no class input parameters
 * -----------------------------------------------
 * Latest update: July 27, 2004
 * -----------------------------------------------
 * AS2  revision copyright � 2004, Richard Wright [wisolutions2002@shaw.ca]
 * C    original copyright � 1996-1999 Carl J. Nobile - original C API
 *               Created: December 22, 1996
 *               Updated: 06/14/99
 *               http://www.tetrasys.homelinux.org/home/Linklist/ll-1.1.0/Linklist.html
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
 *       DoubleLink()
 *            1.  createList(list)
 *            2.  destroyList()
 *            3.  initializeList(infoSize)
 *            4.  isListEmpty()
 *            5.  isListFull()
 *            6.  getNumberOfRecords()
 *            7.  setSearchModes(origin, dir)
 *            8.  getSearchModes(ssp)
 *            9.  getCurrentIndex()
 *            10. currentPointerToHead()
 *            11. currentPointerToTail()
 *            12. incrementCurrentPointer()
 *            13. decrementCurrentPointer()
 *            14. storeCurrentPointer()
 *            15. restoreCurrentPointer()
 *            16. addRecord(info, pFun(info1, info2))
 *            17. insertRecord(info, dir)
 *            18. swapRecord(dir)
 *            19. updateCurrentRecord(record)
 *            20. deleteCurrentRecord()
 *            21. deleteEntireList()
 *            22. findRecord(record, match, pFun(info1, info2))
 *            23. findNthRecord(record, skip)
 *            24. getCurrentRecord(record)
 *            25. getPriorRecord(record)
 *            26. getNextRecord(record)
 *            27. toString()
 *            28. saveList(path)
 *            29. loadList(path, pFun(info1, info2))
 *  ----------------------------------------------
 *  Updates may be available at:
 *              http://members.shaw.ca/flashprogramming/wisASLibrary/wis/
 *  ----------------------------------------------
**/

public class DoubleLink  {
	/**
	 * @property oReturn (Object)  -- holder for return message pointers.
	 * @property oSrchOrigin (Object)  -- holder for origin of search pointers.
	 * @property oSrchDir (Object) holder for direction of search pointers.
	 * @property list (Object)  -- pointer to list record.
	 * @property node (Object)  -- pointer to node record.
	 * @property info (Object)  -- pointer to info record.
	 * @property head (Object)  -- pointer to head record.
	 * @property tail (Object)  -- pointer to tail record.
	 * @property current (Object)  -- pointer to current record.
	 * @property saved (Object)  -- pointer to stored record.
	 * @property infoSize (Number)  -- size of record incident.
	 * @property listSize (Number)  -- number of records in list.
	 * @property currentIndex (Number)  -- index value of current record.
	 * @property saveIndex (Number)  -- index value of stored record.
	 * @property modified (Boolean)  -- modified flag (TRUE OR FALSE).
	 * @property searchOrigin (Object)  -- location a search originates from.
	 * @property searchDir (Object)  -- direction the search proceeds from.
	 * @property nodeInfo (Object)  -- pointer to record data.
	 * @property nodeNext (Object)  -- pointer to next node.
	 * @property nodePrior (Object)  -- pointer to prior node.
	 * @property infoData (Object)  -- your data goes here.
	 * @property searchModeOrigin (Object)  -- search from head, tail, or current.
	 * @property searchModeDir (Object)  -- search up or down.
	**/

	// Enumeration Objects:

    public var oReturn:Object = {
	    DLL_NORMAL:0,                 // normal operation
	    DLL_MEM_ERROR:1,              // malloc error
	    DLL_ZERO_INFO:2,              // sizeof(info) is zero
	    DLL_NULL_LIST:3,              // List is NULL
	    DLL_NOT_FOUND:4,              // Record not found
	    DLL_OPEN_ERROR:5,             // Cannot open file
	    DLL_WRITE_ERROR:6,            // File write error
	    DLL_READ_ERROR:7,             // File read error
	    DLL_NOT_MODIFIED:8,           // Unmodified list
	    DLL_NULL_FUNCTION:9           // NULL function pointer
	};


    public var oSrchOrigin:Object = {
	    DLL_ORIGIN_DEFAULT:0,         // Use current origin setting
	    DLL_HEAD:1,                   // Set origin to head pointer
	    DLL_CURRENT:2,                // Set origin to current pointer
	    DLL_TAIL:3,                   // Set origin to tail pointer
	    DLL_ABOVE:4,
	    DLL_BELOW:5
	};

	public var oSrchDir:Object = {
	    DLL_DIRECTION_DEFAULT:0,      // Use current direction setting
	    DLL_DOWN:1,                   // Set direction to down
	    DLL_UP:2                      // Set direction to up
	};

    // Class variables:

    public var list:Object = {};
    public var node:Object = {};
    public var info:Object = {};

    // list:
    public var head:Object;                  // pointer to head record
    public var tail:Object;                  // pointer to tail record
    public var current:Object;               // pointer to current record
    public var saved:Object;                 // pointer to stored record
    public var infoSize:Number;              // size of record incident
    public var listSize:Number;              // number of records in list
    public var currentIndex:Number;          // index value of current record
    public var saveIndex:Number;             // index value of stored record
    public var modified:Boolean;             // modified flag (TRUE or FALSE)
    public var searchOrigin:Object;          // location a search originates from
    public var searchDir:Object;             // direction the search proceeds from

    // node: - unused presently
    public var nodeInfo:Object;              // pointer to record data
	public var nodeNext:Object;              // pointer to next node
	public var nodePrior:Object;             // pointer to prior node

	// info: - unused presently
	public var infoData:Object;              // Your data goes here

	// searchMode: - unused presently
	public var searchModeOrigin:Object;      // Search from head, tail, or current
	public var searchModeDir:Object;         // Search up or down

    public function DoubleLink() {
        //trace ("DoubleLink Class loaded");
    }

      ////////////////////////////////////
      // Initialization Functions
      ////////////////////////////////////

      // 1. createList ---------------------------------

    /**
     * @method  createList
     * @description  Creates a structure of type list.
     * @usage  <pre>inst.createList(newList);</pre>
     * @param   newList   (Object)  -- pointer to a name of a structure to create.
     * @return  (Object)  -- returns pointer to created structure - null if unsuccessful.
    **/
    public function createList(newList:Object):Object {
        list = newList;
	    if (list==null) return null;

	    return list;
	}

      // 2. destroyList --------------------------------

    /**
     * @method  destroyList
     * @description  Destroys info, node, and list structures.
     * @usage  <pre>inst.destroyList();</pre>
     * @return  (void)
    **/
    public function destroyList():void {
	    if(this==null) return;

	    deleteEntireList();              // *** TODO
	    delete this;
	}

      // 3. initializeList -----------------------------

    /**
     * @method  initializeList
     * @description  Initializes doubly linked list.
     * @usage  <pre>inst.initializeList(infoSize);</pre>
     * @param   infoSize   (Number)  -- size of user info (bytes).
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Initialization was done successfully
     *                    oReturn.DLL_ZERO_INFO -- sizeof(info) is zero
     *                    oReturn.DLL_NULL_LIST -- info is null
     *                    </pre></blockquote>
    **/
    public function initializeList(infoSize:Number):Object {
	    if (infoSize==0) return oReturn.DLL_ZERO_INFO;
	    if (list==null) return oReturn.DLL_NULL_LIST;

	    head = null;
	    tail = null;
	    current = null;
	    saved = null;
	    infoSize = infoSize;
	    listSize = 0; //0L;               // *** TODO
	    currentIndex = 0; //0L;           // *** TODO
	    saveIndex = 0; //0L;              // *** TODO
	    modified = false;
	    searchOrigin = oSrchOrigin.DLL_HEAD;
	    searchDir = oSrchDir.DLL_DOWN;

	    return oReturn.DLL_NORMAL;
    }

      ////////////////////////////////////
      // Status and State Functions
      ////////////////////////////////////

      // 4. isListEmpty --------------------------------

    /**
     * @method  isListEmpty
     * @description  Checks for an empty list.
     * @usage  <pre>inst.isListEmpty();</pre>
     * @return  (Boolean)  -- returns:
     *                     <blockquote><pre>
     *                     true  -- List is empty
     *                     false -- List has items in it
     *                     </pre></blockquote>
    **/
    public function isListEmpty():Boolean {
	    if (head==null || tail==null) return true;

	    return false;
	}

      // 5. isListFull ---------------------------------

    /**
     * @method  isListFull
     * @description  Checks for a full list.
     * @usage  <pre>inst.isListFull();</pre>
     * @return  (Boolean)  -- returns:
     *                     <blockquote><pre>
     *                     true  -- List is full (memory dependent)
     *                     false -- List is empty or partially full
     *                     </pre></blockquote>
    **/
    public function isListFull():Boolean {
	    var newN:Object = node;
	    var newI:Object = info;

	    if (newN==null) return true;
	    if (newI==null) {
	    	// FIXME -- delete causes complaint in AS3
		    // delete newN;

		    return true;
		}

	    // FIXME -- delete causes complaint in AS3
	    // delete newN;
	    // FIXME -- delete causes complaint in AS3
	   // delete newI;

	    return false;
	}

      // 6. getNumberOfRecords -------------------------

    /**
     * @method  getNumberOfRecords
     * @description  Return number of records.
     * @usage  <pre>inst.getNumberOfRecords();</pre>
     * @return  (Number)  -- returns number of records.
    **/
    public function getNumberOfRecords():Number {
	    return listSize;
	}

      // 7. setSearchModes -----------------------------

    /**
     * @method  setSearchModes
     * @description  Sets the pointer used to start a search origin
     *               and the direction indicator.
     * @usage  <pre>inst.setSearchModes(origin, dir);</pre>
     * @param   origin   (Object)  -- indicates the start search pointer to use.
     * @param   dir   (Object)  -- indicates the direction to search in.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL       -- Values assigned were accepted
     *                    oReturn.DLL_NOT_MODIFIED -- Values were not assigned--invalid type (defaults are still in place)
     *                    </pre></blockquote>
    **/
    public function setSearchModes(origin:Object, dir:Object):Object {
	    switch (origin) {
		    case oSrchOrigin.DLL_HEAD:
		    case oSrchOrigin.DLL_CURRENT:
		    case oSrchOrigin.DLL_TAIL:
		    case oSrchOrigin.DLL_ORIGIN_DEFAULT:
			    break;
		    default:

			    return oReturn.DLL_NOT_MODIFIED;
		}

	    switch (dir) {
		    case oSrchDir.DLL_DOWN:
		    case oSrchDir.DLL_UP:
		    case oSrchDir.DLL_DIRECTION_DEFAULT:
			    break;
		    default:

			    return oReturn.DLL_NOT_MODIFIED;
		}

	    if (origin!=oSrchOrigin.DLL_ORIGIN_DEFAULT) searchOrigin = origin;
	    if (dir!=oSrchDir.DLL_DIRECTION_DEFAULT) searchDir = dir;

	    return (oReturn.DLL_NORMAL);
	}

      // 8. getSearchModes -----------------------------

    /**
     * @method  getSearchModes
     * @description  Returns the search modes.
     * @usage  <pre>inst.getSearchModes(ssp);</pre>
     * @param   ssp   (DoubleLink)  -- save structure pointer.
     * @return  (DoubleLink)  -- returns a pointer to type DLL_SearchModes.
    **/
    public function getSearchModes(ssp:DoubleLink):DoubleLink {
	    ssp.searchOrigin = list.searchOrigin;
	    ssp.searchDir = list.searchDir;

	    return ssp;
	}

      // 9. getCurrentIndex ----------------------------

    /**
     * @method  getCurrentIndex
     * @description  Defines the index of the current record. The index is always
     *               referenced from the head of the list.
     * @usage  <pre>inst.getCurrentIndex();</pre>
     * @return  (Number)  --  returns current record's index.
    **/
    public function getCurrentIndex():Number {
	    return currentIndex;
	}

      ////////////////////////////////////
      // Pointer Manipulation Functions
      ////////////////////////////////////

      // 10. currentPointerToHead ----------------------

    /**
     * @method  currentPointerToHead
     * @description  Moves the current pointer to the head of the list.
     * @usage  <pre>inst.currentPointerToHead();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record found
     *                    oReturn.DLL_NULL_LIST -- Empty list
     *                    </pre></blockquote>
    **/
    public function currentPointerToHead():Object {
	    if (head==null) return oReturn.DLL_NULL_LIST;

	    current = head;
	    currentIndex = 1; //1L;  // *** TODO

	    return oReturn.DLL_NORMAL;
	}

      // 11. currentPointerToTail ----------------------

    /**
     * @method  currentPointerToTail
     * @description  Moves the current pointer to the tail of the list.
     * @usage  <pre>inst.currentPointerToTail();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record found
     *                    oReturn.DLL_NULL_LIST -- Empty list
     *                    </pre></blockquote>
    **/
    public function currentPointerToTail():Object {
	    if (tail==null) return oReturn.DLL_NULL_LIST;

	    current = tail;
	    currentIndex = listSize;

	    return oReturn.DLL_NORMAL;
	}

      // 12. incrementCurrentPointer -------------------

    /**
     * @method  incrementCurrentPointer
     * @description  Moves the current pointer to next position.
     * @usage  <pre>inst.incrementCurrentPointer();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record found
     *                    oReturn.DLL_NULL_LIST -- Empty list
     *                    oReturn.DLL_NOT_FOUND -- Record not found
     *                    </pre></blockquote>
    **/
    public function incrementCurrentPointer():Object {
	    if (current==null) return oReturn.DLL_NULL_LIST;

	    if (current.next==null) return oReturn.DLL_NOT_FOUND;

	    current = current.next;
	    currentIndex++;

	    return (oReturn.DLL_NORMAL);
	}

      // 13. decrementCurrentPointer -------------------

    /**
     * @method  decrementCurrentPointer
     * @description  Moves the current pointer to last position.
     * @usage  <pre>inst.decrementCurrentPointer();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record found
     *                    oReturn.DLL_NULL_LIST -- Empty list
     *                    oReturn.DLL_NOT_FOUND -- Record not found
     *                    </pre></blockquote>
    **/
    public function decrementCurrentPointer():Object {
	    if (current==null) return oReturn.DLL_NULL_LIST;

	    if (current.prior==null) return oReturn.DLL_NOT_FOUND;

	    current = current.prior;
	    currentIndex--;

	    return oReturn.DLL_NORMAL;
	}

      // 14. storeCurrentPointer -----------------------

    /**
     * @method  storeCurrentPointer
     * @description  Saves the current pointer.
     * @usage  <pre>inst.storeCurrentPointer();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record found
     *                    oReturn.DLL_NOT_FOUND -- Record not found
     *                    </pre></blockquote>
    **/
    public function storeCurrentPointer():Object {
	    if (current==null) return oReturn.DLL_NOT_FOUND;

	    saved = current;
	    saveIndex = currentIndex;

	    return oReturn.DLL_NORMAL;
	}

      // 15. restoreCurrentPointer ---------------------

    /**
     * @method  restoreCurrentPointer
     * @description  Loads the previously saved current pointer.
     * @usage  <pre>inst.restoreCurrentPointer();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record found
     *                    oReturn.DLL_NOT_FOUND -- Record not found
     *                    </pre></blockquote>
    **/
    public function restoreCurrentPointer():Object {
	    if (saved==null) return oReturn.DLL_NOT_FOUND;

	    current = saved;
	    saved = null;
	    currentIndex = saveIndex;

	    return oReturn.DLL_NORMAL;
	}

      ////////////////////////////////////
      // List Update Functions
      ////////////////////////////////////

      // 16. addRecord ---------------------------------

    /**
     * @method  addRecord
     * @description  Creates a new node in list with or without sorting.
     * @usage  <pre>inst.addRecord(info, pFun);</pre>
     * @param   info   (Object)  -- record to add.
     * @param   pFun   (Function)  -- pointer to search function.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- node was added successfully
     *                    oReturn.DLL_MEM_ERROR -- Memory allocation failed
     *                    </pre></blockquote>
    **/
    public function addRecord(info:Object, pFun:Function):Object {
	    var newN:Object, old:Object, step:Object, newI:Object;

	    node.newN = {};
		node.old = {};
		node.step = {};
	    info.newI = {};

	    // Allocate space for new node
        if (node.newN==null) return oReturn.DLL_MEM_ERROR;

	    // Allocate space for new info
        if (info.newI==null) {
		    delete node.newN;

		    return oReturn.DLL_MEM_ERROR;
		}

	    // Put new info into allocated space
	    info.newI = info;

	    // If head is null, assume empty list and this is the 1st record.
	    if (head==null) {
		    node.newN.info = info.newI;
		    node.newN.next = null;
		    node.newN.prior = null;
		    head = node.newN;
		    tail = node.newN;
		    current = node.newN;
		    listSize = 1; //1L;                                         // *** TODO
		    currentIndex = 1; //1L;                                     // *** TODO
		    modified = true;

		    return oReturn.DLL_NORMAL;
		}

	    if (pFun!=null) {		 // If null doesn't do sort
		    node.step = head;
		    node.old = tail;

		    while (node.step!=null) {                                  // Loop through records until a match is found
			    if ((pFun(node.step.info, info.newI))>=0) break;
			    currentIndex++;
			    node.old = node.step;
			    node.step = node.step.next;
			}
		}
		else {
		    node.step = null;
		    node.old = tail;
		}

	     //
  	     // The order of the 'if' statements below is critical and
  	     // cannot be changed or a no sort (null) situation will fail.
  	     //
	    if (node.step==null) {				                        // New last record
		    node.newN.info = info.newI;
		    node.old.next = node.newN;
		    node.newN.next = null;
		    node.newN.prior = node.old;
		    tail = node.newN;
		    current = node.newN;
		}
		else {
		    if (node.step.prior==null) {	                                // New first record
			    node.newN.info = info.newI;
			    node.newN.prior = null;
			    node.newN.next = node.step;
			    node.step.prior = node.newN;
			    head = node.newN;
			    current = node.newN;
		    }
		    else {				                   // New middle record
			    node.newN.info = info.newI;
			    node.step.prior.next = node.newN;
			    node.newN.next = node.step;
			    node.newN.prior = node.step.prior;
			    node.step.prior = node.newN;
			    current = node.newN;
			}
		}

	    listSize++;
	    currentIndex++;
	    modified = true;

	    return oReturn.DLL_NORMAL;
	}

      // 17. insertRecord ------------------------------

    /**
     * @method  insertRecord
     * @description  Creates a new node in list above or below current
     *               record. The new record will be current after completion.
     * @usage  <pre>inst.insertRecord(info, dir);</pre>
     * @param   info   (Object)  -- pointer to info record.
     * @param   dir   (Object)  -- pointer to dir record.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL       -- node was added successfully
     *                    oReturn.DLL_MEM_ERROR    -- Memory allocation failed
     *                    oReturn.DLL_NOT_MODIFIED -- Insert direction is invalid (not DLL_ABOVE or DLL_BELOW)
     *                    </pre></blockquote>
    **/
    public function insertRecord(info:Object, dir:Object):Object {
	    var newN:Object, newI:Object;

	    node.newN = {};
	    info.newI = {};

	    // Allocate space for new node
        if (node.newN==null) return oReturn.DLL_MEM_ERROR;

	    // Allocate space for new info
	    if (info.newI==null) {
		    delete node.newN;

		    return oReturn.DLL_MEM_ERROR;
		}

	    // Put new info into allocated space
	    info.newI = info;

	    // If head is null, assume empty list and this is the 1st record.
	    if (head==null) {
		    node.newN.info = info.newI;
		    node.newN.next = null;
		    node.newN.prior = null;
		    head = node.newN;
		    tail = node.newN;
		    current = node.newN;
		    listSize = 1; //1L;                                         // *** TODO
		    currentIndex = 1; //1L;                                     // *** TODO
		    modified = true;

		    return oReturn.DLL_NORMAL;
		}

	    // Decide what to do according to dir
	    switch (dir) {
		    case oSrchOrigin.DLL_ABOVE:
			    node.newN.info = info.newI;
			    node.newN.next = current;
			    node.newN.prior = current.prior;

			    // If current is not at head
			    if(current.prior) current.prior.next = node.newN;

			    current.prior = node.newN;

			    // If none above new one, set head
			    if (node.newN.prior==null) head = node.newN;

			    current = node.newN;
			    break;
		    case oSrchOrigin.DLL_BELOW:
			    node.newN.info = info.newI;
			    node.newN.next = current.next;
			    node.newN.prior = current;

			    // If current is not at tail
			    if (current.next) current.next.prior = node.newN;

			    current.next = node.newN;

			    // If none below new one, set tail
			    if (node.newN.next==null) tail = node.newN;

			    current = node.newN;
			    currentIndex++;
			    break;
		    default:
			    delete info.newI;
			    delete node.newN;

			    return oReturn.DLL_NOT_MODIFIED;
			    break;
		}

	    listSize++;
	    modified = true;

	    return oReturn.DLL_NORMAL;
	}

      // 18. swapRecord --------------------------------

    /**
     * @method  swapRecord
     * @description  Swaps current record up or down one place in the list.
     *               The swapped record will still be current after completion.
     * @usage  <pre>inst.swapRecord(dir);</pre>
     * @param   dir   (Object)  -- direction to swap (DLL_ABOVE or DLL_BELOW).
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL       -- node was swapped successfully
     *                    oReturn.DLL_NULL_LIST    -- list.current is null
     *                    oReturn.DLL_NOT_MODIFIED -- Swap direction not DLL_ABOVE or DLL_BELOW
     *                    oReturn.DLL_NOT_FOUND    -- Current record is already at end of list indicated by dir
     *                    </pre></blockquote>
    **/
    public function swapRecord(dir:Object):Object {
	    var swap:Object, newPrior:Object, newNext:Object;

	    node.swap = {};
		node.newPrior = {};
	    node.newNext = {};

	    // If current is null, can't swap it
	    if (current==null) return oReturn.DLL_NULL_LIST;

	    // Decide what to do according to dir
	    switch (dir) {
		    case oSrchOrigin.DLL_ABOVE:
			    node.swap = current;

			    // current is at head
			    if (node.swap.prior==null) return oReturn.DLL_NOT_FOUND;

			    // Save current new prior and new next
			    node.newPrior = node.swap.prior.prior;
			    node.newNext = node.swap.prior;

			    // If prior node is not at head
			    if(node.newPrior!=null) node.newPrior.next = node.swap;

			    // Set up old next record's prior node
			    if (node.swap.next!=null) node.swap.next.prior = node.newNext;

			    // Set up new next record's next & prior nodes
			    node.newNext.next = node.swap.next;
			    node.newNext.prior = node.swap;

			    // Set the current record's new next & prior node
			    node.swap.prior = node.newPrior;
			    node.swap.next = node.newNext;

			    // If current is now at head, set list head
			    if (newPrior==null) list.head = swap;

			    // If current used to be at tail, set list tail
			    if (node.newNext.next==null) tail = node.newNext;

			    currentIndex--;
			    break;
		    case oSrchOrigin.DLL_BELOW:
			    node.swap = current;

			    // current is at tail
			    if (node.swap.next==null) return oReturn.DLL_NOT_FOUND;

			    // Save current new prior and new next
			    node.newPrior = node.swap.next;
			    node.newNext = node.swap.next.next;

			    // If next node is not at tail
			    if (node.newNext!=null) node.newNext.prior = node.swap;

			    // Set up old prior record's next node
			    if (node.swap.prior!=null) node.swap.prior.next = node.newPrior;

			    // Set up new prior record's next & prior nodes
			    node.newPrior.next = node.swap;
			    node.newPrior.prior = node.swap.prior;

			    // Set the current record's new next & prior node
			    node.swap.prior = node.newPrior;
			    node.swap.next = node.newNext;

			    // If current is now at tail, set list tail
			    if (node.newNext==null) tail = node.swap;

			    // If current used to be at head, set list head
			    if (node.newPrior.prior==null) head = node.newPrior;

			    currentIndex++;
			    break;
		    default:

			    return oReturn.DLL_NOT_MODIFIED;
			    break;
		}

	    modified = true;

	    return (oReturn.DLL_NORMAL);
	}

      // 19. updateCurrentRecord -----------------------

    /**
     * @method  updateCurrentRecord
     * @description  Updates current record
     * @usage  <pre>inst.updateCurrentRecord(record);</pre>
     * @param   record   (Object)  -- pointer to an info structure in list.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record updated
     *                    oReturn.DLL_NULL_LIST -- Empty list
     *                    </pre></blockquote>
    **/
    public function updateCurrentRecord(record:Object):Object {
	    if (current==null) return oReturn.DLL_NULL_LIST;
	    current.info = record;

	    return oReturn.DLL_NORMAL;
	}

      // 20. deleteCurrentRecord -----------------------

    /**
     * @method  deleteCurrentRecord
     * @description  Delete a record from the list.
     * @usage  <pre>inst.deleteCurrentRecord();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record deleted
     *                    oReturn.DLL_NULL_LIST -- List is empty
     *                    </pre></blockquote>
    **/
    public function deleteCurrentRecord():Object {
	    var oldI:Object, oldN:Object;

	    info.oldI = {};
	    node.oldN = {};

	    if (current==null) return oReturn.DLL_NULL_LIST;

	    info.oldI = current.info;
	    node.oldN = current;

	    if (current==head) {		                            // current is first record

		    // A single record in a list can't do this .. next.prior
		    if (current.next!=null) current.next.prior = null;
		    head = current.next;
		    current = head;
		}
		else {
		    if (current==tail) {	                           // current is last record
			    current.prior.next = null;
			    tail = current.prior;
			    current = tail;
			    currentIndex--;
			}
			else {							   // current is a middle record
			    current.prior.next = current.next;
			    current.next.prior = current.prior;
			    current = current.next;
			}
		}

	    delete info.oldI;
	    delete node.oldN;
	    listSize--;
	    modified = true;

	    return oReturn.DLL_NORMAL;
	}

      // 21. deleteEntireList --------------------------

    /**
     * @method  deleteEntireList
     * @description  Delete the entire list.
     * @usage  <pre>inst.deleteEntireList();</pre>
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- List deleted
     *                    oReturn.DLL_NULL_LIST -- List is empty
     *                    </pre></blockquote>
    **/
    public function deleteEntireList():Object {
	    var oldI:Object, oldN:Object;

	    info.oldI = {};
	    node.oldN = {};
	    if (head==null) return oReturn.DLL_NULL_LIST;
	    do {
		    info.oldI = head.info;
		    node.oldN = head;
		    head = head.next;
		    delete info.oldI;
		    delete node.oldN;
		}
		while (head!=null);
	    head = null;
	    tail = null;
	    current = null;
	    saved = null;
	    listSize = 0; //0L;                                             // *** TODO
	    currentIndex = 0. //0L;                                         // *** TODO
	    modified = true;
	    searchOrigin = oSrchOrigin.DLL_HEAD;
	    searchDir = oSrchDir.DLL_DOWN;

	    return oReturn.DLL_NORMAL;
	}

      ////////////////////////////////////
      // Search Functions
      ////////////////////////////////////

      // 22. findRecord --------------------------------

	/**
	 * @method  findRecord
	 * @description  Find a record in list with search criteria.
	 * @usage  <pre>inst.findRecord(record, match, pFun);</pre>
	 * @param   record   (Object)  -- pointer to an info structure in list.
	 * @param   match   (Object)  -- pointer to an info structure to match to list.
	 * @param   pFun   (Function)  -- pointer to search function.
	 * @return  (Object)  -- returns:
	 *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL        -- Record found
     *                    oReturn.DLL_NULL_LIST     -- Empty list
     *                    oReturn.DLL_NOT_FOUND     -- Record not found
     *                    oReturn.DLL_NULL_FUNCTION -- pFun is null
     *                    </pre></blockquote>
	**/
	public function findRecord(record:Object, match:Object, pFun:Function):Object {
	    var save:Number;
	    var step:Object, dir:Object;

	    node.step = {};
	    oSrchDir.dir = {};
	    info.record = record;

	    if (pFun==null) return oReturn.DLL_NULL_FUNCTION;

	    save = currentIndex;

	    switch (searchOrigin) {
		    case oSrchOrigin.DLL_CURRENT:
			    node.step = list.current;
			    oSrchDir.dir = searchDir;
			    break;
		    case oSrchOrigin.DLL_TAIL:
			    node.step = tail;
			    searchDir = oSrchDir.dir = oSrchDir.DLL_UP;
			    currentIndex = listSize;
			    break;
		    case oSrchOrigin.DLL_HEAD:
		    default:
			    searchOrigin = oSrchOrigin.DLL_HEAD;
			    node.step = head;
			    searchDir = oSrchDir.dir = oSrchDir.DLL_DOWN;
			    currentIndex = 1; //1L;                         // *** TODO
		}

	    if (step==null) return oReturn.DLL_NULL_LIST;

	    while (step!=null) {
		    if ((pFun(step.info, match))==0) {
			    info.record = node.step.info;                   // *** TODO ?
			    current = node.step;

			    return oReturn.DLL_NORMAL;
			}
		    node.step = (oSrchDir.dir==oSrchDir.DLL_DOWN) ? node.step.next : node.step.prior;
		    currentIndex += (oSrchDir.dir==oSrchDir.DLL_DOWN) ? 1 : -1;
		}

	    currentIndex = save;

	    return oReturn.DLL_NOT_FOUND;
	}

      // 23. findNthRecord -----------------------------

    /**
     * @method  findNthRecord
     * @description  Returns the Nth record in the list based on the
     *               setting of list.searchOrigin and list.searchDir.
     *               <p>
     *               NOTE: The Nth record is found based on the ordinant numbering
     *               system, in other words the current record is 0 (zero) so a
     *               skip value of 5 would return the 6th not the 5th record.
     *               Just think of 0-based array indexing.
     * @usage  <pre>inst.findNthRecord(record, skip);</pre>
     * @param   record   (Object)  -- record to hold return data.
     * @param   skip   (Number)  -- number of records to skip.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- node was found successfully
     *                    oReturn.DLL_NULL_LIST -- list.current is null
     *                    oReturn.DLL_NOT_FOUND -- Index value is too large or wrong dir value (current record index remains unchanged)
     *                    </pre></blockquote>
    **/
    public function findNthRecord(record:Object, skip:Number):Object {
	    var save:Number;
	    var nCnt:Number;
	    var step:Object, dir:Object;

	    node.step = {};
	    oSrchDir.dir = {};

	    save = currentIndex;
	    info.record = record;

	    switch (searchOrigin) {
		    case oSrchOrigin.DLL_CURRENT:
			    node.step = current;
			    oSrchDir.dir = searchDir;
			    break;
		    case oSrchOrigin.DLL_TAIL:
			    node.step = list.tail;
			    searchDir = oSrchDir.dir = oSrchDir.DLL_UP;
			    currentIndex = listSize;
			    break;
		    case oSrchOrigin.DLL_HEAD:
		    default:
			    searchOrigin = oSrchOrigin.DLL_HEAD;
			    node.step = head;
			    searchDir = oSrchDir.dir = oSrchDir.DLL_DOWN;
			    currentIndex = 1; //1L;                      // *** TODO
		}

	    if (node.step==null) return oReturn.DLL_NULL_LIST;

	    if (skip<=0 || ((oSrchDir.dir==oSrchDir.DLL_DOWN)
	                     ? (listSize<(currentIndex+skip))
	                     : (currentIndex<=skip))) {
		    currentIndex = save;

		    return oReturn.DLL_NOT_FOUND;
		}
	    switch (oSrchDir.dir) {
		    case oSrchDir.DLL_DOWN:
			    for (nCnt=0;nCnt<skip && node.step.next!=null;nCnt++) node.step = node.step.next;
			    break;
		    case oSrchDir.DLL_UP:
			    for (nCnt=0;nCnt<skip && node.step.prior!=null;nCnt++) node.step = node.step.prior;
			    break;
		    default:
			    return oReturn.DLL_NOT_FOUND;
		}
	    info.record = node.step.info;
	    current = node.step;
	    currentIndex += (oSrchDir.dir == oSrchDir.DLL_DOWN) ? (1*skip) : (-1*skip);

	    return oReturn.DLL_NORMAL;
	}

      // 24. getCurrentRecord --------------------------

    /**
     * @method  getCurrentRecord
     * @description  Gets the record pointed to by current.
     * @usage  <pre>inst.getCurrentRecord(record);</pre>
     * @param   record   (Object)  -- pointer to a pointer to an info structure.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record returned
     *                    oReturn.DLL_NULL_LIST -- List is empty
     *                    </pre></blockquote>
    **/
    public function getCurrentRecord(record:Object):Object {
        info.record = record;

	    if (current==null) return oReturn.DLL_NULL_LIST;
	    info.record = current.info;

	    return oReturn.DLL_NORMAL;
	}

      // 25. getPriorRecord ----------------------------

    /**
     * @method  getPriorRecord
     * @description  Gets the record pointed to by current.prior
     * @usage  <pre>inst.getPriorRecord(record);</pre>
     * @param   record   (Object)  -- pointer to an info structure.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record returned
     *                    oReturn.DLL_NULL_LIST -- List is empty
     *                    oReturn.DLL_NOT_FOUND -- Beginning of list
     *                    </pre></blockquote>
    **/
    public function getPriorRecord(record:Object):Object {
        info.record = record;
	    if (current==null) return oReturn.DLL_NULL_LIST;
	    if (current.prior==null) return oReturn.DLL_NOT_FOUND;
	    current = current.prior;
	    info.record = current.info;
	    currentIndex--;

	    return oReturn.DLL_NORMAL;
	}

      // 26. getNextRecord -----------------------------

    /**
     * @method  getNextRecord
     * @description  Gets the record pointed to by current.next
     * @usage  <pre>inst.getNextRecord(record);</pre>
     * @param   record   (Object)  -- pointer to an info structure.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL    -- Record returned
     *                    oReturn.DLL_NULL_LIST -- List is empty
     *                    oReturn.DLL_NOT_FOUND -- End of list
     *                    </pre></blockquote>
    **/
    public function getNextRecord(record:Object):Object {
        info.record = record;
	    if (current==null) return oReturn.DLL_NULL_LIST;
	    if (current.next==null) return oReturn.DLL_NOT_FOUND;
	    current = current.next;
	    info.record = current.info;
	    currentIndex++;

	    return oReturn.DLL_NORMAL;
	}

      // 27. toString ----------------------------------

    /**
     * @method  toString
     * @description  Save list of properties to a string.
     * @usage  <pre>inst.toString();</pre>
     * @return  (String)  -- a string consisting of a list of class properties.
    **/
    public function toString():String {
        var str:String;

        str = "    head: "+head+"\n"+
	          "    tail: "+tail+"\n"+
	          "    current: "+current+"\n"+
	          "    saved: "+saved+"\n"+
	          "    infoSize: "+infoSize+"\n"+
	          "    listSize: "+listSize+"\n"+
	          "    currentIndex: "+currentIndex+"\n"+
	          "    saveIndex "+saveIndex+"\n"+
	          "    modified: "+modified+"\n"+
	          "    searchOrigin: "+searchOrigin+"\n"+
	          "    searchDir: "+searchDir;

	     return str;
	 }


      ////////////////////////////////////
      // Input/Output Functions - not used - unsupported functions
      ////////////////////////////////////

      // 28. saveList ----------------------------------

    /**
     * @method  saveList
     * @description  Save list to disk
     * @usage  <pre>inst.saveList(path);</pre>
     * @param   path   (Object)  -- pointer to path and filename.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL       -- File written successfully
     *                    oReturn.DLL_NULL_LIST    -- List is empty
     *                    oReturn.DLL_OPEN_ERROR   -- File open error
     *                    oReturn.DLL_WRITE_ERROR  -- File write error
     *                    oReturn.DLL_NOT_MODIFIED -- Unmodified list no save was done
     *                    </pre></blockquote>
    **/
    /*function saveList(path:Object):Object {
	    var step:Object, fp:Object;

	    node.step = {};
	    FILE.fp = {};
	    if (head==null) return oReturn.DLL_NULL_LIST;
	    if (modified==false) return oReturn.DLL_NOT_MODIFIED;
	    if((FILE.fp=fopen(path, "wb"))==null) return oReturn.DLL_OPEN_ERROR; // *** TODO
	    node.step = head;
	    while (node.step!=null) {
		    if (fwrite(step.info, 1, list.infoSize, FILE.fp)!=infoSize) {                                                            // *** TODO
			    fclose(FILE.fp);                                         // *** TODO

			    return oReturn.DLL_WRITE_ERROR;
			}

		    node.step = (node *) node.step.next;                         // *** TODO
		}

	    fclose(FILE.fp);                                                 // *** TODO
	    modified = false;

	    return oReturn.DLL_NORMAL;
	}*/

      // 29. loadList ----------------------------------

    /**
     * @method  loadList
     * @description  Load list to disk.
     * @usage  <pre>inst.loadList(path, pFun);</pre>
     * @param   path   (Object)  -- pointer to path and filename.
     * @param   pFun   (Object)  -- pointer to search function.
     * @return  (Object)  -- returns:
     *                    <blockquote><pre>
     *                    oReturn.DLL_NORMAL     -- File written successfully
     *                    oReturn.DLL_MEM_ERROR  -- Memory allocation failed
     *                    oReturn.DLL_OPEN_ERROR -- File open error
     *                    oReturn.DLL_READ_ERROR -- File read error
     *                    </pre></blockquote>
    **/
    /*function loadList(path:Object, pFun:Object):Object {
	    var set:Object, fp:Object, ExitCode:Object;

	    info.set = {};
		FILE.fp = {};
	    oReturn.ExitCode = {};
	    if ((FILE.fp=fopen(path, "rb"))==null) return oReturn.DLL_OPEN_ERROR;  // *** TODO
	    this.deleteEntireList();
	    head = tail = null;
	    //if ((info.set=(info *)malloc(list.infoSize))==null) return oReturn.DLL_MEM_ERROR; // *** TODO
        if (info.set==null) return oReturn.DLL_MEM_ERROR;
	    for(;;) {
		    if (fread(set, 1, infoSize, FILE.fp)!=infoSize) {           // *** TODO
			    if (feof(FILE.fp)) oReturn.ExitCode = oReturn.DLL_NORMAL;            // *** TODO
			    else oReturn.ExitCode = oReturn.DLL_READ_ERROR;
			    break;
			}
		    if ((oReturn.ExitCode=addRecord(info.set, pFun))==oReturn.DLL_MEM_ERROR) break;
		}
	    if (!pFun) modified = false;
	    delete info.set;
	    fclose(FILE.fp);

	    return oReturn.ExitCode;
	}*/

}// class
}//package

