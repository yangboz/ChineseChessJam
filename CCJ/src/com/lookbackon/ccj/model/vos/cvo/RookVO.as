package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.model.ZobristKeysModel;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import flash.geom.Point;
	
	import mx.logging.ILogger;
	
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class RookVO extends ChessVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		protected static const LOG:ILogger = LogUtil.getLogger(RookVO);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		public function RookVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height,rowIndex,colIndex,flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			//    *
			// ***s*****
			//    *
			//Notice:serveral admental(车越子移动/吃子问题)
			//about occupies.
			for(var r:int=0;r<this.row;r++)
			{
				this.occupies.setBitt(r,colIndex,true);
			}
			for(var c:int=0;c<this.column;c++)
			{
				this.occupies.setBitt(rowIndex,c,true);
			}
//			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
//			LOG.info("redPieces:{0}",ChessPositionModelLocator.getInstance().redPieces.dump());
//			LOG.info("bluePieces:{0}",ChessPositionModelLocator.getInstance().bluePieces.dump());
			if(flag==CcjConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().redPieces));
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().bluePieces));
			}
//			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			if(flag==CcjConstants.FLAG_RED)
			{
				blocker = this.occupies.xor(this.moves);
			}else
			{
				blocker = this.occupies.xor(this.moves);
			}
//			trace("blocker.reverse():",blocker.reverse().dump());
		    
			LOG.debug("blocker.isEmpty:{0}",blocker.isEmpty.toString());
			if(!blocker.isEmpty)
			{
				LOG.debug("blocker:{0}",blocker.dump());
				//
				var east:BitBoard = this.getEast(rowIndex,colIndex);
				var north:BitBoard = this.getNorth(rowIndex,colIndex);
				var west:BitBoard = this.getWest(rowIndex,colIndex);
				var south:BitBoard = this.getSouth(rowIndex,colIndex);
				LOG.debug("east:{0}",east.dump());
				LOG.debug("north:{0}",north.dump());
				LOG.debug("west:{0}",west.dump());
				LOG.debug("south:{0}",south.dump());
				this.moves = east.or(north.or(west.or(south)));
				LOG.debug("moves:{0}",this.moves.dump());
			}
			//about attacked captures.
			//TODO:(find Cannon moutain.)
			if(flag==CcjConstants.FLAG_RED)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().bluePieces);
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
			}
			LOG.debug("captures:{0}",this.captures.dump());
		}	
		
		//----------------------------------
		//  X-ray attacks
		//----------------------------------
		//west
		override public function getWest(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=colIndex-1;w>=0;w--)
			{
				if(this.flag==CcjConstants.FLAG_BLUE)
				{
					if(ChessPiecesModel.getInstance().bluePieces.getBitt(rowIndex,w)) break;
				}else
				{
					if(ChessPiecesModel.getInstance().redPieces.getBitt(rowIndex,w)) break;
				}
				bb.setBitt(rowIndex,w,true);
			}
			return bb;
		}
		//north
		override public function getNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var n:int=rowIndex-1;n>=0;n--)
			{
				if(this.flag==CcjConstants.FLAG_BLUE)
				{
					if(ChessPiecesModel.getInstance().bluePieces.getBitt(n,colIndex)) break;
				}else
				{
					if(ChessPiecesModel.getInstance().redPieces.getBitt(n,colIndex)) break;
				}
				bb.setBitt(n,colIndex,true);
			}
			return bb;
		}
		//east
		override public function getEast(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var e:int=colIndex+1;e<this.column;e++)
			{
				if(this.flag==CcjConstants.FLAG_BLUE)
				{
					if(ChessPiecesModel.getInstance().bluePieces.getBitt(rowIndex,e)) break;
				}else
				{
					if(ChessPiecesModel.getInstance().redPieces.getBitt(rowIndex,e)) break;
				}
				bb.setBitt(rowIndex,e,true);
			}
			return bb;
		}
		//south
		override public function getSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var s:int=rowIndex+1;s<this.row;s++)
			{
				if(this.flag==CcjConstants.FLAG_BLUE)
				{
					if(ChessPiecesModel.getInstance().bluePieces.getBitt(s,colIndex)) break;
				}else
				{
					if(ChessPiecesModel.getInstance().redPieces.getBitt(s,colIndex)) break;
				}
				bb.setBitt(s,colIndex,true);
			}
			return bb;
		}
	}
}