package com.godpaper.ccj.business.factory
{
	import assets.EmbededAssets;

	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.godpaper.ccj.consts.CcjConstants;
	import com.godpaper.ccj.consts.CcjPiecesConstants;
	import com.godpaper.ccj.vo.BishopVO;
	import com.godpaper.ccj.vo.CannonVO;
	import com.godpaper.ccj.vo.KnightVO;
	import com.godpaper.ccj.vo.MarshalVO;
	import com.godpaper.ccj.vo.OfficalVO;
	import com.godpaper.ccj.vo.PawnVO;
	import com.godpaper.ccj.vo.RookVO;

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
			//switch custom define properties.
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
					return null;
					break;
			}
			//chess piece's swfloader source.
			this.chessPieceSource = EmbededAssets[chessPieceType];
			//call super functions.
			return super.createChessPiece(position,flag);
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

