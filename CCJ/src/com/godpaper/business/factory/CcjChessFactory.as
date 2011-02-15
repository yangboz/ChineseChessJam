package com.godpaper.business.factory
{
	import assets.EmbededAssets;

	import com.godpaper.consts.CcjConstants;
	import com.godpaper.consts.CcjPiecesConstants;
	import com.godpaper.core.IChessPiece;
	import com.godpaper.core.IChessVO;
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.ConductVO;
	import com.godpaper.model.vos.OmenVO;
	import com.godpaper.model.vos.ccjVO.BishopVO;
	import com.godpaper.model.vos.ccjVO.CannonVO;
	import com.godpaper.model.vos.ccjVO.KnightVO;
	import com.godpaper.model.vos.ccjVO.MarshalVO;
	import com.godpaper.model.vos.ccjVO.OfficalVO;
	import com.godpaper.model.vos.ccjVO.PawnVO;
	import com.godpaper.model.vos.ccjVO.RookVO;
	import com.godpaper.views.components.ChessPiece;

	import flash.geom.Point;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * CcjChessFactory.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 4:15:49 PM
	 */
	public class CcjChessFactory extends ChessFactoryBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 

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
		public function CcjChessFactory()
		{
			//TODO: implement function
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function createChessPiece(position:Point, flag:int=0):IChessPiece
		{
			//TODO: implement function
			var myChessPiece:ChessPiece=new ChessPiece();
			var chessPieceLabel:String="";
			var chessPieceValue:int;
			var chessPieceType:String="";
			//
			switch (position.toString())
			{
				//about blue
				case "(x=0, y=0)":
				case "(x=8, y=0)":
					chessPieceLabel=CcjPiecesConstants.BLUE_ROOK.label;
					chessPieceValue=CcjPiecesConstants.BLUE_ROOK.value;
					chessPieceType=CcjConstants.BLUE_ROOK;
					break;
				case "(x=1, y=0)":
				case "(x=7, y=0)":
					chessPieceLabel=CcjPiecesConstants.BLUE_KNIGHT.label;
					chessPieceValue=CcjPiecesConstants.BLUE_KNIGHT.value;
					chessPieceType=CcjConstants.BLUE_KNIGHT;
					break;
				case "(x=2, y=0)":
				case "(x=6, y=0)":
					chessPieceLabel=CcjPiecesConstants.BLUE_BISHOP.label;
					chessPieceValue=CcjPiecesConstants.BLUE_BISHOP.value;
					chessPieceType=CcjConstants.BLUE_BISHOP;
					break;
				case "(x=3, y=0)":
				case "(x=5, y=0)":
					chessPieceLabel=CcjPiecesConstants.BLUE_OFFICAL.label;
					chessPieceValue=CcjPiecesConstants.BLUE_OFFICAL.value;
					chessPieceType=CcjConstants.BLUE_OFFICAL;
					break;
				case "(x=4, y=0)":
					chessPieceLabel=CcjPiecesConstants.BLUE_MARSHAL.label;
					chessPieceValue=CcjPiecesConstants.BLUE_MARSHAL.value;
					chessPieceType=CcjConstants.BLUE_MARSHAL;
					break;
				case "(x=1, y=2)":
				case "(x=7, y=2)":
					chessPieceLabel=CcjPiecesConstants.BLUE_CANNON.label;
					chessPieceValue=CcjPiecesConstants.BLUE_CANNON.value;
					chessPieceType=CcjConstants.BLUE_CANNON;
					break;
				case "(x=0, y=3)":
				case "(x=2, y=3)":
				case "(x=4, y=3)":
				case "(x=6, y=3)":
				case "(x=8, y=3)":
					chessPieceLabel=CcjPiecesConstants.BLUE_PAWN.label;
					chessPieceValue=CcjPiecesConstants.BLUE_PAWN.value;
					chessPieceType=CcjConstants.BLUE_PAWN;
					break;
				//about red
				case "(x=0, y=9)":
				case "(x=8, y=9)":
					chessPieceLabel=CcjPiecesConstants.RED_ROOK.label;
					chessPieceValue=CcjPiecesConstants.RED_ROOK.value;
					chessPieceType=CcjConstants.RED_ROOK;
					break;
				case "(x=1, y=9)":
				case "(x=7, y=9)":
					chessPieceLabel=CcjPiecesConstants.RED_KNIGHT.label;
					chessPieceValue=CcjPiecesConstants.RED_KNIGHT.value;
					chessPieceType=CcjConstants.RED_KNIGHT;
					break;
				case "(x=2, y=9)":
				case "(x=6, y=9)":
					chessPieceLabel=CcjPiecesConstants.RED_BISHOP.label;
					chessPieceValue=CcjPiecesConstants.RED_BISHOP.value;
					chessPieceType=CcjConstants.RED_BISHOP;
					break;
				case "(x=3, y=9)":
				case "(x=5, y=9)":
					chessPieceLabel=CcjPiecesConstants.RED_OFFICAL.label;
					chessPieceValue=CcjPiecesConstants.RED_OFFICAL.value;
					chessPieceType=CcjConstants.RED_OFFICAL;
					break;
				case "(x=4, y=9)":
					chessPieceLabel=CcjPiecesConstants.RED_MARSHAL.label;
					chessPieceValue=CcjPiecesConstants.RED_MARSHAL.value;
					chessPieceType=CcjConstants.RED_MARSHAL;
					break;
				case "(x=1, y=7)":
				case "(x=7, y=7)":
					chessPieceLabel=CcjPiecesConstants.RED_CANNON.label;
					chessPieceValue=CcjPiecesConstants.RED_CANNON.value;
					chessPieceType=CcjConstants.RED_CANNON;
					break;
				case "(x=0, y=6)":
				case "(x=2, y=6)":
				case "(x=4, y=6)":
				case "(x=6, y=6)":
				case "(x=8, y=6)":
					chessPieceLabel=CcjPiecesConstants.RED_PAWN.label;
					chessPieceValue=CcjPiecesConstants.RED_PAWN.value;
					chessPieceType=CcjConstants.RED_PAWN;
					break;
				default:
					break;
			}
			//view
			myChessPiece.label=myChessPiece.name=chessPieceLabel;
			myChessPiece.type=chessPieceType;
			//			myChessPiece.swfLoader.source = String("./assets/").concat(chessPieceType,".swf");
			myChessPiece.swfLoader.source=EmbededAssets[chessPieceType];
			/*myChessPiece.x =
			position.x*CcjConstants.BOARD_LATTICE - myChessPiece.width/2 +50;
			myChessPiece.y =
			position.y*CcjConstants.BOARD_LATTICE + myChessPiece.height/2 -25;*/
			//set flag to identify.
			myChessPiece.flag=CcjConstants.FLAG_BLUE;
			//
			if (chessPieceValue)
			{
				if (chessPieceValue < 16)
				{
					myChessPiece.flag=CcjConstants.FLAG_RED; //red
					//					ChessPiecesModel.getInstance().redPieces.setBitt(position.y,position.x,true);
					ChessPiecesModel.getInstance()[myChessPiece.type].setBitt(position.y, position.x, true);
					//push to reds collection.
					if (myChessPiece.name != "")
					{
						ChessPiecesModel.getInstance().reds.push(myChessPiece);
					}
				}
				else //blue
				{
					//myChessPiece.enabled = false;
					//					ChessPiecesModel.getInstance().bluePieces.setBitt(position.y,position.x,true);
					ChessPiecesModel.getInstance()[myChessPiece.type].setBitt(position.y, position.x, true);
					//push to blues collection.
					if (myChessPiece.name != "")
					{
						ChessPiecesModel.getInstance().blues.push(myChessPiece);
					}
				}
			}
			//avoid duplicate usless components.
			if (myChessPiece.name != "")
			{
				//data
				myChessPiece.position=position;
				return myChessPiece as IChessPiece;
			}
			return null;
		}

		//
		override public function generateChessVO(conductVO:ConductVO):IChessVO
		{
			var oColIndex:int=conductVO.currentPosition.x;
			var oRowIndex:int=conductVO.currentPosition.y;
			var chessVO:IChessVO;
			//			LOG.info(conductVO.dump());
			switch ((conductVO.target as ChessPiece).name)
			{
				case CcjPiecesConstants.BLUE_BISHOP.label:
					chessVO=new BishopVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case CcjPiecesConstants.RED_BISHOP.label:
					chessVO=new BishopVO(9, 10, oRowIndex, oColIndex);
					break;
				case CcjPiecesConstants.BLUE_CANNON.label:
					chessVO=new CannonVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case CcjPiecesConstants.RED_CANNON.label:
					chessVO=new CannonVO(9, 10, oRowIndex, oColIndex);
					break;
				case CcjPiecesConstants.BLUE_ROOK.label:
					chessVO=new RookVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case CcjPiecesConstants.RED_ROOK.label:
					chessVO=new RookVO(9, 10, oRowIndex, oColIndex);
					break;
				case CcjPiecesConstants.BLUE_KNIGHT.label:
					chessVO=new KnightVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case CcjPiecesConstants.RED_KNIGHT.label:
					chessVO=new KnightVO(9, 10, oRowIndex, oColIndex);
					break;
				case CcjPiecesConstants.BLUE_MARSHAL.label:
					chessVO=new MarshalVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case CcjPiecesConstants.RED_MARSHAL.label:
					chessVO=new MarshalVO(9, 10, oRowIndex, oColIndex);
					break;
				case CcjPiecesConstants.BLUE_OFFICAL.label:
					chessVO=new OfficalVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case CcjPiecesConstants.RED_OFFICAL.label:
					chessVO=new OfficalVO(9, 10, oRowIndex, oColIndex);
					break;
				case CcjPiecesConstants.BLUE_PAWN.label:
					chessVO=new PawnVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case CcjPiecesConstants.RED_PAWN.label:
					chessVO=new PawnVO(9, 10, oRowIndex, oColIndex);
					break;
				default:
					break;
			}
			return chessVO;
		}

		//
		override public function generateOmenVO(conductVO:ConductVO):OmenVO
		{
			var omenVO:OmenVO;
			//TODO:importance initialization.
			//			LOG.info(omenVO.dump());
			switch ((conductVO.target as ChessPiece).name)
			{
				case CcjPiecesConstants.BLUE_BISHOP.label:
					omenVO=new OmenVO(CcjPiecesConstants.BLUE_BISHOP.strength, CcjPiecesConstants.BLUE_BISHOP.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.RED_BISHOP.label:
					omenVO=new OmenVO(CcjPiecesConstants.RED_BISHOP.strength, CcjPiecesConstants.RED_BISHOP.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.BLUE_CANNON.label:
					omenVO=new OmenVO(CcjPiecesConstants.BLUE_CANNON.strength, CcjPiecesConstants.BLUE_CANNON.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.RED_CANNON.label:
					omenVO=new OmenVO(CcjPiecesConstants.RED_CANNON.strength, CcjPiecesConstants.RED_CANNON.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.BLUE_ROOK.label:
					omenVO=new OmenVO(CcjPiecesConstants.BLUE_ROOK.strength, CcjPiecesConstants.BLUE_ROOK.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.RED_ROOK.label:
					omenVO=new OmenVO(CcjPiecesConstants.RED_ROOK.strength, CcjPiecesConstants.RED_ROOK.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.BLUE_KNIGHT.label:
					omenVO=new OmenVO(CcjPiecesConstants.BLUE_KNIGHT.strength, CcjPiecesConstants.BLUE_KNIGHT.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.RED_KNIGHT.label:
					omenVO=new OmenVO(CcjPiecesConstants.RED_KNIGHT.strength, CcjPiecesConstants.RED_KNIGHT.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.BLUE_MARSHAL.label:
					omenVO=new OmenVO(CcjPiecesConstants.BLUE_MARSHAL.strength, CcjPiecesConstants.BLUE_MARSHAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.RED_MARSHAL.label:
					omenVO=new OmenVO(CcjPiecesConstants.RED_MARSHAL.strength, CcjPiecesConstants.RED_MARSHAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.BLUE_OFFICAL.label:
					omenVO=new OmenVO(CcjPiecesConstants.BLUE_OFFICAL.strength, CcjPiecesConstants.BLUE_OFFICAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.RED_OFFICAL.label:
					omenVO=new OmenVO(CcjPiecesConstants.RED_OFFICAL.strength, CcjPiecesConstants.RED_OFFICAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.BLUE_PAWN.label:
					omenVO=new OmenVO(CcjPiecesConstants.BLUE_PAWN.strength, CcjPiecesConstants.BLUE_PAWN.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case CcjPiecesConstants.RED_PAWN.label:
					omenVO=new OmenVO(CcjPiecesConstants.RED_PAWN.strength, CcjPiecesConstants.RED_PAWN.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				default:
					break;
			}
			return omenVO;
		}
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

