package com.lookbackon.ccj.business.factory
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.ChessPositionModelLocator;
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
		 * @param position chessPiece's position in array2.
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
				case "8,0":
					chessPieceType = CcjConstants.BLUE_ROOK.label;
					break;
				case "1,0":
				case "7,0":
					chessPieceType = CcjConstants.BLUE_KNIGHT.label;
					break;
				case "2,0":
				case "6,0":
					chessPieceType = CcjConstants.BLUE_BISHOP.label;
					break;
				case "3,0":
				case "5,0":
					chessPieceType = CcjConstants.BLUE_OFFICAL.label;
					break;
				case "4,0":
					chessPieceType = CcjConstants.BLUE_MARSHAL.label;
					break;
				case "1,2":
				case "7,2":
					chessPieceType = CcjConstants.BLUE_CANNON.label;
					break;
				case "0,3":
				case "2,3":
				case "4,3":
				case "6,3":
				case "8,3":
					chessPieceType = CcjConstants.BLUE_PAWN.label;
					break;
				//about red
				case "0,9":
				case "8,9":
					chessPieceType = CcjConstants.RED_ROOK.label;
					break;
				case "1,9":
				case "7,9":
					chessPieceType = CcjConstants.RED_KNIGHT.label;
					break;
				case "2,9":
				case "6,9":
					chessPieceType = CcjConstants.RED_BISHOP.label;
					break;
				case "3,9":
				case "5,9":
					chessPieceType = CcjConstants.RED_OFFICAL.label;
					break;
				case "4,9":
					chessPieceType = CcjConstants.RED_MARSHAL.label;
					break;
				case "1,7":
				case "7,7":
					chessPieceType = CcjConstants.RED_CANNON.label;
					break;
				case "0,6":
				case "2,6":
				case "4,6":
				case "6,6":
				case "8,6":
					chessPieceType = CcjConstants.RED_PAWN.label;
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
			}else
			{
//				myChessPiece.enabled = false;
			}
			myChessPiece.setStyle("color",textColor);
			myChessPiece.setStyle("fillColor",textColor);
			//restore flag value to chess position.
			ChessPositionModelLocator.getInstance().allPieces.sett(
				position[0],
				position[1],
				generateChessPieceFlag(chessPieceType) );
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
				case CcjConstants.BLUE_BISHOP.label:
					chessVO = new BishopVO(9,10,rowIndex,colIndex,1);
					break;
				case CcjConstants.RED_BISHOP.label:
					chessVO = new BishopVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_CANNON.label:
					chessVO = new CannonVO(9,10,rowIndex,colIndex,1);
					break;
				case CcjConstants.RED_CANNON.label:
					chessVO = new CannonVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_ROOK.label:
					chessVO = new CastleVO(9,10,rowIndex,colIndex,1);
					break;
				case CcjConstants.RED_ROOK.label:
					chessVO = new CastleVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_KNIGHT.label:
					chessVO = new KnightVO(9,10,rowIndex,colIndex,1);
					break;
				case CcjConstants.RED_KNIGHT.label:
					chessVO = new KnightVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_MARSHAL.label:
					chessVO = new MarshalVO(9,10,rowIndex,colIndex,1);
					break;
				case CcjConstants.RED_MARSHAL.label:
					chessVO = new MarshalVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_OFFICAL.label:
					chessVO = new OfficalVO(9,10,rowIndex,colIndex,1);
					break;
				case CcjConstants.RED_OFFICAL.label:
					chessVO = new OfficalVO(9,10,rowIndex,colIndex);
					break;
				case CcjConstants.BLUE_PAWN.label:
					chessVO = new PawnVO(9,10,rowIndex,colIndex,1);
					break;
				case CcjConstants.RED_PAWN.label:
					chessVO = new PawnVO(9,10,rowIndex,colIndex);
					break;
				default:
					break;
			}
			return chessVO;
		}
		/**
		 * 
		 * @param chessPieceType the chess piece's type(e.g. RedPawn,BlueCannon)
		 * @return int value
		 * @private //A. 0表示空格(没有棋子)；
		 * @private //B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；
		 * @private //C. 16~22依次表示蓝方的将、士、象、马、车、炮和卒。
		 */		
		private static function generateChessPieceFlag(chessPieceType:String):int
		{
			var result:int = 0;
			switch(chessPieceType)
			{
				case CcjConstants.BLUE_BISHOP:
					result = 18;
					break;
				case CcjConstants.RED_BISHOP:
					result = 10;
					break;
				case CcjConstants.BLUE_CANNON:
					result = 21;
					break;
				case CcjConstants.RED_CANNON:
					result = 13;
					break;
				case CcjConstants.BLUE_ROOK:
					result = 20;
					break;
				case CcjConstants.RED_ROOK:
					result = 12;
					break;
				case CcjConstants.BLUE_KNIGHT:
					result = 19;
					break;
				case CcjConstants.RED_KNIGHT:
					result = 11;
					break;
				case CcjConstants.BLUE_MARSHAL:
					result = 16;
					break;
				case CcjConstants.RED_MARSHAL:
					result = 8;
					break;
				case CcjConstants.BLUE_OFFICAL:
					result = 17;
					break;
				case CcjConstants.RED_OFFICAL:
					result = 9;
					break;
				case CcjConstants.BLUE_PAWN:
					result = 22;
					break;
				case CcjConstants.RED_PAWN:
					result = 14;
					break;
				default:
					break;
			}
			return result;
		}
	}
}