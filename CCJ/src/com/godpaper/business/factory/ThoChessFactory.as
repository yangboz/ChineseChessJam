package com.godpaper.business.factory
{
	import assets.EmbededAssets;

	import com.godpaper.consts.CcjConstants;
	import com.godpaper.consts.ChessPiecesConstants;
	import com.godpaper.consts.DefaultConstants;
	import com.godpaper.core.IChessPiece;
	import com.godpaper.core.IChessVO;
	import com.godpaper.model.ChessPiecesModel;
	import com.godpaper.model.vos.ConductVO;
	import com.godpaper.model.vos.OmenVO;
	import com.godpaper.model.vos.twhVO.ChessVO;
	import com.godpaper.views.components.ChessPiece;

	import flash.geom.Point;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * TwhChessFactory.as class.The two hit one chess factory.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 4:56:24 PM
	 */   	 
	public class ThoChessFactory extends ChessFactoryBase
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
		public function ThoChessFactory()
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
			var myChessPiece:ChessPiece=new ChessPiece();
			var chessPieceLabel:String="";
			var chessPieceValue:int;
			var chessPieceType:String="";
			//
			switch (position.toString())
			{
				//about blue
				case "(x=0, y=0)":
				case "(x=1, y=0)":
				case "(x=2, y=0)":
				case "(x=3, y=0)":
				case "(x=0, y=1)":
				case "(x=3, y=1)":
					chessPieceLabel=ChessPiecesConstants.BLUE.label;
					chessPieceValue=16+int(position.x);
					chessPieceType=DefaultConstants.BLUE;
					break;
				//about red
				case "(x=0, y=2)":
				case "(x=3, y=2)":
				case "(x=0, y=3)":
				case "(x=1, y=3)":
				case "(x=2, y=3)":
				case "(x=3, y=3)":
					chessPieceLabel=ChessPiecesConstants.RED.label;
					chessPieceValue=8+int(position.x);
					chessPieceType=DefaultConstants.RED;
					break;
				default:
					break;
			}
			//view
			myChessPiece.label=myChessPiece.name=chessPieceLabel;
			myChessPiece.type=chessPieceType;
			//			myChessPiece.swfLoader.source = String("./assets/").concat(chessPieceType,".swf");
			myChessPiece.swfLoader.source=EmbededAssets[chessPieceType];
			myChessPiece.swfLoader.scaleX = .6;
			myChessPiece.swfLoader.scaleY = .6;
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
			//TODO
			var oColIndex:int=conductVO.currentPosition.x;
			var oRowIndex:int=conductVO.currentPosition.y;
			var chessVO:IChessVO;
			//			LOG.info(conductVO.dump());
			switch ((conductVO.target as ChessPiece).name)
			{
				case ChessPiecesConstants.BLUE.label:
					chessVO=new ChessVO(4,4,oRowIndex, oColIndex,DefaultConstants.FLAG_BLUE);
					break;
				case ChessPiecesConstants.RED.label:
					chessVO=new ChessVO(4, 4, oRowIndex, oColIndex,DefaultConstants.FLAG_RED);
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
				case ChessPiecesConstants.BLUE.label:
					omenVO=new OmenVO(ChessPiecesConstants.BLUE_BISHOP.strength, ChessPiecesConstants.BLUE.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case ChessPiecesConstants.RED.label:
					omenVO=new OmenVO(ChessPiecesConstants.RED_BISHOP.strength, ChessPiecesConstants.RED.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
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

