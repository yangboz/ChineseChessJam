package com.lookbackon.ccj.model.vos.cvo
{
	import com.lookbackon.ccj.CcjConstants;
	import com.lookbackon.ccj.ChessPiecesConstants;
	import com.lookbackon.ccj.model.ChessPiecesModel;
	import com.lookbackon.ccj.utils.LogUtil;
	import com.lookbackon.ccj.utils.MathUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class CannonVO extends ChessVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		protected static const LOG:ILogger = LogUtil.getLogger(CannonVO);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		public function CannonVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			// s - *
			// -
			// *
			//about occupies.
			//serveral admental(炮隔子吃子问题)
			for(var r:int=0;r<this.row;r++)
			{
				this.occupies.setBitt(r,colIndex,true);
			}
			for(var c:int=0;c<this.column;c++)
			{
				this.occupies.setBitt(rowIndex,c,true);
			}
			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
			if(flag==CcjConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().redPieces));
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().bluePieces));
			}
//			LOG.info("moves:{0}",this.moves.dump());//not complete generated here.
			//blocker
			if(flag==CcjConstants.FLAG_RED)
			{
				blocker = this.occupies.xor(this.moves);
			}else
			{
				blocker = this.occupies.xor(this.moves);
			}
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
	}
}