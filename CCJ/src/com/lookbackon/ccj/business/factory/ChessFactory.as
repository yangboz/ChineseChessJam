package com.lookbackon.ccj.business.factory
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ccj.model.vos.cvo.CannonVO;
	import com.lookbackon.ccj.model.vos.cvo.ChessVO;
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ccj.model.vos.cvo.OfficalVO;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessBoard;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ccj.view.components.IChessGasket;
	import com.lookbackon.ccj.view.components.IChessPiece;
	
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessFactory
	{
		//
		private static const LOG:ILogger  		=  LogUtil.getLogger(ChessFactory);
		
		public static const FLAG_RED:int  		= 0;
		public static const FLAG_BLUE:int 		= 1;
		public static const COLOR_RED:String 	= "red";
		public static const COLOR_BLUE:String 	= "blue";
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
			var textColor:String = COLOR_BLUE;//default is blue.
			if(chessPieceValue)
			{
				if(chessPieceValue<16)
				{
					textColor = COLOR_RED;//red
					ChessPiecesModel.getInstance().redPieces.setBitt(position[1],position[0],true);
				}else//blue
				{
					//				myChessPiece.enabled = false;
					ChessPiecesModel.getInstance().bluePieces.setBitt(position[1],position[0],true);
				}
			}
			myChessPiece.setStyle("color",textColor);
			myChessPiece.setStyle("fillColor",textColor);
			//data
			myChessPiece.position = position;
			//generateChessPieceVO
			var conductVO:ConductVO = new ConductVO();
			conductVO.target = myChessPiece;
			conductVO.newPosition = position;
			//
//			myChessPiece.chessVO = ChessFactory.generateChessPieceVO(conductVO);
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
		 * @param isInceptive a flag indicator bitBoard's value whether first inceptive.
		 * @return precise chess value object(prototype is chessVOBase).
		 * 
		 */		
		public static function generateChessPieceVO(conductVO:ConductVO,isInceptive:Boolean=false):ChessVO
		{
			var oColIndex:int = conductVO.target.position[0];
			var oRowIndex:int = conductVO.target.position[1];
			if(isInceptive)
			{
				var nColIndex:int = conductVO.newPosition[0];
				var nRowIndex:int = conductVO.newPosition[1];
			}
			var chessVO:ChessVO;
//			LOG.info(conductVO.dump());
			switch(conductVO.target.name)
			{
				case CcjConstants.BLUE_BISHOP.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().bluePieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new BishopVO(9,10,nRowIndex,nColIndex,1);
					}else
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new BishopVO(9,10,oRowIndex,oColIndex,1);
					}
					if(chessVO!=null)
					{
						LOG.info("{0}.occupies:{1}",flash.utils.getQualifiedClassName(chessVO),chessVO.occupies.dump());
						LOG.info("{0}.moves:{1}",flash.utils.getQualifiedClassName(chessVO),chessVO.moves.dump());
						LOG.info("{0}.captures:{1}",flash.utils.getQualifiedClassName(chessVO),chessVO.captures.dump());
					}
					break;
				case CcjConstants.RED_BISHOP.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().redPieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new BishopVO(9,10,nRowIndex,nColIndex);
					}else
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,true);	
						chessVO = new BishopVO(9,10,oRowIndex,oColIndex);
					}
					break;
				case CcjConstants.BLUE_CANNON.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().bluePieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new CannonVO(9,10,nRowIndex,nColIndex,1);
					}else
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new CannonVO(9,10,oRowIndex,oColIndex,1);
					}
					break;
				case CcjConstants.RED_CANNON.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().redPieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new CannonVO(9,10,nRowIndex,nColIndex);
					}else
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new CannonVO(9,10,oRowIndex,oColIndex);
					}
					break;
				case CcjConstants.BLUE_ROOK.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().bluePieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new RookVO(9,10,nRowIndex,nColIndex,1);
					}else
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new RookVO(9,10,oRowIndex,oColIndex,1);
					}
					break;
				case CcjConstants.RED_ROOK.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().redPieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new RookVO(9,10,nRowIndex,nColIndex);
					}else
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new RookVO(9,10,oRowIndex,oColIndex);
					}
					break;
				case CcjConstants.BLUE_KNIGHT.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().bluePieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new KnightVO(9,10,nRowIndex,nColIndex,1);
					}else
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new KnightVO(9,10,oRowIndex,oColIndex,1);
					}
					break;
				case CcjConstants.RED_KNIGHT.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().redPieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new KnightVO(9,10,nRowIndex,nColIndex);
					}else
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new KnightVO(9,10,oRowIndex,oColIndex);
					}
					break;
				case CcjConstants.BLUE_MARSHAL.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().bluePieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new MarshalVO(9,10,nRowIndex,nColIndex,1);
					}else
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,true);	
						chessVO = new MarshalVO(9,10,oRowIndex,oColIndex,1);
					}
					break;
				case CcjConstants.RED_MARSHAL.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().redPieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new MarshalVO(9,10,nRowIndex,nColIndex);
					}else
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new MarshalVO(9,10,oRowIndex,oColIndex);
					}
					break;
				case CcjConstants.BLUE_OFFICAL.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().bluePieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new OfficalVO(9,10,nRowIndex,nColIndex,1);
					}else
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new OfficalVO(9,10,oRowIndex,oColIndex,1);
					}
					break;
				case CcjConstants.RED_OFFICAL.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().redPieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new OfficalVO(9,10,nRowIndex,nColIndex);
					}else
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new OfficalVO(9,10,oRowIndex,oColIndex);
					}
					break;
				case CcjConstants.BLUE_PAWN.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().bluePieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new PawnVO(9,10,nRowIndex,nColIndex,1);
					}else
					{
						ChessPiecesModel.getInstance().bluePieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new PawnVO(9,10,oRowIndex,oColIndex,1);
					}
					break;
				case CcjConstants.RED_PAWN.label:
					if(isInceptive)
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,false);
						ChessPiecesModel.getInstance().redPieces.setBitt(nRowIndex,nColIndex,true);
						chessVO = new PawnVO(9,10,nRowIndex,nColIndex);
					}else
					{
						ChessPiecesModel.getInstance().redPieces.setBitt(oRowIndex,oColIndex,true);
						chessVO = new PawnVO(9,10,oRowIndex,oColIndex);
					}
					break;
				default:
					break;
			}
			return chessVO;
		}
	}
}