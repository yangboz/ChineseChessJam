package com.lookbackon.ccj.business.factory
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ccj.view.components.IChessPiece;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessPieceFactory
	{
		public static function createChessPiece(chessPieceType:String):IChessPiece
		{
			var myChessPiece:ChessPiece = new ChessPiece();
			myChessPiece.name = CcjConstants.BLUE_BISHOP;
			//TODO: implement function
			/*switch(chessPieceType)
			{
				case CcjConstants.BLUE_BISHOP:
					break;
				default:
					break;
			}*/
			return myChessPiece;
		}
	}
}