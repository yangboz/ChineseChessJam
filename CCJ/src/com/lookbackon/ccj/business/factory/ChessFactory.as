package com.lookbackon.ccj.business.factory
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.ChessPositionModelLocator;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ccj.model.vos.cvo.CannonVO;
	import com.lookbackon.ccj.model.vos.cvo.ChessVO;
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ccj.model.vos.cvo.OfficalVO;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
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
		//
		public static const FLAG_RED:int  = 0;
		public static const FLAG_BLUE:int = 1;
		/**
		 * 
		 * @param position chessPiece's position in array2.
		 * @param flag chessPices's side flag.(red/blue).
		 * @return ChessPiece component with implement IChessPiece
		 * 
		 */		
		public static function createChessPiece(position:Array,flag:int=0):IChessPiece
		{
			//TODO: implement function
			var myChessPiece:ChessPiece = new ChessPiece();
			var chessPieceType:String 	= "";
			var chessPieceValue:int;
			//
			switch(position.toString())
			{
				//about blue
				case "0,0":
				case "8,0":
					chessPieceType = CcjConstants.BLUE_ROOK.label;
					chessPieceValue = CcjConstants.BLUE_ROOK.value;
					break;
				case "1,0":
				case "7,0":
					chessPieceType = CcjConstants.BLUE_KNIGHT.label;
					chessPieceValue = CcjConstants.BLUE_KNIGHT.value;
					break;
				case "2,0":
				case "6,0":
					chessPieceType = CcjConstants.BLUE_BISHOP.label;
					chessPieceValue = CcjConstants.BLUE_BISHOP.value;
					break;
				case "3,0":
				case "5,0":
					chessPieceType = CcjConstants.BLUE_OFFICAL.label;
					chessPieceValue = CcjConstants.BLUE_OFFICAL.value;
					break;
				case "4,0":
					chessPieceType = CcjConstants.BLUE_MARSHAL.label;
					chessPieceValue = CcjConstants.BLUE_MARSHAL.value;
					break;
				case "1,2":
				case "7,2":
					chessPieceType = CcjConstants.BLUE_CANNON.label;
					chessPieceValue = CcjConstants.BLUE_CANNON.value;
					break;
				case "0,3":
				case "2,3":
				case "4,3":
				case "6,3":
				case "8,3":
					chessPieceType = CcjConstants.BLUE_PAWN.label;
					chessPieceValue = CcjConstants.BLUE_PAWN.value;
					break;
				//about red
				case "0,9":
				case "8,9":
					chessPieceType = CcjConstants.RED_ROOK.label;
					chessPieceValue = CcjConstants.RED_ROOK.value;
					break;
				case "1,9":
				case "7,9":
					chessPieceType = CcjConstants.RED_KNIGHT.label;
					chessPieceValue = CcjConstants.RED_KNIGHT.value;
					break;
				case "2,9":
				case "6,9":
					chessPieceType = CcjConstants.RED_BISHOP.label;
					chessPieceValue = CcjConstants.RED_BISHOP.value;
					break;
				case "3,9":
				case "5,9":
					chessPieceType = CcjConstants.RED_OFFICAL.label;
					chessPieceValue = CcjConstants.RED_OFFICAL.value;
					break;
				case "4,9":
					chessPieceType = CcjConstants.RED_MARSHAL.label;
					chessPieceValue = CcjConstants.RED_MARSHAL.value;
					break;
				case "1,7":
				case "7,7":
					chessPieceType = CcjConstants.RED_CANNON.label;
					chessPieceValue = CcjConstants.RED_CANNON.value;
					break;
				case "0,6":
				case "2,6":
				case "4,6":
				case "6,6":
				case "8,6":
					chessPieceType = CcjConstants.RED_PAWN.label;
					chessPieceValue = CcjConstants.RED_PAWN.value;
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
			if(chessPieceValue<16)
			{
				textColor = 0x0000ff;//red
			}else
			{
//				myChessPiece.enabled = false;
			}
			myChessPiece.setStyle("color",textColor);
			myChessPiece.setStyle("fillColor",textColor);
			//data
			myChessPiece.position = position;
			//generateChessPieceVO
			var conductVO:ConductVO = new ConductVO();
			conductVO.target = myChessPiece;
			myChessPiece.chessVO = ChessFactory.generateChessPieceVO(conductVO);
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
		public static function generateChessPieceVO(conductVO:ConductVO):ChessVO
		{
			var colIndex:int = conductVO.target.position[0];
			var rowIndex:int = conductVO.target.position[1];
			var chessVO:ChessVO;
			switch(conductVO.target.name)
			{
				case CcjConstants.BLUE_BISHOP.label:
					chessVO = new BishopVO(9,10,rowIndex,colIndex,1);
					ChessPositionModelLocator.getInstance().blueRook.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.RED_BISHOP.label:
					chessVO = new BishopVO(9,10,rowIndex,colIndex);
					ChessPositionModelLocator.getInstance().redBishop.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.BLUE_CANNON.label:
					chessVO = new CannonVO(9,10,rowIndex,colIndex,1);
					ChessPositionModelLocator.getInstance().blueCannon.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.RED_CANNON.label:
					chessVO = new CannonVO(9,10,rowIndex,colIndex);
					ChessPositionModelLocator.getInstance().redCannon.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.BLUE_ROOK.label:
					chessVO = new RookVO(9,10,rowIndex,colIndex,1);
					ChessPositionModelLocator.getInstance().blueRook.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.RED_ROOK.label:
					chessVO = new RookVO(9,10,rowIndex,colIndex);
					ChessPositionModelLocator.getInstance().redRook.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.BLUE_KNIGHT.label:
					chessVO = new KnightVO(9,10,rowIndex,colIndex,1);
					ChessPositionModelLocator.getInstance().blueKnight.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.RED_KNIGHT.label:
					chessVO = new KnightVO(9,10,rowIndex,colIndex);
					ChessPositionModelLocator.getInstance().redKnight.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.BLUE_MARSHAL.label:
					chessVO = new MarshalVO(9,10,rowIndex,colIndex,1);
					ChessPositionModelLocator.getInstance().blueMarshal.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.RED_MARSHAL.label:
					chessVO = new MarshalVO(9,10,rowIndex,colIndex);
					ChessPositionModelLocator.getInstance().redMarshal.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.BLUE_OFFICAL.label:
					chessVO = new OfficalVO(9,10,rowIndex,colIndex,1);
					ChessPositionModelLocator.getInstance().blueOffical.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.RED_OFFICAL.label:
					chessVO = new OfficalVO(9,10,rowIndex,colIndex);
					ChessPositionModelLocator.getInstance().redOffical.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.BLUE_PAWN.label:
					chessVO = new PawnVO(9,10,rowIndex,colIndex,1);
					ChessPositionModelLocator.getInstance().bluePawn.setBitt(rowIndex,colIndex,true);
					break;
				case CcjConstants.RED_PAWN.label:
					chessVO = new PawnVO(9,10,rowIndex,colIndex);
					ChessPositionModelLocator.getInstance().redPawn.setBitt(rowIndex,colIndex,true);
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