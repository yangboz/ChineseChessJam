package com.godpaper.model
{
	import com.lookbackon.ccj.errors.CcjErrors;
	
	import de.polygonal.ds.HashMap;
	
	import flash.display.MovieClip;
	
	import mochi.as3.MochiDigits;


	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	/**
	 * MochiModel.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 23, 2010 1:06:55 PM
	 */
	public class MochiModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _gameID:String="47de4a85dd3e213a";
		private var _boradID:String="3a460211409897f4"; //board ID (overrides setBoardID)
		//
		public var score:MochiDigits=new MochiDigits(); //the player's score to submit (integer, or time in milliseconds)
		public var name:String; //the player's name
		//
		public var storeItemsRegister:HashMap=new HashMap();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public function get hasCaptureIndicator():Boolean
		{
			return (null != storeItemsRegister.find("abfa5115d7c3dc75")); //chess piece capture indicator id.
		}
		//
		public function get hasCheckIndicator():Boolean
		{
			return (null != storeItemsRegister.find("8661560570f7f8e6")); //chess piece check indicator id.
		}
		//
		public function get gameID():String
		{
			return _gameID;
		}
		//
		public function get boradID():String
		{
			return _boradID;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
//		public function MochiModel(access:Private=null)
//		{
//			if (access != null)
//			{
//				if (instance == null)
//				{
//					instance=this;
//					//
//					score.setValue(0);
//						//
//				}
//			}
//			else
//			{
//				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
//			}
//		}
		public function MochiModel()
		{
			
		}
		/**
		 * The [Init] metadata tells Parsley to call the annotated method after 
		 * an instance of this object is created and configured.
		 */ 
		[Init]
		public function init() : void 
		{
			score.setValue(0);
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @return the singleton instance of MochiModel
		 *
		 */
//		public static function getInstance():MochiModel
//		{
//			if (instance == null)
//			{
//				instance=new MochiModel(new Private());
//			}
//			return instance;
//		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

/**
 *Inner class which restricts construtor access to Private
 */
internal class Private
{
}