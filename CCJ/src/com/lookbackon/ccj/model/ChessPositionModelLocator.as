package com.lookbackon.ccj.model
{
	import com.lookbackon.ccj.errors.CcjErrors;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	[Bindable]
	public class ChessPositionModelLocator
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ChessPositionModelLocator;
		private static var instance:ChessPositionModelLocator;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//generation.
		public var allPieces:Array2;
//		public var allPieces:Vector.<int>;
		public var player:int;//1:blue,0:red;
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPositionModelLocator(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
//					allPieces = new Vector.<int>(90,true);
					allPieces = new Array2(9,10);
				}
			} else {
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	
		/**
		 *
		 * @return the singleton instance of ChessPositionModelLocator
		 *
		 */
		public static function getInstance():ChessPositionModelLocator {
			if (instance == null) {
				instance=new ChessPositionModelLocator(new Private());
			}
			return instance;
		}

	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private {
}