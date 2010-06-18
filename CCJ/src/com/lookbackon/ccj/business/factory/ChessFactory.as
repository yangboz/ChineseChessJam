package com.lookbackon.ccj.business.factory
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.vos.ConductVO;
	import com.lookbackon.ccj.model.vos.OmenVO;
	import com.lookbackon.ccj.model.vos.cvo.BishopVO;
	import com.lookbackon.ccj.model.vos.cvo.CannonVO;
	import com.lookbackon.ccj.model.vos.cvo.ChessVO;
	import com.lookbackon.ccj.model.vos.cvo.KnightVO;
	import com.lookbackon.ccj.model.vos.cvo.MarshalVO;
	import com.lookbackon.ccj.model.vos.cvo.OfficalVO;
	import com.lookbackon.ccj.model.vos.cvo.PawnVO;
	import com.lookbackon.ccj.model.vos.cvo.RookVO;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.view.components.ChessGasket;
	import com.lookbackon.ccj.view.components.ChessPiece;
	import com.lookbackon.ccj.view.components.IChessGasket;
	import com.lookbackon.ccj.view.components.IChessPiece;
	
	import de.polygonal.ds.Array2;
	
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;

	/**
	 * Simply factory produce ChessPiece/ChessGasket/ChessVO/OmenVO.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessFactory
	{
		//
		private static const LOG:ILogger  =  LogUtil.getLogger(ChessFactory);
		
		/**
		 * 
		 * @param position chessPiece's position type is Point(x, y).
		 * @param flag chessPices's side flag.(red/blue).
		 * @return ChessPiece component with implement IChessPiece
		 * 
		 */		
		public static function createChessPiece(position:Point,flag:int=0):IChessPiece
		{
			//TODO: implement function
			var myChessPiece:ChessPiece = new ChessPiece();
			var chessPieceType:String 	= "";
			var chessPieceValue:int;
			//
			switch(position.toString())
			{
				//about blue
				case "(x=0, y=0)":
				case "(x=8, y=0)":
					chessPieceType = ChessPiecesConstants.BLUE_ROOK.label;
					chessPieceValue = ChessPiecesConstants.BLUE_ROOK.value;
					break;
				case "(x=1, y=0)":
				case "(x=7, y=0)":
					chessPieceType = ChessPiecesConstants.BLUE_KNIGHT.label;
					chessPieceValue = ChessPiecesConstants.BLUE_KNIGHT.value;
					break;
				case "(x=2, y=0)":
				case "(x=6, y=0)":
					chessPieceType = ChessPiecesConstants.BLUE_BISHOP.label;
					chessPieceValue = ChessPiecesConstants.BLUE_BISHOP.value;
					break;
				case "(x=3, y=0)":
				case "(x=5, y=0)":
					chessPieceType = ChessPiecesConstants.BLUE_OFFICAL.label;
					chessPieceValue = ChessPiecesConstants.BLUE_OFFICAL.value;
					break;
				case "(x=4, y=0)":
					chessPieceType = ChessPiecesConstants.BLUE_MARSHAL.label;
					chessPieceValue = ChessPiecesConstants.BLUE_MARSHAL.value;
					break;
				case "(x=1, y=2)":
				case "(x=7, y=2)":
					chessPieceType = ChessPiecesConstants.BLUE_CANNON.label;
					chessPieceValue = ChessPiecesConstants.BLUE_CANNON.value;
					break;
				case "(x=0, y=3)":
				case "(x=2, y=3)":
				case "(x=4, y=3)":
				case "(x=6, y=3)":
				case "(x=8, y=3)":
					chessPieceType = ChessPiecesConstants.BLUE_PAWN.label;
					chessPieceValue = ChessPiecesConstants.BLUE_PAWN.value;
					break;
				//about red
				case "(x=0, y=9)":
				case "(x=8, y=9)":
					chessPieceType = ChessPiecesConstants.RED_ROOK.label;
					chessPieceValue = ChessPiecesConstants.RED_ROOK.value;
					break;
				case "(x=1, y=9)":
				case "(x=7, y=9)":
					chessPieceType = ChessPiecesConstants.RED_KNIGHT.label;
					chessPieceValue = ChessPiecesConstants.RED_KNIGHT.value;
					break;
				case "(x=2, y=9)":
				case "(x=6, y=9)":
					chessPieceType = ChessPiecesConstants.RED_BISHOP.label;
					chessPieceValue = ChessPiecesConstants.RED_BISHOP.value;
					break;
				case "(x=3, y=9)":
				case "(x=5, y=9)":
					chessPieceType = ChessPiecesConstants.RED_OFFICAL.label;
					chessPieceValue = ChessPiecesConstants.RED_OFFICAL.value;
					break;
				case "(x=4, y=9)":
					chessPieceType = ChessPiecesConstants.RED_MARSHAL.label;
					chessPieceValue = ChessPiecesConstants.RED_MARSHAL.value;
					break;
				case "(x=1, y=7)":
				case "(x=7, y=7)":
					chessPieceType = ChessPiecesConstants.RED_CANNON.label;
					chessPieceValue = ChessPiecesConstants.RED_CANNON.value;
					break;
				case "(x=0, y=6)":
				case "(x=2, y=6)":
				case "(x=4, y=6)":
				case "(x=6, y=6)":
				case "(x=8, y=6)":
					chessPieceType = ChessPiecesConstants.RED_PAWN.label;
					chessPieceValue = ChessPiecesConstants.RED_PAWN.value;
					break;
				default:
					break;
			}
			//view
			myChessPiece.label =myChessPiece.name = chessPieceType;
			/*myChessPiece.x = 
				position.x*CcjConstants.BOARD_LATTICE - myChessPiece.width/2 +50;
			myChessPiece.y = 
				position.y*CcjConstants.BOARD_LATTICE + myChessPiece.height/2 -25;*/
			//set flag to identify.
			myChessPiece.flag = CcjConstants.FLAG_BLUE;
			//data
			myChessPiece.position = position;
			//
			if(chessPieceValue)
			{
				if(chessPieceValue<16)
				{
					myChessPiece.flag = CcjConstants.FLAG_RED;//red
					ChessPiecesModel.getInstance().redPieces.setBitt(position.y,position.x,true);
					//push to reds collection.
					if(myChessPiece.name!="")
					{
						ChessPiecesModel.getInstance().reds.addItem(myChessPiece);
					}
				}else//blue
				{
					//myChessPiece.enabled = false;
					ChessPiecesModel.getInstance().bluePieces.setBitt(position.y,position.x,true);
					//push to blues collection.
					if(myChessPiece.name!="")
					{
						ChessPiecesModel.getInstance().blues.addItem(myChessPiece);
					}
				}
			}
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
		public static function createChessGasket(position:Point):IChessGasket
		{
			//TODO: implement function
			var myChessGasket:ChessGasket = new ChessGasket();
			myChessGasket.position = position;
			myChessGasket.x = 
				position.x*CcjConstants.BOARD_LATTICE - myChessGasket.width/2 +50;
			myChessGasket.y = 
				position.y*CcjConstants.BOARD_LATTICE + myChessGasket.height/2 -25;
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
		public static function generateChessVO(conductVO:ConductVO,isInceptive:Boolean=false):ChessVO
		{
			var oColIndex:int = conductVO.target.position.x;
			var oRowIndex:int = conductVO.target.position.y;
			if(isInceptive)
			{
				var nColIndex:int = conductVO.newPosition.x;
				var nRowIndex:int = conductVO.newPosition.y;
			}
			var chessVO:ChessVO;
//			LOG.info(conductVO.dump());
			switch(conductVO.target.name)
			{
				case ChessPiecesConstants.BLUE_BISHOP.label:
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
					break;
				case ChessPiecesConstants.RED_BISHOP.label:
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
				case ChessPiecesConstants.BLUE_CANNON.label:
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
				case ChessPiecesConstants.RED_CANNON.label:
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
					if(chessVO!=null)
					{
						LOG.info("{0}.occupies:{1}",flash.utils.getQualifiedClassName(chessVO),chessVO.occupies.dump());
						LOG.info("{0}.moves:{1}",flash.utils.getQualifiedClassName(chessVO),chessVO.moves.dump());
						LOG.info("{0}.captures:{1}",flash.utils.getQualifiedClassName(chessVO),chessVO.captures.dump());
					}
					break;
				case ChessPiecesConstants.BLUE_ROOK.label:
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
				case ChessPiecesConstants.RED_ROOK.label:
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
				case ChessPiecesConstants.BLUE_KNIGHT.label:
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
				case ChessPiecesConstants.RED_KNIGHT.label:
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
				case ChessPiecesConstants.BLUE_MARSHAL.label:
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
				case ChessPiecesConstants.RED_MARSHAL.label:
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
				case ChessPiecesConstants.BLUE_OFFICAL.label:
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
				case ChessPiecesConstants.RED_OFFICAL.label:
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
				case ChessPiecesConstants.BLUE_PAWN.label:
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
				case ChessPiecesConstants.RED_PAWN.label:
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
		/**
		 * 
		 * @param conductVO has property target(type is chessPiece) and newPosition([0,1]).
		 * @return precise chess value object(prototype is OmenVO).
		 * 
		 */		
		public static function generateOmenVO(conductVO:ConductVO):OmenVO
		{
			var omenVO:OmenVO;
			//TODO:importance initialization.
			//			LOG.info(omenVO.dump());
			switch(conductVO.target.name)
			{
				case ChessPiecesConstants.BLUE_BISHOP.label:
					omenVO = new OmenVO(ChessPiecesConstants.BLUE_BISHOP.strength,ChessPiecesConstants.BLUE_BISHOP.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.RED_BISHOP.label:
					omenVO = new OmenVO(ChessPiecesConstants.RED_BISHOP.strength,ChessPiecesConstants.RED_BISHOP.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.BLUE_CANNON.label:
					omenVO = new OmenVO(ChessPiecesConstants.BLUE_CANNON.strength,ChessPiecesConstants.BLUE_CANNON.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.RED_CANNON.label:
					omenVO = new OmenVO(ChessPiecesConstants.RED_CANNON.strength,ChessPiecesConstants.RED_CANNON.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.BLUE_ROOK.label:
					omenVO = new OmenVO(ChessPiecesConstants.BLUE_ROOK.strength,ChessPiecesConstants.BLUE_ROOK.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.RED_ROOK.label:
					omenVO = new OmenVO(ChessPiecesConstants.RED_ROOK.strength,ChessPiecesConstants.RED_ROOK.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.BLUE_KNIGHT.label:
					omenVO = new OmenVO(ChessPiecesConstants.BLUE_KNIGHT.strength,ChessPiecesConstants.BLUE_KNIGHT.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.RED_KNIGHT.label:
					omenVO = new OmenVO(ChessPiecesConstants.RED_KNIGHT.strength,ChessPiecesConstants.RED_KNIGHT.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.BLUE_MARSHAL.label:
					omenVO = new OmenVO(ChessPiecesConstants.BLUE_MARSHAL.strength,ChessPiecesConstants.BLUE_MARSHAL.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.RED_MARSHAL.label:
					omenVO = new OmenVO(ChessPiecesConstants.RED_MARSHAL.strength,ChessPiecesConstants.RED_MARSHAL.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.BLUE_OFFICAL.label:
					omenVO = new OmenVO(ChessPiecesConstants.BLUE_OFFICAL.strength,ChessPiecesConstants.BLUE_OFFICAL.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.RED_OFFICAL.label:
					omenVO = new OmenVO(ChessPiecesConstants.RED_OFFICAL.strength,ChessPiecesConstants.RED_OFFICAL.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.BLUE_PAWN.label:
					omenVO = new OmenVO(ChessPiecesConstants.BLUE_PAWN.strength,ChessPiecesConstants.BLUE_PAWN.important,-1,-1,-1);
					break;
				case ChessPiecesConstants.RED_PAWN.label:
					omenVO = new OmenVO(ChessPiecesConstants.RED_PAWN.strength,ChessPiecesConstants.RED_PAWN.important,-1,-1,-1);
					break;
				default:
					break;
			}
			return omenVO;
		}
	}
}