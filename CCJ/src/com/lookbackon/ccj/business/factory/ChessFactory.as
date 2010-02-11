package com.lookbackon.ccj.business.factory
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.vo.BishopVO;
	import com.lookbackon.ccj.model.vo.CannonVO;
	import com.lookbackon.ccj.model.vo.CastleVO;
	import com.lookbackon.ccj.model.vo.ChessVOBase;
	import com.lookbackon.ccj.model.vo.ConductVO;
	import com.lookbackon.ccj.model.vo.KnightVO;
	import com.lookbackon.ccj.model.vo.MarshalVO;
	import com.lookbackon.ccj.model.vo.OfficalVO;
	import com.lookbackon.ccj.model.vo.PawnVO;
	import com.lookbackon.ccj.view.components.ChessBoard;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ccj.view.components.IChessGasket;
	import com.lookbackon.ccj.view.components.IChessPiece;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessFactory
	{
		/**
		 * 
		 * @param chessPieceType
		 * @return ChessPiece component with implement IChessPiece
		 * 
		 */		
		public static function createChessPiece(position:Array):IChessPiece
		{
			//TODO: implement function
			var myChessPiece:ChessPiece = new ChessPiece();
			var chessPieceType:String 	= "";
			//data
			myChessPiece.position = position;
			//
			switch(position.toString())
			{
				//about blue
				case "0,0":
					chessPieceType = CcjConstants.BLUE_CASTLE;
					break;
				case "1,0":
					chessPieceType = CcjConstants.BLUE_KNIGHT;
					break;
				case "2,0":
					chessPieceType = CcjConstants.BLUE_BISHOP;
					break;
				case "3,0":
					chessPieceType = CcjConstants.BLUE_OFFICAL;
					break;
				case "4,0":
					chessPieceType = CcjConstants.BLUE_MARSHAL;
					break;
				case "5,0":
					chessPieceType = CcjConstants.BLUE_OFFICAL;
					break;
				case "6,0":
					chessPieceType = CcjConstants.BLUE_BISHOP;
					break;
				case "7,0":
					chessPieceType = CcjConstants.BLUE_KNIGHT;
					break;
				case "8,0":
					chessPieceType = CcjConstants.BLUE_CASTLE;
					break;
				case "1,2":
					chessPieceType = CcjConstants.BLUE_CANNON;
					break;
				case "7,2":
					chessPieceType = CcjConstants.BLUE_CANNON;
					break;
				case "0,3":
					chessPieceType = CcjConstants.BLUE_PAWN;
					break;
				case "2,3":
					chessPieceType = CcjConstants.BLUE_PAWN;
					break;
				case "4,3":
					chessPieceType = CcjConstants.BLUE_PAWN;
					break;
				case "6,3":
					chessPieceType = CcjConstants.BLUE_PAWN;
					break;
				case "8,3":
					chessPieceType = CcjConstants.BLUE_PAWN;
					break;
				//about red
				case "0,9":
					chessPieceType = CcjConstants.RED_CASTLE;
					break;
				case "1,9":
					chessPieceType = CcjConstants.RED_KNIGHT;
					break;
				case "2,9":
					chessPieceType = CcjConstants.RED_BISHOP;
					break;
				case "3,9":
					chessPieceType = CcjConstants.RED_OFFICAL;
					break;
				case "4,9":
					chessPieceType = CcjConstants.RED_MARSHAL;
					break;
				case "5,9":
					chessPieceType = CcjConstants.RED_OFFICAL;
					break;
				case "6,9":
					chessPieceType = CcjConstants.RED_BISHOP;
					break;
				case "7,9":
					chessPieceType = CcjConstants.RED_KNIGHT;
					break;
				case "8,9":
					chessPieceType = CcjConstants.RED_CASTLE;
					break;
				case "1,7":
					chessPieceType = CcjConstants.RED_CANNON;
					break;
				case "7,7":
					chessPieceType = CcjConstants.RED_CANNON;
					break;
				case "0,6":
					chessPieceType = CcjConstants.RED_PAWN;
					break;
				case "2,6":
					chessPieceType = CcjConstants.RED_PAWN;
					break;
				case "4,6":
					chessPieceType = CcjConstants.RED_PAWN;
					break;
				case "6,6":
					chessPieceType = CcjConstants.RED_PAWN;
					break;
				case "8,6":
					chessPieceType = CcjConstants.RED_PAWN;
					break;
				default:
					break;
			}
			//view
			myChessPiece.label =myChessPiece.name = chessPieceType;
			myChessPiece.x = 
				position[0]*ChessBoard.LATTICE_WIDTH - myChessPiece.width/2 +50;
			myChessPiece.y = 
				position[1]*ChessBoard.LATTICE_WIDTH + myChessPiece.height/2 -25;
			//set color to identify.
			var textColor:uint = 0xff0000;//blue.
			if(myChessPiece.name.indexOf("+")!=-1)
			{
				textColor = 0x0000ff;//red	
			}
			myChessPiece.setStyle("color",textColor);
			myChessPiece.setStyle("fillColor",textColor);
			//avoid duplicate usless components.
			if(myChessPiece.name!="")
			{
				return myChessPiece;
			}
			return null;
		}
		/**
		 * 
		 * @param position
		 * @return ChessGasket component which implement IChessGasket
		 * 
		 */		
		public static function createChessGasket(position:Array):IChessGasket
		{
			//TODO: implement function
			var myChessGasket:ChessGasket = new ChessGasket();
			myChessGasket.position = position;
			myChessGasket.x = 
				position[0]*ChessBoard.LATTICE_WIDTH - myChessGasket.width/2 +50;
			myChessGasket.y = 
				position[1]*ChessBoard.LATTICE_WIDTH + myChessGasket.height/2 -25;
			myChessGasket.toolTip = position.toString();
			return myChessGasket;
		}
		/**
		 * 
		 * @param conductVO has property target(type is chessPiece) and newPosition([0,1]).
		 * @return precise chess value object(prototype is chessVOBase).
		 * 
		 */		
		public static function generateChessPieceVO(conductVO:ConductVO):ChessVOBase
		{
			var colIndex:int = conductVO.target.position[0];
			var rowIndex:int = conductVO.target.position[1];
			var chessVO:ChessVOBase;
			switch(conductVO.target.name)
			{
				case CcjConstants.BLUE_BISHOP:
				case CcjConstants.RED_BISHOP:
					chessVO = new BishopVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_CANNON:
				case CcjConstants.RED_CANNON:
					chessVO = new CannonVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_CASTLE:
				case CcjConstants.RED_CASTLE:
					chessVO = new CastleVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_KNIGHT:
				case CcjConstants.RED_KNIGHT:
					chessVO = new KnightVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_MARSHAL:
				case CcjConstants.RED_MARSHAL:
					chessVO = new MarshalVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_OFFICAL:
				case CcjConstants.RED_OFFICAL:
					chessVO = new OfficalVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_PAWN:
				case CcjConstants.RED_PAWN:
					chessVO = new PawnVO(9,10,rowIndex,colIndex);
					break;
				default:
					break;
			}
			return chessVO;
		}
	}
}